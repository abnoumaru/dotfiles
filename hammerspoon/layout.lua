local M = {}

function M.centeredFrame(screen, size)
  local w = math.min(size.w, screen.w)
  local h = math.min(size.h, screen.h)
  return {
    x = screen.x + math.floor((screen.w - w) / 2),
    y = screen.y + math.floor((screen.h - h) / 2),
    w = w,
    h = h,
  }
end

function M.isExcluded(appName, excludedApps)
  for _, name in ipairs(excludedApps) do
    if name == appName then
      return true
    end
  end
  return false
end

return M
