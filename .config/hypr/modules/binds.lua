---------------------
---- KEYBINDINGS ----
---------------------
local vars = require("modules.vars")

-- Programs
local terminal = vars.programs.terminal
local fileManager = vars.programs.fileManager
local menu = vars.programs.menu
local ipc = "qs -c noctalia-shell ipc call"

-- Key modifiers
local mainMod = "ALT"
local mainModShift = mainMod .. " + SHIFT"
local super = "SUPER"
local superShift = "SUPER + SHIFT"
local ctrlShift = "CONTROL + SHIFT"

-- Utilities
hl.bind(
	"CTRL + ALT + Delete",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Window Management
hl.bind(mainModShift .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainModShift .. " + SPACE", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.resize({ x = 800, y = 600 }))
	hl.dispatch(hl.dsp.window.center())
end)

-- Tiling Mode
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(super .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Programs Binds
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(menu))
-- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("foot -e " .. fileManager))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd([[sh -c "grim -g '$(slurp)' -t ppm - | satty -f -"]]))

-- Noctalia Binds
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(ipc .. " wallpaper toggle"))

-- Move Focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Swap Window
hl.bind(mainModShift .. " + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainModShift .. " + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainModShift .. " + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainModShift .. " + J", hl.dsp.window.swap({ direction = "down" }))

-- Resize Window
hl.bind(ctrlShift .. " + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(ctrlShift .. " + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(ctrlShift .. " + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(ctrlShift .. " + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Move Floating Window
hl.bind(superShift .. " + H", hl.dsp.window.move({ x = -65, y = 0, relative = true }), { repeating = true })
hl.bind(superShift .. " + L", hl.dsp.window.move({ x = 65, y = 0, relative = true }), { repeating = true })
hl.bind(superShift .. " + K", hl.dsp.window.move({ x = 0, y = -65, relative = true }), { repeating = true })
hl.bind(superShift .. " + J", hl.dsp.window.move({ x = 0, y = 65, relative = true }), { repeating = true })

-- Snappy Switcher (Alt Tab behavior)
hl.bind("ALT + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod alt"))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

	-- Move active window to a workspace with mainMod + SHIFT + [0-9]
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
-- hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
-- hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------------
---- LAPTOP MULTIMEDIA KEYS ----
--------------------------------
-- Volume
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media controls (requires playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
