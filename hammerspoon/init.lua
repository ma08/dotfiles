local mpc = "/opt/homebrew/bin/mpc"
local mpdRestart = os.getenv("HOME") .. "/.local/bin/dotfiles-mpd-restart"
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

local function runMpdRestart(reason)
  local command = table.concat({
    shellQuote(mpdRestart),
    "--if-running",
    "--reason",
    shellQuote(reason),
    ">/dev/null 2>&1",
  }, " ")
  hs.execute(command, true)
end

local mpdTerminalApps = {
  ["Alacritty"] = true,
  ["Ghostty"] = true,
  ["iTerm2"] = true,
  ["kitty"] = true,
  ["Terminal"] = true,
  ["WezTerm"] = true,
  ["Warp"] = true,
}

local function mpdPlaybackState()
  local output, ok = hs.execute(mpcCommand("status"), true)
  if not ok or output == nil then
    return nil
  end

  if output:match("%[playing%]") then
    return "playing"
  end

  if output:match("%[paused%]") then
    return "paused"
  end

  return nil
end

local function frontmostAppName()
  local app = hs.application.frontmostApplication()
  if app == nil then
    return ""
  end

  return app:name() or ""
end

local function shouldHandleMpdMediaKey()
  local state = mpdPlaybackState()
  if state == "playing" then
    return true
  end

  if state == "paused" and mpdTerminalApps[frontmostAppName()] then
    return true
  end

  return false
end

function mpdMediaKeyStatus()
  return {
    frontmost = frontmostAppName(),
    handles = shouldHandleMpdMediaKey(),
    state = mpdPlaybackState(),
  }
end

local mediaActions = {
  FAST = "next",
  PLAY = "toggle",
  NEXT = "next",
  PREVIOUS = "prev",
  REWIND = "prev",
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
    if action == nil or not shouldHandleMpdMediaKey() then
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

local mpdAudioRestartTimer = nil

local function scheduleMpdAudioRestart(eventName)
  if eventName ~= "dOut" and eventName ~= "sOut" and eventName ~= "dev#" then
    return
  end

  if mpdAudioRestartTimer ~= nil then
    mpdAudioRestartTimer:stop()
  end

  mpdAudioRestartTimer = hs.timer.doAfter(2.0, function()
    local device = hs.audiodevice.defaultOutputDevice()
    local deviceName = "unknown-output"
    if device ~= nil then
      deviceName = device:name() or deviceName
    end
    runMpdRestart("audio-device-" .. eventName .. "-" .. deviceName)
  end)
end

hs.audiodevice.watcher.setCallback(scheduleMpdAudioRestart)
hs.audiodevice.watcher.start()
