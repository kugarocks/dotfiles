-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

-- disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{
    args = { 'zsh', '-c', [[
      if /opt/homebrew/bin/tmux has-session 2>/dev/null; then
        exec /opt/homebrew/bin/tmux attach
      else
        exec /opt/homebrew/bin/tmux new-session
      fi
    ]] },
  }
  window:gui_window():maximize()
end)

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13
config.line_height = 1.3

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_padding = {
  left = 20,
  bottom = 0,
}

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
  [[[\w-]+-[\w]+]],
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
    key = "+",
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

