
-- Configuration file for SCM.
--
-- SMC_BUTTONS_SHOW_UP = nil
-- SMC_BUTTONS_SHOW_DOWN = nil
-- SMC_BUTTONS_SHOW_BOTTOM = nil
-- scmButtons:Disable()
--
--[[
SCM_CHANNELNAMES_REGEXPS = {
	["%[Guild%]"] = "(G)",
	["%[Party%]"] = "(P)",
	["%[Raid%]"] = "(R)",
	["%[Raid Leader%]"] = "|cffff3399(|rRL|cffff3399)|r",
	["%[Raid Warning%]"] = "|cffff0000(|rRW|cffff0000)|r",
	["%[Officer%]"] = "(O)",
	["%[%d+%. WorldDefense%]"] = "|cff990066(|rWD|cff990066)|r",
	["%[%d+%. General.-%]"] = "|cff990066(|rGEN|cff990066)|r",
	["%[%d+%. LocalDefense.-%]"] = "|cff990066(|rLD|cff990066)|r",
	["%[%d+%. Trade.-%]"] = "|cff990066(|rT|cff990066)|r",
	["%[Battleground%]"] = "|cffff3399(|rBG|cffff3399)|r",
	["%[Battleground Leader%]"] = "|cffff0000(|rBGL|cffff0000)|r",
	["%[%d+%.%s(.-)%]"] = "|cff990066(|r%1|cff990066)|r",
}
]]
-- scmChannelnames:UnhookAll()
--
-- scmEditbox:Disable()
-- scmEditboxAltKey:Disable()

-- SCM_PLAYERNAMES_LEFTBRACKET = "<"
-- SCM_PLAYERNAMES_RIGHTBRACKET = ">"
-- SCM_PLAYERNAMES_MOUSEOVER = true
--
-- scmPlayernames:UnregisterAllEvents()
-- scmPlayernames:UnhookAll()

-- SCM_DISABLE_MOUSE_SCROLL = nil
-- SCM_SCROLL_LINES = 1
-- scmScroll:Disable()

-- scmTellTarget:Disable()
--
-- SCM_TIMESTAMP_FORMAT = "%X"
-- SCM_TIMESTAMP_COLOR = "777777"
-- SCM_TIMESTAMP_OUTPUT_FORMAT = "(%s)|r %s"
-- scmTimestamps:UnhookAll()