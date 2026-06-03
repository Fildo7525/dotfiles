local M = {}

M.monitors = {
	{
		output = "eDP-1",
		mode = "1920x1080",
		position = "0x0",
		scale = 1,
		bitdepth = 10,
	},
	{
		output = "DP-9",
		mode = "1920x1080",
		position = "1920x0",
		scale = 1,
		bitdepth = 10,
	},
	{
		output = "HDMI-A-1",
		mode = "1920x1080",
		position = "1920x0",
		scale = 1,
		mirror = "eDP-1",
		bitdepth = 10,
	},
}

function M:setup()
	for _, m in ipairs(self.monitors) do
		hl.monitor(m)
	end
end

M:setup()

return M
