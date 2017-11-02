hs.window.animationDuration = 0 -- disable animations
require('microphone')
require('windows')

local message = require('status-message')

hs.hotkey.bind({"command", "control"}, "return", function()
  message.new("Starting Screensaver"):notify()
  hs.caffeinate.startScreensaver()
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
message.new("Config loaded"):notify()
