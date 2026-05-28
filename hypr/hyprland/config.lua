local M = {
	general = {
		gaps_in = 3,
		gaps_out = 5,

		border_size = 1,

		-- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
		col = {
			active_border = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45, },
			inactive_border = "rgba(595959aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	-- https://wiki.hypr.land/Configuring/Variables/#decoration
	decoration = {
		rounding = 8,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
		},

		-- https://wiki.hypr.land/Configuring/Variables/#blur
		blur = {
			enabled = false,
		},
	},

	-- https://wiki.hypr.land/Configuring/Variables/#animations
	animations = {
		enabled = true,
	},

	group = {
		auto_group = true,
		insert_after_current = true,
		focus_removed_window = true,
		col = {
			border_active = 0x6694e2d5,
			border_inactive = 0x66181825,
			border_locked_active = 0x66ff5500,
			border_locked_inactive = 0x66775500,
		},

		groupbar = {
			enabled = true,
			font_size = 13,
			gradients = false,
			indicator_gap = 1,
			stacked = false,
			rounding = 1,
			gradient_rounding = 3,
			round_only_edges = false,
			gradient_round_only_edges = false,
			col = {
				active = 0x6694e2d5,
				inactive = 0x66181825,
				locked_active = 0x66ff5500,
				locked_inactive = 0x66775500,
			},
		},
	},

	binds = {
		workspace_back_and_forth = false,
		allow_workspace_cycles = true,
		pass_mouse_when_bound = false,
	},

	-- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
	dwindle = {
		preserve_split = true -- You probably want this
	},

	-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
	master = {
		-- new_status = master
	},

	--- https://wiki.hypr.land/Configuring/Variables/#misc
	misc = {
		font_family = "BitstromWera Nerd Font Mono",
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_autoreload = true,
		disable_hyprland_logo = false,-- If true disables the random hyprland logo / anime girl background. :(
		vrr = 3,
		key_press_enables_dpms = true,
	},

	render = {
		new_render_scheduling = false,
	},

	--- https://wiki.hypr.land/Configuring/Variables/#input
	input = {
		kb_layout = "us,sk,dk",
		kb_variant = ",qwerty",

		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		numlock_by_default = true,

		touchpad = {
			natural_scroll = true,
		},
	},
}

return M
