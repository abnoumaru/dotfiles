-- Pull in the wezterm API
local wezterm = require 'wezterm';
local act = wezterm.action

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

return {
  -- Visualization
  color_scheme = 'tokyonight-storm',
  window_background_opacity = 0.8,
  
  font = wezterm.font 'JetBrains Mono',
  

    -- Key maps
    leader = { key="t", mods="CTRL", timeout_milliseconds=1000 },
    keys = {
      { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen},

      { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
      { key = "q", mods = "LEADER", action = act.CloseCurrentTab{ confirm = true } },
      { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
      { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
      { key = "w", mods = "LEADER", action = act.ShowTabNavigator },

      -- { key = '-', mode = "LEADER", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    }
}
