local rules = {
	[9] = {
		name = "",
		run = "gnome-calendar"
	},
	[10] = {
		monitor = "eDP-1",
		name = "",
		run = "spotify-launcher",
	}
}

--- @param workspace HL.Workspace
local function on_workspace_creted_callback(workspace)
	if not workspace then
		return
	end

	local rule = rules[workspace.id]
	if not rule then
		return
	end

	if rule.monitor then
		hl.dispatch(hl.dsp.workspace.move({ workspace = workspace, monitor = rule.monitor }))
	end

	if rule.name then
		hl.dispatch(hl.dsp.workspace.rename({ workspace = workspace, name = rule.name }))
	end

	if not workspace.is_empty then
		return
	end

	hl.exec_cmd(rule.run)
end

hl.on("workspace.created", on_workspace_creted_callback)

hl.workspace_rule({
	workspace = "special:magic",
	gaps_out = 25,
})
