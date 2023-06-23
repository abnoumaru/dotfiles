-- Pull in the wezterm API
local wezterm = require 'wezterm';
local act = wezterm.action

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
-- if wezterm.config_builder then
--   config = wezterm.config_builder()
-- end

return {
  -- Visualization
  color_scheme = 'cyberpunk',
  window_background_opacity = 0.8,
  
  font = wezterm.font 'JetBrains Mono',
  
  -- 右ステータスのカスタマイズ
  wezterm.on("update-right-status", function(window, pane)
      local cells = {};
      -- 現在のディレクトリ
      local cwd_uri = pane:get_current_working_dir()
      if cwd_uri then
        cwd_uri = cwd_uri:sub(8);
        local slash = cwd_uri:find("/")
        local cwd = ""
        local hostname = ""
        local leader = ''
        if window:leader_is_active() then
          leader = 'LEADER'
        end
        -- paneの累計IDを取得
        local pane_id = pane:pane_id()
        if slash then
          hostname = cwd_uri:sub(1, slash-1)
          local dot = hostname:find("[.]")
          if dot then
            hostname = hostname:sub(1, dot-1)
          end
          cwd = cwd_uri:sub(slash)
    
          table.insert(cells, cwd);
          table.insert(cells, pane_id);
          table.insert(cells, leader);
        end
      end
    
      -- 時刻表示
      local date = wezterm.strftime("%m/%-d %H:%M:%S %a");
      table.insert(cells, wezterm.nerdfonts.mdi_clock .. '  ' .. date);
    
      -- バッテリー
      for _, b in ipairs(wezterm.battery_info()) do
        table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
      end
    
      -- The powerline < symbol
      local LEFT_ARROW = utf8.char(0xe0b3);
      -- The filled in variant of the < symbol
      local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    
      -- Color palette for the backgrounds of each cell
      local colors = {
        "#3c1361",
        "#52307c",
        "#663a82",
        "#7c5295",
        "#b491c8",
      };
    
      -- Foreground color for the text across the fade
      local text_fg = "#c0c0c0";
    
      -- The elements to be formatted
      local elements = {};
      -- How many cells have been formatted
      local num_cells = 0;
    
      -- Translate a cell into elements
      function push(text, is_last)
        local cell_no = num_cells + 1
        table.insert(elements, {Foreground={Color=text_fg}})
        table.insert(elements, {Background={Color=colors[cell_no]}})
        table.insert(elements, {Text=" "..text.." "})
        if not is_last then
          table.insert(elements, {Foreground={Color=colors[cell_no+1]}})
          table.insert(elements, {Text=SOLID_LEFT_ARROW})
        end
        num_cells = num_cells + 1
      end
    
      while #cells > 0 do
        local cell = table.remove(cells, 1)
        push(cell, #cells == 0)
      end
    
      window:set_right_status(wezterm.format(elements));
    end);

    -- Key maps
    leader = { key="t", mods="CTRL", timeout_milliseconds=1000 },
    keys = {
      {key = 'f', mods = 'LEADER', action = wezterm.action.ToggleFullScreen,},

      { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
      { key = "q", mods = "LEADER", action = act.CloseCurrentTab{ confirm = true } },
      { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
      { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
      { key = "w", mods = "LEADER", action = act.ShowTabNavigator },
    }
}
