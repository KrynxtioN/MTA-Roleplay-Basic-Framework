Anmeldebereich = {}
triggerServerEvent("Anmeldebereich.checkAccount",localPlayer)

addEvent("Anmeldebereich.create",true)
addEventHandler("Anmeldebereich.create",root,function(type)
	setCameraMatrix(1521.8811035156,-1712.1475830078,38.294799804688,1521.2503662109,-1712.7365722656,37.789539337158)
	fadeCamera(true)
	setElementData(localPlayer,"loggedin",0)
	setElementInterior(localPlayer,0)
	setElementDimension(localPlayer,0)
    GUIEditor.window[1] = guiCreateWindow(482, 313, 477, 188, "Anmeldebereich", false)

    GUIEditor.button[1] = guiCreateButton(132, 145, 216, 33, type, false, GUIEditor.window[1])
    GUIEditor.label[1] = guiCreateLabel(10, 29, 457, 65, "Herzlich Willkommen, "..getPlayerName(localPlayer).."!\nBitte gib dein Passwort an.", false, GUIEditor.window[1])
	GUIEditor.edit[1] = guiCreateEdit(133, 104, 215, 28, "", false, GUIEditor.window[1])
    guiEditSetMasked(GUIEditor.edit[1], true)    
	
	setWindowDatas("set",1)
	
	addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
		local pw = guiGetText(GUIEditor.edit[1])
		if(#pw >= 1)then
			local button = guiGetText(GUIEditor.button[1])
			triggerServerEvent("Anmeldebereich.server",localPlayer,pw,button)
		else infobox("Du hast kein Passwort angegeben!",255,0,0)end
	end,false)
end)