-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = {
		class = ".*",
	},

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",

	match = {
		class = "hyprland-run",
	},

	move = { "20", "monitor_h-120" },
	float = true,
})

hl.window_rule({
	name = "move-spotify",
	match = {
		-- Detected using `hyprctl clients`.
		class = "Spotify",
	},

	monitor = "eDP-1",
	workspace = "10",
})

hl.window_rule({
	name = "move-callendar",
	match = {
		initial_class = "org.gnome.Calendar",
	},

	workspace = "9",
})

hl.workspace_rule({
	workspace = "9",
	default_name = "",
	on_created_empty = "gnome-calendar"
})

hl.workspace_rule({
	workspace = "10",
	default_name = "",
	on_created_empty = "spotify-launcher",
	monitor = "eDP-1",
})

hl.workspace_rule({
	workspace = "special:magic",
	gaps_out = 25,
})
