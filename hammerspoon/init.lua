local layout = require("layout")

-- Windows of these apps are left where they were put by hand.
local excludedApps = { "Slack" }

-- Used until the built-in screen has been seen once on this Mac. 13-inch MacBook Air, minus the menu bar.
local fallbackSize = { w = 1470, h = 919 }

local function builtinScreen()
  for _, screen in ipairs(hs.screen.allScreens()) do
    if screen:name():find("Built-in", 1, true) then
      return screen
    end
  end
end

-- The built-in screen is absent in clamshell mode, so its usable size is remembered while the lid is open.
local function rememberBuiltinSize()
  local screen = builtinScreen()
  if screen then
    local frame = screen:frame()
    hs.settings.set("builtinSize", { w = frame.w, h = frame.h })
  end
end

local function windowSize()
  return hs.settings.get("builtinSize") or fallbackSize
end

local function arrange(win)
  if not win or not win:isStandard() or win:isFullScreen() then
    return
  end
  local app = win:application()
  if not app or layout.isExcluded(app:name(), excludedApps) then
    return
  end
  win:setFrame(layout.centeredFrame(win:screen():frame(), windowSize()))
end

local function arrangeAll()
  for _, win in ipairs(hs.window.allWindows()) do
    arrange(win)
  end
end

hs.autoLaunch(true)

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "c", function()
  arrange(hs.window.focusedWindow())
end)

hs.window.filter.default:subscribe(hs.window.filter.windowCreated, function(win)
  arrange(win)
end)

-- macOS keeps moving windows between screens for a moment after the configuration changes.
local screenWatcher = hs.screen.watcher.new(function()
  hs.timer.doAfter(1, function()
    rememberBuiltinSize()
    arrangeAll()
  end)
end)
screenWatcher:start()

rememberBuiltinSize()
arrangeAll()
