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
config.window_background_opacity = 0.8

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