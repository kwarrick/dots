--------------------------------------------------------------------------------
-- KWM integration
--------------------------------------------------------------------------------
function kwmc_(args)
    hs.task.new('/usr/local/bin/kwmc', nil, args):start()
end

function kwmc(cmd)
  local args = hs.fnutils.split(cmd, ' ', nil, true)
  return (function() kwmc_(args) end)
end

--------------------------------------------------------------------------------
-- Window navigation
--------------------------------------------------------------------------------
hs.hotkey.bind({'cmd', 'shift'}, 'j', kwmc('window -f next'))
hs.hotkey.bind({'cmd', 'shift'}, 'k', kwmc('window -f prev'))

-- Vim easy-motion for applications
hs.hotkey.bind('alt', 'tab', hs.hints.windowHints)

--------------------------------------------------------------------------------
-- Window resizing
--------------------------------------------------------------------------------
hs.hotkey.bind({'cmd', 'shift'}, 'm', kwmc('window -z fullscreen'))
hs.hotkey.bind({'cmd', 'shift'}, 'f', kwmc('window -t focused'))
hs.hotkey.bind({'cmd', 'shift'}, 'o', kwmc('window -m display next'))

-- Reproduce Awesome's resizing, which a fixed shortcut for respective
--    $ kwmc window -c reduce 0.05 focused
--    $ kwmc window -c expand 0.05 focused
-- will not affect.
hs.hotkey.bind({'cmd', 'shift'}, 'h', function()
  local window = hs.window.frontmostWindow()
  local others = window:otherWindowsSameScreen()
  local adjacent = window:windowsToEast(others, false, true)
  local direction = (#adjacent) > 0 and 'east' or 'west'
  local action = (#adjacent) > 0 and 'reduce' or 'expand'
  kwmc_{'window', '-c', action, '0.01', direction}
end)

hs.hotkey.bind({'cmd', 'shift'}, 'l', function()
  local window = hs.window.frontmostWindow()
  local others = window:otherWindowsSameScreen()
  local adjacent = window:windowsToEast(others, false, true)
  local direction = (#adjacent) > 0 and 'east' or 'west'
  local action = (#adjacent) > 0 and 'expand' or 'reduce'
  kwmc_{'window', '-c', action, '0.01', direction}
end)

--------------------------------------------------------------------------------
-- Window movement
--------------------------------------------------------------------------------
hs.hotkey.bind({'cmd', 'shift'}, 'r', kwmc('tree rotate 90'))

for i=1,6 do
  -- Move window to space `i'
  hs.hotkey.bind({'cmd', 'shift'}, '' .. i, kwmc('window -m space ' .. i))
end

-- Padding and gaps.
hs.hotkey.bind({'ctrl', 'alt'}, '-', kwmc('space -p increase all'))
hs.hotkey.bind({'ctrl', 'alt'}, '=', kwmc('space -p decrease all'))
hs.hotkey.bind({'ctrl', 'alt'}, '[', kwmc('space -g decrease all'))
hs.hotkey.bind({'ctrl', 'alt'}, ']', kwmc('space -g increase all'))

-- Floating window movements
function moveWindow(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    local rect = hs.geometry.new(x, y, w, h)
    win:moveToUnit(rect, 0) end
end
hs.hotkey.bind({'ctrl', 'alt'}, 'h', moveWindow(0, 0, 0.5, 1))
hs.hotkey.bind({'ctrl', 'alt'}, 'j', moveWindow(0, 0.5, 1, 0.5))
hs.hotkey.bind({'ctrl', 'alt'}, 'k', moveWindow(0, 0, 1, 0.5))
hs.hotkey.bind({'ctrl', 'alt'}, 'l', moveWindow(0.5, 0, 0.5, 1))
hs.hotkey.bind({'ctrl', 'alt'}, 'return', moveWindow(0, 0, 1, 1))

--------------------------------------------------------------------------------
-- Tiling modes
--------------------------------------------------------------------------------
local modes = hs.fnutils.cycle{'bsp', 'float', 'monocle'}
hs.hotkey.bind({'cmd', 'shift'}, 'space', function()
  local mode = modes()
  hs.alert.closeAll()
  hs.alert.show(mode)
  kwmc_{'space', '-t', mode}
end)
hs.hotkey.bind({'cmd', 'ctrl', 'shift'}, 'j', kwmc('window -s next'))
hs.hotkey.bind({'cmd', 'ctrl', 'shift'}, 'k', kwmc('window -s prev'))
hs.hotkey.bind({'cmd', 'ctrl', 'shift'}, 'space', kwmc('window -c type toggle'))

--------------------------------------------------------------------------------
-- Application shortcuts
--------------------------------------------------------------------------------
function spawnTerminal()
  local iterm = hs.application.find('iTerm')
  if (not iterm) then
    hs.application.launchOrFocus('iTerm')
  else
    iterm = hs.application.find('iTerm')
    iterm:selectMenuItem({'Shell', 'New Window'})
  end
end
hs.hotkey.bind({'cmd', 'shift'}, 'return', spawnTerminal)

--------------------------------------------------------------------------------
-- FN + HJKL for arrows
--------------------------------------------------------------------------------
function fnArrows(event)
  if (event:getFlags().fn) then
    if (event:getKeyCode() == hs.keycodes.map.h) then
      return true, {hs.eventtap.event.newKeyEvent({}, 'left', true)}
    elseif (event:getKeyCode() == hs.keycodes.map.j) then
      return true, {hs.eventtap.event.newKeyEvent({}, 'down', true)}
    elseif (event:getKeyCode() == hs.keycodes.map.k) then
      return true, {hs.eventtap.event.newKeyEvent({}, 'up', true)}
    elseif (event:getKeyCode() == hs.keycodes.map.l) then
      return true, {hs.eventtap.event.newKeyEvent({}, 'right', true)}
    end
  end
end
local tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, fnArrows)
tap:start()
