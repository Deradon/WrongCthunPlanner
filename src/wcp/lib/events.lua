WCP.LIB.Events = {}

local private = {}

-- Handle WoW Events
function WCP.LIB.Events.handle(...)
  local unknown, event_type = ...

  if(event_type == "CHAT_MSG_ADDON") then
    private.handle_chat_message_addon_event(...)
  elseif(event_type == "GROUP_ROSTER_UPDATE") then
    WCP.grid:refresh()
  else
    -- print(unknown)
    -- print(event_type)
  end
end

function private.handle_chat_message_addon_event(...)
  local _, event_type, prefix, message, dist, sender = ...

  if prefix ~= WCP.messagePrefix then return false end

  if message == "SHARE" then private.handle_share_event() end
  if message == "CHECK" then private.handle_check_event(sender) end
  if string.find(message, "CHECKRES: ") then private.handle_check_result_event(message) end
end

function private.handle_share_event()
  WCP.info("Accepting share..")
  WCP.UI.CthunFrame.show()
end

function private.handle_check_event(sender)
  WCP.addon_whisper_message("CHECKRES: " .. WCP.player_name, sender)
end

function private.handle_check_result_event(message)
  local _, start = string.find(message, "CHECKRES: ")
  local name = string.sub(message, start + 1, string.len(message))

  WCP.LIB.CheckAddon.installed(name)
end
