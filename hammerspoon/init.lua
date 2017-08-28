hs.window.animationDuration = 0 -- disable animations
require('microphone')
require('windows')

local message = require('status-message')

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
