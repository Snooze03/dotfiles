hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

------------------------------------
---- WORKSPACE AND WINDOW RULES ----
------------------------------------
local vars = require("modules.vars")

-- Workspaces 1-6 on External
for ws = 1, 6 do
	hl.workspace_rule({
		workspace = tostring(ws),
		monitor = vars.monitors.external,
		default = true,
	})
end

-- Workspaces 7-10 on Internal
for ws = 7, 10 do
	hl.workspace_rule({
		workspace = tostring(ws),
		monitor = vars.monitors.internal,
		default = true,
	})
end

-- Workspace specific programs
local programmatic_workspaces = {
	["zen"] = "1",
	["obsidian"] = "2",
	["jetbrains-idea"] = "3",
	["codium"] = "3",
}

for program, workspace in pairs(programmatic_workspaces) do
	hl.window_rule({
		match = { class = program },
		workspace = workspace,
	})
end

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- Center OnlyOffice editor popups
hl.window_rule({
	name = "center-popups",
	match = { class = "DesktopEditors" },

	float = true,
	center = true,
})

-- Center and float Blanket
hl.window_rule({
	name = "center-blanket",
	match = { class = "com.rafaelmardojai.Blanket" },

	float = true,
	center = true,
	size = { "(window_w*1.5)", "(window_h*0.9)" },
	workspace = "10",
})
