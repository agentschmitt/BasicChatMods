
--[[     Invite Links Module     ]]--

local _, f = ...
f.functions[#f.functions+1] = function()
	if bcmDB.BCM_InviteLinks then return end
--[[
	local tlds = {
		"[Cc][Oo][Mm]", "[Uu][Kk]", "[Nn][Ee][Tt]", "[Dd][Ee]", "[Ff][Rr]", "[Ee][Ss]",
		"[Bb][Ee]", "[Cc][Cc]", "[Uu][Ss]", "[Kk][Oo]", "[Cc][Hh]", "[Tt][Ww]",
		"[Cc][Nn]", "[Rr][Uu]", "[Gg][Rr]", "[Ii][Tt]", "[Ee][Uu]", "[Tt][Vv]",
		"[Nn][Ll]", "[Hh][Uu]", "[Oo][Rr][Gg]", "[Ss][Ee]", "[Nn][Oo]", "[Ff][Ii]"
	}
	local gsub = gsub
	local filterFunc = function(self, event, msg, ...)
		for i=1, 24 do --Number of TLD's in tlds table
			local newMsg, found = gsub(msg, "(%S-%."..tlds[i].."/?%S*)", "|cffffffff|Hurl:%1|h[%1]|h|r")
			if found > 0 then
				return false, newMsg, ...
			end
		end
		local newMsg, found = gsub(msg, "(%d+%.%d+%.%d+%.%d+:?%d*/?%S*)", "|cffffffff|Hurl:%1|h[%1]|h|r")
		if found > 0 then
			return false, newMsg, ...
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", filterFunc)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", filterFunc)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filterFunc)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filterFunc)

	local currentLink = nil
	local oldShow = ChatFrame_OnHyperlinkShow
	ChatFrame_OnHyperlinkShow = function(self, link, ...)
		if (link):sub(1, 3) == "url" then
			currentLink = (link):sub(5)
			StaticPopup_Show("BCM_URLCopyBox")
			return
		end
		oldShow(self, link, ...)
	end
]]
end

