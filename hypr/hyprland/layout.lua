
hl.workspace_rule({
	workspace = "special:overview",
	gaps_out = 25,
})

local function serialize_table(t, name)
	if type(t) ~= "table" then return tostring(t) end

	local res = {}
	for k, v in pairs(t) do
		local key = type(k) == "string" and string.format("[%q]", k) or tostring(k)
		local val = type(v) == "table" and serialize_table(v) or tostring(v)
		table.insert(res, string.format("%s=%s", key, val))
	end
	return "{" .. table.concat(res, ",") .. "}"
end

local function error(msg, tag)
	tag = tag or "[overview] "

	hl.notification.create({
		text = tag .. msg,
		timeout = 100000,
		color = "#a23737",
	})
end


local OverviewStateSingleton = {}

OverviewStateSingleton.__index = OverviewStateSingleton

local instance
local function new()
	local self = setmetatable({}, OverviewStateSingleton)
	self.groupped = false
	self.workspaces = {}
	self.previous_layout = nil
	return self
end

function OverviewStateSingleton:instance()
	if not instance then
		instance = new()
	end

	return instance
end

function OverviewStateSingleton:ungroup(focused_address)
	for _, ws in pairs(self.workspaces) do
		-- dbg(workspace.name)
		for _, w in ipairs(ws.windows) do
			local should_follow = focused_address ~= nil and focused_address == w.address
			hl.dispatch(
				hl.dsp.window.move({
					workspace = ws.name,
					window = w,
					follow = should_follow,
				})
			)

			if not should_follow then
				hl.dispatch(hl.dsp.window.bring_to_top({ window = w }))
			end
		end

		hl.workspace_rule({ workspace = ws.name, persistent = false })
	end
	hl.config({ general = { layout = self.previous_layout}})
	self.workspaces = {}
	self.previous_layout = nil
end

function OverviewStateSingleton:set_groupped(groupped)
	self.groupped = groupped
end

function OverviewStateSingleton:is_groupped()
	return self.groupped
end

function OverviewStateSingleton:register_workspace(ws)
	hl.workspace_rule({ workspace = ws.name, persistent = true, monitor = ws.monitor.name })
	self.workspaces[ws.id] = { name = ws.name, windows = {} }
end

function OverviewStateSingleton:add_window_to_workspace(ws, w)
	table.insert(self.workspaces[ws.id].windows, w)
end

function OverviewStateSingleton:capture_layout()
	self.previous_layout = hl.get_config("general.layout")
end

local M = {}
function M.overview()
	local overview = OverviewStateSingleton:instance()

	if overview:is_groupped() then
		local focused = hl.get_active_window()
		overview:set_groupped(not overview:is_groupped())
		overview:ungroup(focused and focused.address)

		local toggler = hl.dsp.workspace.toggle_special("overview")
		hl.dispatch(toggler)

		return
	end

	overview:set_groupped(not overview:is_groupped())
	overview:capture_layout()

	local workspaces = hl.get_workspaces()
	for _, ws in ipairs(workspaces) do
		if not ws.monitor then
			error("No monitor on this workspace")
			return
		end

		overview:register_workspace(ws)

		local windows = ws:get_windows()
		if type(windows) == "table" then
			for _, w in ipairs(windows) do
				overview:add_window_to_workspace(ws, w)

				hl.dispatch(
					hl.dsp.window.move({
						workspace = "special:overview",
						window = w,
						follow = false,
					})
				)
			end
		end
	end

	local toggler = hl.dsp.workspace.toggle_special("overview")
	hl.dispatch(toggler)

	hl.config({ general = { layout = "lua:grid"}})
end


hl.layout.register("grid", {
	recalculate = function(ctx)
		local n = #ctx.targets
		if n == 0 then
			return
		end

		local cols = math.ceil(math.sqrt(n))

		for i, target in ipairs(ctx.targets) do
			target:place(ctx:grid_cell(i, cols))
		end
	end,
})

return M
