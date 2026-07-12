----------------
----  MISC  ----
----------------
local vars = require("modules.vars")

hl.config({
	general = {
		misc = {
			force_default_wallpaper = 0,
			disable_hyprland_logo = true,
			disable_splash_rendering = true,
			vrr = 0,
			animate_manual_resizes = true,
			middle_click_paste = false,
		},

		opengl = {
			nvidia_anti_flicker = true,
		},

		xwayland = {
			force_zero_scaling = true, -- Fixes the stretching on x11 apps
		},

		cursor = {
			default_monitor = vars.monitors.external,
		},

		ecosystem = {
			no_donation_nag = true,
		},
	},
})
