addEvent("Waffenlager.window",true)
addEventHandler("Waffenlager.window",root,function(inhalt)
	if(isWindowOpen())then
		GUIEditor.window[1] = guiCreateWindow(531, 208, 317, 125, "Waffenlager", false)

        GUIEditor.label[1] = guiCreateLabel(10, 28, 297, 42, "Verfügbare Einheiten: "..inhalt.."/250", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(9, 80, 144, 35, "Ausrüsten", false, GUIEditor.window[1])
        GUIEditor.button["Close"] = guiCreateButton(163, 80, 144, 35, "Schließen", false, GUIEditor.window[1])
		
		setWindowDatas("set",1)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			triggerServerEvent("Waffenlager.use",localPlayer)
		end,false)
	end
end)