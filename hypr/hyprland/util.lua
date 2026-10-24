
local M = {}

function M.string_split(str, delimiter)
	local split = {}

	str = str .. delimiter

	for word in string.gmatch(str, "(.-)"..delimiter) do
		table.insert(split, word)
	end

	return split
end

--- Parse the waybar config file and extract the modules that use signal and its values.
---@return table of signals and its values
function M.get_signals()
	local signals = {}
	local pfile = io.popen("jq -r 'to_entries[] | select(.value | type == \"object\" and has(\"signal\")) | \"\\(.key)\t\\(.value.signal)\"' ~/.config/waybar/config")
	if pfile == nil then
		return nil
	end

	for arg in pfile:lines() do
		local signal_info = M.string_split(arg, "\t")
		signals[signal_info[1]] = tonumber(signal_info[2])
	end
	pfile:close()

	return signals
end

return M

