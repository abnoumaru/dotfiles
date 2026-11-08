local layout = require("layout")

local function assertFrame(actual, expected)
  for _, k in ipairs({ "x", "y", "w", "h" }) do
    assert(actual[k] == expected[k], string.format("%s: expected %s, got %s", k, expected[k], actual[k]))
  end
end

-- A window the size of the built-in screen lands in the middle of a larger screen.
assertFrame(
  layout.centeredFrame({ x = 0, y = 0, w = 3440, h = 1440 }, { w = 1470, h = 919 }),
  { x = 985, y = 260, w = 1470, h = 919 }
)

-- The screen origin is kept, so a secondary screen placed to the right is handled.
assertFrame(
  layout.centeredFrame({ x = 1470, y = 100, w = 3440, h = 1440 }, { w = 1470, h = 919 }),
  { x = 2455, y = 360, w = 1470, h = 919 }
)

-- A window never grows past the screen it is on.
assertFrame(
  layout.centeredFrame({ x = 0, y = 37, w = 1470, h = 919 }, { w = 1728, h = 1080 }),
  { x = 0, y = 37, w = 1470, h = 919 }
)

-- Odd remainders are rounded down so the frame stays on whole pixels.
assertFrame(
  layout.centeredFrame({ x = 0, y = 0, w = 1001, h = 1001 }, { w = 1000, h = 1000 }),
  { x = 0, y = 0, w = 1000, h = 1000 }
)

assert(layout.isExcluded("Slack", { "Slack", "zoom.us" }))
assert(not layout.isExcluded("Ghostty", { "Slack", "zoom.us" }))
assert(not layout.isExcluded(nil, { "Slack" }))

print("ok")
