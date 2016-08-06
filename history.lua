
--[[     History Module     ]]--

local _, BCM = ...
BCM.modules[#BCM.modules+1] = function()
	if bcmDB.BCM_History then bcmDB.lines, bcmDB.savedChat = nil, nil end

	if not bcmDB.lines then bcmDB.lines = {["ChatFrame1"] = 1000} end
	for k, v in pairs(bcmDB.lines) do
		local f, tbl = _G[k], {}

		for i = 1, f:GetNumMessages() do
			local text, accessID, lineID, extraData = f:GetMessageInfo(i)
			local cType = ChatHistory_GetChatType(extraData)
			local info = ChatTypeInfo[cType]
			if not info then -- Message was probably printed by an addon
				for i = select("#", f:GetRegions()), 1, -1 do
					local region = select(i, f:GetRegions())
					if region:GetObjectType() == "FontString" and text == region:GetText() then
						local r, g, b = region:GetTextColor()
						tbl[#tbl+1] = {text, r, g, b, lineID, false, accessID, extraData}
						info = true
						break
					end
				end
				if not info then -- Don't think this is needed, but better safe than sorry. If we didn't find the message, print it white.
					tbl[#tbl+1] = {text, 1, 1, 1, lineID, false, accessID, extraData}
				end
			else -- Normal chat message
				tbl[#tbl+1] = {text, info.r, info.g, info.b, lineID, false, accessID, extraData}
			end
		end
		f:SetMaxLines(v) -- Set the max lines, which unfortunately clears the chat frame, resulting in all this extra chat restoration code :'(
		if k == "ChatFrame2" then
			COMBATLOG_MESSAGE_LIMIT = v -- Blizzard keeps changing the combat log max lines in Blizzard_CombatLog_Refilter... this better not taint.
		end

		--Restore all chat.
		if bcmDB.savedChat and bcmDB.savedChat[k] then
			for i = 1, #bcmDB.savedChat[k] do
				f:AddMessage(unpack(bcmDB.savedChat[k][i]))
			end
			bcmDB.savedChat[k] = nil
		end
		for i = 1, #tbl do
			f:AddMessage(unpack(tbl[i]))
		end
		tbl=nil
	end

	if true and bcmDB.savedChat and next(bcmDB.savedChat) then
		for k, v in next, bcmDB.savedChat do
			for i = 1, #v do
				_G[k]:AddMessage(unpack(v))
			end
		end
	end
	bcmDB.savedChat = nil

	if true then -- XXX add an option
		local isReloadingUI = 0

		BCM.Events.PLAYER_LOGOUT = function()
			if (GetTime() - isReloadingUI) > 2 then return end

			bcmDB.savedChat = {}
			for i = 1, BCM.chatFrames do
				local name = ("ChatFrame%d"):format(i)
				local cf = _G[name]
				if cf:IsVisible() then
					local tbl = {}
					bcmDB.savedChat[name] = tbl
					local num = cf:GetNumMessages()
					local count = num > 5 and num - 5 or 1
					for i = count, num do
						local text, accessID, lineID, extraData = cf:GetMessageInfo(i)
						local cType = ChatHistory_GetChatType(extraData)
						local info = ChatTypeInfo[cType]
						if not info then -- Message was probably printed by an addon
							for i = select("#", cf:GetRegions()), 1, -1 do
								local region = select(i, cf:GetRegions())
								if region:GetObjectType() == "FontString" and text == region:GetText() then
									local r, g, b = region:GetTextColor()
									tbl[#tbl+1] = {text, r, g, b, lineID, false, accessID, extraData}
									info = true
									break
								end
							end
							if not info then -- Don't think this is needed, but better safe than sorry. If we didn't find the message, print it white.
								tbl[#tbl+1] = {text, 1, 1, 1, lineID, false, accessID, extraData}
							end
						else -- Normal chat message
							tbl[#tbl+1] = {text, info.r, info.g, info.b, lineID, false, accessID, extraData}
						end
					end
				end
			end
		end
		BCM.Events:RegisterEvent("PLAYER_LOGOUT")

		BCM.Events.LOADING_SCREEN_ENABLED = function()
			isReloadingUI = GetTime()
		end
		BCM.Events:RegisterEvent("LOADING_SCREEN_ENABLED")
	end
end

