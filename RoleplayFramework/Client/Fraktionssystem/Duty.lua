addEvent("Duty.window",true)
addEventHandler("Duty.window",root,function()
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(523, 241, 295, 112, "Dutysystem", false)

        GUIEditor.button[1] = guiCreateButton(9, 25, 276, 33, "Dienst betreten", false, GUIEditor.window[1])
        GUIEditor.button["Close"] = guiCreateButton(9, 68, 276, 33, "Schließen", false, GUIEditor.window[1])
		if(getElementData(localPlayer,"duty") == true)then
			guiSetText(GUIEditor.button[1],"Dienst verlassen")
		end
		
		setWindowDatas("set")
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			triggerServerEvent("Duty.server",localPlayer)
		end,false)
    end
end)