hs.window.animationDuration = 0 -- disable animations

function getMaxFrame()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  return screen:frame()
end

function resizeWindow(options)
  local options = options or {}
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = getMaxFrame()

  f.x = options.x or max.x
  f.y = options.y or max.y
  f.w = options.width or max.w
  f.h = options.height or max.h
  win:setFrame(f)
end

windowMover = hs.hotkey.modal.new({"control"}, "space", "Resize Window")

function windowMover:exited()
  hs.alert.show("Resize Canceled")
end

windowMover:bind('', 'escape', function()
                   windowMover:exit()
end)

windowMover:bind('ctrl', 'g', function()
                   windowMover:exit()
end)

windowMover:bind("", "Down", function()
                   resizeWindow()
                   windowMover:exit()
end)

windowMover:bind("", "Left", function()
                   local max = getMaxFrame()
                   newWidth = max.w / 2
                   resizeWindow({ width = newWidth })
                   windowMover:exit()
end)

windowMover:bind("", "Right", function()
                   local max = getMaxFrame()
                   newWidth = max.w / 2
                   newX = max.x + (max.w / 2)
                   resizeWindow({ width = newWidth, x = newX })
                   windowMover:exit()
end)


function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
