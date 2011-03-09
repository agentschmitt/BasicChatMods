
--[[     BCM Core     ]]--

local _, f = ...
f.functions = {}
f.fire = CreateFrame("Frame")
f.fire:RegisterEvent("PLAYER_LOGIN")
f.fire:SetScript("OnEvent", function()
	--[[ Check Database ]]--
	if type(bcmDB) ~= "table" then bcmDB = {} end
	if not bcmDB.v then
		bcmDB.v = 1
		bcmDB.BCM_AutoLog = true
		bcmDB.BCM_PlayerNames = true
	end

	--[[ Run Modules ]]--
	for i = 1, #f.functions do
		f.functions[i]()
		f.functions[i] = nil
	end

	--[[ Re-MotD ]]--
	if IsInGuild() then
		f.fire.t = GetTime()
		f.fire:SetScript("OnUpdate", function(frame)
			if (GetTime() - frame.t) > 10 then
				local info = ChatTypeInfo.GUILD
				for i=1, 10 do
					local cF = _G[("%s%d"):format("ChatFrame", i)]
					for j=1, #cF.messageTypeList do
						if cF.messageTypeList[j] == "GUILD" then
							cF:AddMessage("|cFF33FF99BasicChatMods|r: "..(GUILD_MOTD_TEMPLATE):format(GetGuildRosterMOTD()), info.r, info.g, info.b)
						end
					end
				end
				frame.t = nil
				frame:SetScript("OnUpdate", nil)
			end
		end)
	end

	--[[ Self-Cleanup ]]--
	f.functions = nil
	f.fire:UnregisterEvent("PLAYER_LOGIN")
	f.fire:SetScript("OnEvent", nil)
	f.fire = nil
end)

for i = 1, 10 do
	--Allow resizing chatframes to whatever size you wish!
	local cf = _G[format("%s%d", "ChatFrame", i)]
	cf:SetMinResize(0,0)
	cf:SetMaxResize(0,0)

	--Allow the chat frame to move to the end of the screen
	cf:SetClampRectInsets(0,0,0,0)

	--Allow arrow keys editing in the edit box
	local eb =  _G[format("%s%d%s", "ChatFrame", i, "EditBox")]
	eb:SetAltArrowKeyMode(false)
end
--Clamp the toast frame to screen to prevent it cutting out
BNToastFrame:SetClampedToScreen(true)

