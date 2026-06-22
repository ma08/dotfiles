local mpc = "/opt/homebrew/bin/mpc"
local mpdHost = "127.0.0.1"
local mpdPort = "6600"

local function shellQuote(value)
  return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

local function mpcCommand(args)
  return table.concat({
    shellQuote(mpc),
    "-h",
    shellQuote(mpdHost),
    "-p",
    shellQuote(mpdPort),
    args,
  }, " ")
end

local function runMpc(args)
  hs.execute(mpcCommand(args) .. " >/dev/null 2>&1", true)
end

local function mpdHasQueue()
  local output, ok = hs.execute(mpcCommand("playlist"), true)
  return ok and output ~= nil and output:match("%S") ~= nil
end

local mediaActions = {
  PLAY = "toggle",
  NEXT = "next",
  PREVIOUS = "prev",
}

local ipc = require("hs.ipc")
pcall(function()
  ipc.cliInstall("/opt/homebrew", true)
end)
hs.autoLaunch(true)

local function startMpdMediaKeys()
  local mediaKeyTap = hs.eventtap.new({ hs.eventtap.event.types.systemDefined }, function(event)
    local systemKey = event:systemKey()
    if systemKey == nil then
      return false
    end

    local action = mediaActions[systemKey.key]
    if action == nil or not mpdHasQueue() then
      return false
    end

    if systemKey.down and not systemKey["repeat"] then
      runMpc(action)
    end

    return true
  end)

  mediaKeyTap:start()
  return mediaKeyTap
end

if hs.accessibilityState(true) then
  mpdMediaKeyTap = startMpdMediaKeys()
else
  hs.alert.show("Enable Accessibility for Hammerspoon to control MPD media keys")
end
