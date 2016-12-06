-- KWM integration
function kwmc_(args)
    hs.task.new('/usr/local/bin/kwmc', nil, args):start()
end

function kwmc(cmd)
  local args = hs.fnutils.split(cmd, ' ', nil, true)
  return (function() kwmc_(args) end)
end

-- Window navigation
hs.hotkey.bind({'cmd', 'shift'}, 'j', kwmc('window -f next'))
hs.hotkey.bind({'cmd', 'shift'}, 'k', kwmc('window -f prev'))

-- Window resizing
hs.hotkey.bind({'cmd', 'shift'}, 'm', kwmc('window -z fullscreen'))
hs.hotkey.bind({'cmd', 'shift'}, 'f', kwmc('window -t focused'))
hs.hotkey.bind({'cmd', 'shift'}, 'o', kwmc('window -m display next'))

hs.hotkey.bind({'cmd', 'shift'}, 'h', function()
  local window = hs.window.frontmostWindow()
  local adjacent = window:windowsToEast(nil, nil, true)
  local direction = (#adjacent) > 0 and 'east' or 'west'
  local action = (#adjacent) > 0 and 'reduce' or 'expand'
  kwmc_{'window', '-c', action, '0.01', direction}
end)

hs.hotkey.bind({'cmd', 'shift'}, 'l', function()
  local window = hs.window.frontmostWindow()
  local adjacent = window:windowsToEast(nil, nil, true)
  local direction = (#adjacent) > 0 and 'east' or 'west'
  local action = (#adjacent) > 0 and 'expand' or 'reduce'
  kwmc_{'window', '-c', action, '0.01', direction}
end)

-- Window movement
hs.hotkey.bind({'cmd', 'shift'}, 'return', kwmc('tree rotate 90'))

for i=1,6 do 
  -- Move window to space `i'
  hs.hotkey.bind({'cmd', 'shift'}, '' .. i, kwmc('window -m space ' .. i))
end

-- Padding and gaps.
hs.hotkey.bind({'ctrl', 'alt'}, '-', kwmc('space -p increase all'))
hs.hotkey.bind({'ctrl', 'alt'}, '=', kwmc('space -p decrease all'))
hs.hotkey.bind({'ctrl', 'alt'}, '[', kwmc('space -g decrease all'))
hs.hotkey.bind({'ctrl', 'alt'}, ']', kwmc('space -g increase all'))

-- Tiling modes
local modes = hs.fnutils.cycle{'bsp', 'float', 'monocle'}
hs.hotkey.bind({'cmd', 'shift'}, 'space', function()
  local mode = modes()
  hs.alert.show(mode)
  kwmc_{'space', '-t', mode}
end)

-- Vim easy-motion for applications
hs.hotkey.bind('alt', 'tab', hs.hints.windowHints)
