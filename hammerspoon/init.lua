--------------------------------------------------------------------------------
-- Window Navigation
--------------------------------------------------------------------------------

-- Vim easy-motion for applications
hs.hotkey.bind('alt', 'tab', hs.hints.windowHints)

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
hs.hotkey.bind({'opt', 'shift'}, 'return', spawnTerminal)

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

-- function tapHJKL()
--   print("starting tapHJKL")
--   local tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, fnArrows)
--   tap:start()
--   local isEnabled = (function () return tap:isEnabled() end)
--   hs.timer.waitWhile(isEnabled, tapHJKL, 5)
-- end
-- tapHJKL()

tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, fnArrows)
tap:start()
