
-------------------
--- KEYBINDINGS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Keywords/
-- local mainMod = "ALT" --Sets "ALT" key as main modifier
-- local altMod = "SUPER"

local function mainMod(keys)
	local mod = "ALT"

	if type(keys) == "string" then
		return mod .. " + " .. keys
	end

	for _,k in ipairs(keys) do
		mod = mod .. " + " .. k
	end

	return mod
end

local function altMod(keys)
	local mod = "SUPER"

	if type(keys) == "string" then
		return mod .. " + " .. keys
	end

	for _,k in ipairs(keys) do
		mod = mod .. " + " .. k
	end

	return mod
end

local terminal = "kitty"
local fileManager = "dolphin"
local menu = "pkill rofi || ~/.config/rofi/launch"
local switch_win = "pkill rofi || ~/.config/rofi/launch window"
local file_menu = "pkill rofi || ~/.config/rofi/launch filebrowser"
local locked = false

-- Use rofi to show clipboard history
hl.bind(mainMod("period"), hl.dsp.exec_cmd("~/.config/waybar/scripts/clipboard choose"))

-- Switch keyboard layout
hl.bind(mainMod("backspace"), hl.dsp.exec_cmd("hyprctl switchxkblayout current next"))
hl.bind(mainMod("backspace"), hl.dsp.exec_cmd("pkill -RTMIN+4 waybar"))

-- Take a screenshot of the entire screen
hl.bind(altMod("S"), hl.dsp.exec_cmd("flameshot full"))

-- Take a screenshot of a selected region
hl.bind(altMod({"SHIFT", "S"}), hl.dsp.exec_cmd("flameshot gui"))

-- Open Sway Notification Client
hl.bind(mainMod({"SHIFT", "N"}), hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Enter zenmode with the focused window.
hl.bind(mainMod("M"), hl.dsp.window.fullscreen({mode = "maximized", action = "toggle"}))

-- Open rofi in custom mode.
hl.bind(mainMod("TAB"), hl.dsp.exec_cmd(switch_win))
hl.bind(mainMod("F"), hl.dsp.exec_cmd(file_menu))

-- Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more

hl.bind(mainMod({"SHIFT", "C"}), hl.dsp.exec_cmd("~/.config/hypr/scripts/reload"))
hl.bind(mainMod({"SHIFT", "F"}), hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod({"SHIFT", "Q"}), hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod("D"), hl.dsp.exec_cmd(menu))
hl.bind(mainMod("E"), hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod("P"), hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod("Q"), hl.dsp.window.kill())
hl.bind(mainMod("Return"), hl.dsp.exec_cmd(terminal))
-- hl.bind(mainMod, \, togglesplit, # dwindle

-- Mute and lock the system
hl.bind(altMod("L"), function()
	hl.dispatch(hl.dsp.exec_cmd("loginctl lock-session"))
	hl.dispatch(hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 1 && hyprlock"))
end)

-- To switch between windows in a floating workspace:
-- Works with Monocle layout
hl.bind(mainMod("equal"), hl.dsp.layout("cycleprev"))
hl.bind(mainMod("minus"), hl.dsp.layout("cyclenext"))

-- Works in Master layout
hl.bind(mainMod({"SHIFT", "M"}), hl.dsp.layout("swapwithmaster"))

hl.bind(mainMod("w"), hl.dsp.exec_raw("~/.config/hypr/scripts/tabbed_worspace"))
hl.bind(mainMod("J"), hl.dsp.group.next())-- hl.dsp.group.active() changegroupactive, f)
hl.bind(mainMod("K"), hl.dsp.group.prev())
hl.bind(mainMod({"SHIFT", "L"}), function()
	locked = not locked
	hl.dispatch(hl.dsp.group.lock_active(locked))
end)

-- Power Management keymaps
hl.bind(mainMod({"SHIFT", "P"}), hl.dsp.exec_cmd("~/.config/waybar/scripts/conservation toggle"))
hl.bind(mainMod({"SHIFT", "O"}), hl.dsp.exec_cmd("~/.config/waybar/scripts/powerprofile menu"))
hl.bind(mainMod({"SHIFT", "backspace"}), hl.dsp.exec_cmd("~/dotfiles/hypr/scripts/powermenu"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod("h"), hl.dsp.focus({ direction = "left"}))
hl.bind(mainMod("j"), hl.dsp.focus({ direction = "down"}))
hl.bind(mainMod("k"), hl.dsp.focus({ direction = "up"}))
hl.bind(mainMod("l"), hl.dsp.focus({ direction = "right"}))

hl.bind(mainMod({"SHIFT", "h"}), hl.dsp.window.move({ direction = "left"}))
hl.bind(mainMod({"SHIFT", "j"}), hl.dsp.window.move({ direction = "down"}))
hl.bind(mainMod({"SHIFT", "k"}), hl.dsp.window.move({ direction = "up"}))
hl.bind(mainMod({"SHIFT", "l"}), hl.dsp.window.move({ direction = "right"}))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod("1"), hl.dsp.focus({ workspace =  "1"}))
hl.bind(mainMod("2"), hl.dsp.focus({ workspace =  "2"}))
hl.bind(mainMod("3"), hl.dsp.focus({ workspace =  "3"}))
hl.bind(mainMod("4"), hl.dsp.focus({ workspace =  "4"}))
hl.bind(mainMod("5"), hl.dsp.focus({ workspace =  "5"}))
hl.bind(mainMod("6"), hl.dsp.focus({ workspace =  "6"}))
hl.bind(mainMod("7"), hl.dsp.focus({ workspace =  "7"}))
hl.bind(mainMod("8"), hl.dsp.focus({ workspace =  "8"}))
hl.bind(mainMod("9"), hl.dsp.focus({ workspace =  "9"}))
hl.bind(mainMod("0"), hl.dsp.focus({ workspace = "10"}))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod({"SHIFT", "1"}), hl.dsp.window.move({ workspace =  "1"}))
hl.bind(mainMod({"SHIFT", "2"}), hl.dsp.window.move({ workspace =  "2"}))
hl.bind(mainMod({"SHIFT", "3"}), hl.dsp.window.move({ workspace =  "3"}))
hl.bind(mainMod({"SHIFT", "4"}), hl.dsp.window.move({ workspace =  "4"}))
hl.bind(mainMod({"SHIFT", "5"}), hl.dsp.window.move({ workspace =  "5"}))
hl.bind(mainMod({"SHIFT", "6"}), hl.dsp.window.move({ workspace =  "6"}))
hl.bind(mainMod({"SHIFT", "7"}), hl.dsp.window.move({ workspace =  "7"}))
hl.bind(mainMod({"SHIFT", "8"}), hl.dsp.window.move({ workspace =  "8"}))
hl.bind(mainMod({"SHIFT", "9"}), hl.dsp.window.move({ workspace =  "9"}))
hl.bind(mainMod({"SHIFT", "0"}), hl.dsp.window.move({ workspace = "10"}))


-- Example special workspace (scratchpad)
hl.bind(mainMod("S"), hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod({"SHIFT", "S"}), hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod("mouse_down") , hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod("next"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod("mouse_up"), hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod("prior"), hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod("mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise --max-volume 153"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower --max-volume 153"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locaked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locaked = true })
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"), { repeating = true })

hl.on("window.open", function(w)
	if w ~= nil and w.title == "Qalculate!" then
		hl.dispatch(hl.dsp.window.float({ last = true }))
		hl.dispatch(hl.dsp.window.center({ window = w }))
		hl.dispatch(hl.dsp.window.resize({ x = 800, y = 600, relative = false, window = w }))
	end
end)

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), { repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- In your hyprland.conf
hl.bind(mainMod("Space"), hl.dsp.exec_raw("~/.config/hypr/scripts/switchlayout"))

-- Gnome apps
hl.bind(mainMod('G'), hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=GNOME gnome-control-center"))

-- Gnome apps
hl.bind(mainMod('B'), hl.dsp.exec_cmd("blueman-manager"))

-- Switch to a submap called `resize`.
hl.bind(mainMod('R'), hl.dsp.submap("resize"))
hl.define_submap("resize", function()

	-- Set repeating binds for resizing the active window.
	hl.bind("right", hl.dsp.window.resize({ x = 20, y = 0, relative = true}), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -20, y = 0, relative = true}), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = 20, relative = true}), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = -20, relative = true}), { repeating = true })

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind(mainMod('R'), hl.dsp.submap("reset"))

end)

-- Keybinds further down will be global again...
