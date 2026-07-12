-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- XDG specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Toolkit backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- Nvidia
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GL_VRR_ALLOWED", "0")
hl.env("__GL_GSYNC_ALLOWED", "0")

-- Specifies which gpu to use for rendering HYPRLAND, card1(nvidia) card2(amd)
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card2")
hl.env("AQ_FORCE_LINEAR_BLIT", "0")
hl.env("AQ_MGPU_NO_EXPLICIT", "1")

-- Qt variables
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

------------------
---- MONITORS ----
------------------
local vars = require("modules.vars")

hl.monitor({
	output = vars.monitors.internal,
	mode = "preferred",
	position = "0x0",
	scale = "1.2",
})

hl.monitor({
	output = vars.monitors.external,
	mode = "1920x1080@75",
	position = "auto-right",
	scale = "1",
})
-- Handle lid closing
-- If connected to external monitor, turn off internal display
-- else sleep the laptop

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("qs -c noctalia-shell --no-duplicate")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("snappy-switcher --daemon")
	hl.exec_cmd("udiskie")
end)

-----------------------
------- MODULES -------
-----------------------
require("modules.inputs")
require("modules.binds")
require("modules.permissions")
require("modules.decorations")
require("modules.windowRules")
require("modules.misc")
