-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

-- max fps
config.max_fps = 120

-- inactive pane
config.inactive_pane_hsb = {
  brightness = 1,
}

-- startup config
-- wezterm.on("gui-startup", function(cmd)
--    local tab, pane, window = mux.spawn_window(cmd or {})
--    window:gui_window():toggle_fullscreen()
-- end)

wezterm.on("gui-startup", function(cmd)
  -- Pick the active screen to maximize into, there are also other options, see the docs.
  local active = wezterm.gui.screens().active

  -- Set the window coords on spawn.
  local tab, pane, window = mux.spawn_window(cmd or {
    x = active.x,
    y = active.y,
    width = active.width,
    height = active.height,
  })

  -- You probably don't need both, but you can also set the positions after spawn.
  window:gui_window():set_position(active.x, active.y)
  window:gui_window():set_inner_size(active.width, active.height)
end)

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13
config.line_height = 1.2

config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.macos_window_background_blur = 10

-- my coolnight colorscheme:
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
  split = "#cccccc",
}

-- 添加 quick select patterns 配置
config.quick_select_patterns = {
  -- 匹配 k8s pod 名称模式
  -- 通常格式为: name-hash-hash (例如: nginx-7cf9cf5f8b-j5kzq)
  [[[\w-]+-[0-9a-f]+-[0-9a-z]+]]
}

config.keys = {
  -- option + left/right arrow
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},

  -- ctrl + shift + h/l/k/j
  {key="h", mods="CTRL|SHIFT", action=wezterm.action.ActivatePaneDirection("Left")},
  {key="l", mods="CTRL|SHIFT", action=wezterm.action.ActivatePaneDirection("Right")},
  {key="k", mods="CTRL|SHIFT", action=wezterm.action.ActivatePaneDirection("Up")},
  {key="j", mods="CTRL|SHIFT", action=wezterm.action.ActivatePaneDirection("Down")},

  -- split horizontal/vertical
  {
    key = "|",
    mods = "CMD|SHIFT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "-",
    mods = "CMD|SHIFT",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },

  -- quick select
  {
    key = "f",
    mods = "CMD",
    action = wezterm.action.QuickSelect,
  },
}

-- and finally, return the configuration to wezterm
return config

