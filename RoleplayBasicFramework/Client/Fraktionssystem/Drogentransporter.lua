Drogentransporter = {}

addEvent("Drogentransporter.open",true)
addEventHandler("Drogentransporter.open",root,function()
	if(isWindowOpen())then
		GUIEditor.window[1] = guiCreateWindow(523, 241, 295, 112, "Drogentransporter", false)

		GUIEditor.button[1] = guiCreateButton(9, 25, 276, 33, "Starten", false, GUIEditor.window[1])
		GUIEditor.button["Close"] = guiCreateButton(9, 68, 276, 33, "Schließen", false, GUIEditor.window[1])
		
		setWindowDatas("set")
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			triggerServerEvent("Drogentransporter.start",localPlayer)
		end,false)
	end
end)

addEvent("Drogentransporter.create",true)
addEventHandler("Drogentransporter.create",root,function(type)
	if(isElement(Drogentransporter.marker))then destroyElement(Drogentransporter.marker)end
	if(isElement(Drogentransporter.blip))then destroyElement(Drogentransporter.blip)end
	if(type)then
		local abgabemarker = getAbgabemarker(getElementData(localPlayer,"Fraktion"))
		Drogentransporter.marker = createMarker(abgabemarker[1],abgabemarker[2],abgabemarker[3],"checkpoint",4,0,0,200)
		Drogentransporter.blip = createBlip(abgabemarker[1],abgabemarker[2],abgabemarker[3],0,2,255,0,0)
		
		addEventHandler("onClientMarkerHit",Drogentransporter.marker,function(player)
			if(player == localPlayer)then
				triggerServerEvent("Drogentransporter.abgabe",localPlayer)
			end
		end)
	end
end)