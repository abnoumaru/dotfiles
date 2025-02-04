-----------------------------
-- Pull in the wezterm API --
-----------------------------
local wezterm = require 'wezterm';

---------------------------------------
-- This will hold the configuration. --
---------------------------------------
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

----------------------
-- define functions --
----------------------

-- Toggle Opacity 
function toggle_opacity(window,pane)
  local overrides = window:get_config_overrides() or {}

  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.8
  elseif overrides.window_background_opacity == 0.8 then
    overrides.window_background_opacity = 1.0
  else
    overrides.window_background_opacity = 0.8
  end

  window:set_config_overrides(overrides)
end

----------------------------------------------------------
-- This is where you actually apply your config choices --
----------------------------------------------------------

-- Visualization
config.color_scheme = 'Sakura'
config.font = wezterm.font 'JetBrains Mono'
config.harfbuzz_features = { 'calt=0' }
config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"

-- tab bar
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.window_background_gradient = {
  colors = { "#000000" },
}
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#67707e"
  local foreground = "#FFFFFF"
  local edge_background = "none"

  if tab.is_active then
    background = "#33658A"
    foreground = "#FFFFFF"
  end

  local edge_foreground = background
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)


-- Key maps
local act = wezterm.action
config.leader = { key="t", mods="CTRL", timeout_milliseconds=1000 }
config.keys = {
  -- Visualizaiton
  { key = 'u', mods = 'CTRL', action = wezterm.action_callback(toggle_opacity)},
  { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen},

  -- Switch Tab
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "q", mods = "LEADER", action = act.CloseCurrentTab{ confirm = true } },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "w", mods = "LEADER", action = act.ShowTabNavigator },

  -- Split Pane
  { key = '|', mods = "LEADER", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = "LEADER", action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
}

------------------------------------------------------
-- and finally, return the configuration to wezterm --
------------------------------------------------------
return config
