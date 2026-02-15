Waffentransporter = {}

addEvent("Waffentransporter.open",true)
addEventHandler("Waffentransporter.open",root,function()
	if(isWindowOpen())then
		GUIEditor.window[1] = guiCreateWindow(523, 241, 295, 112, "Waffentransporter", false)

		GUIEditor.button[1] = guiCreateButton(9, 25, 276, 33, "Starten", false, GUIEditor.window[1])
		GUIEditor.button["Close"] = guiCreateButton(9, 68, 276, 33, "Schließen", false, GUIEditor.window[1])
		
		setWindowDatas("set")
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			triggerServerEvent("Waffentransporter.start",localPlayer)
		end,false)
	end
end)

addEvent("Waffentransporter.create",true)
addEventHandler("Waffentransporter.create",root,function(type)
	if(isElement(Waffentransporter.marker))then destroyElement(Waffentransporter.marker)end
	if(isElement(Waffentransporter.blip))then destroyElement(Waffentransporter.blip)end
	if(type)then
		local abgabemarker = getAbgabemarker(getElementData(localPlayer,"Fraktion"))
		Waffentransporter.marker = createMarker(abgabemarker[1],abgabemarker[2],abgabemarker[3],"checkpoint",4,0,0,200)
		Waffentransporter.blip = createBlip(abgabemarker[1],abgabemarker[2],abgabemarker[3],0,2,255,0,0)
		
		addEventHandler("onClientMarkerHit",Waffentransporter.marker,function(player)
			if(player == localPlayer)then
				triggerServerEvent("Waffentransporter.abgabe",localPlayer)
			end
		end)
	end
end)