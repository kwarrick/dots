-- Vim easy-motion for applications.
hs.hotkey.bind("alt", "tab", hs.hints.windowHints)

-- Application shortcuts.
hs.hotkey.bind({"cmd", "shift"}, "1", function()
  hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"cmd", "shift"}, "2", function()
  hs.application.launchOrFocus("Google Chrome")
end)

-- Window movements (simple).
function moveWindow(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    local rect = hs.geometry.new(x, y, w, h)
    win:moveToUnit(rect, 0) end
end
hs.hotkey.bind({'cmd', 'shift'}, 'h', moveWindow(0, 0, 0.5, 1))
-- hs.hotkey.bind({'cmd', 'shift'}, 'j', moveWindow(0, 0.5, 1, 0.5))
-- hs.hotkey.bind({'cmd', 'shift'}, 'k', moveWindow(0, 0, 1, 0.5))
hs.hotkey.bind({'cmd', 'shift'}, 'l', moveWindow(0.5, 0, 0.5, 1))
hs.hotkey.bind({'cmd', 'shift'}, 'return', moveWindow(0, 0, 1, 1))

-- Window movement and navigation (complex).

-- disable animation
hs.window.animationDuration = 0

-- no window margins
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

-- initial grid dimensions
hs.grid.GRIDWIDTH = 7
hs.grid.GRIDHEIGHT = 3

-- show grid
hs.hotkey.bind({'cmd', 'alt'}, '/', hs.grid.show)

-- snap to grid
hs.hotkey.bind({'cmd', 'alt'}, ';', function()
  hs.grid.snap(hs.window.focusedWindow())
end)
hs.hotkey.bind({'cmd', 'alt'}, "'", function()
  hs.fnutil.map(hs.window.visibleWindows(), hs.grid.snap)
end)

-- adjust grid size
hs.hotkey.bind({'cmd', 'alt'}, '=', function() hs.grid.adjustWidth( 1) end)
hs.hotkey.bind({'cmd', 'alt'}, '-', function() hs.grid.adjustWidth(-1) end)
hs.hotkey.bind({'cmd', 'alt'}, ']', function() hs.grid.adjustHeight( 1) end)
hs.hotkey.bind({'cmd', 'alt'}, '[', function() hs.grid.adjustHeight(-1) end)

-- resize windows
hs.hotkey.bind({'cmd', 'alt'}, 'h', hs.grid.resizeWindowThinner)
hs.hotkey.bind({'cmd', 'alt'}, 'j', hs.grid.resizeWindowShorter)
hs.hotkey.bind({'cmd', 'alt'}, 'k', hs.grid.resizeWindowTaller)
hs.hotkey.bind({'cmd', 'alt'}, 'l', hs.grid.resizeWindowWider)

-- move windows
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'h', hs.grid.pushWindowLeft)
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'j', hs.grid.pushWindowDown)
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'k', hs.grid.pushWindowUp)
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'l', hs.grid.pushWindowRight)

-- focus window next/prev
hs.hotkey.bind({'cmd', 'shift'}, 'j', function()
  local windows = hs.window.filter.new()
    :setCurrentSpace(true)
    :setSortOrder(hs.window.filter.sortByCreated)
    :getWindows()
  local current = hs.window.frontmostWindow()
  local i = hs.fnutils.indexOf(windows, current) or 1
  windows[i % (#windows) + 1]:focus()
end)

hs.hotkey.bind({'cmd', 'shift'}, 'k', function()
  local windows = hs.window.filter.new()
    :setCurrentSpace(true)
    :setSortOrder(hs.window.filter.sortByFocused)
    :getWindows()
  windows[2]:focus()
end)

-- move window to next screen
hs.hotkey.bind({'cmd', 'shift'}, 'o', hs.grid.pushWindowNextScreen)

-- maximize
hs.hotkey.bind({'cmd', 'shift'}, 'm', hs.grid.maximizeWindow)
