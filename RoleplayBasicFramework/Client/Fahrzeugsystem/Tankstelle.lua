addEvent("Tankstelle.open",true)
addEventHandler("Tankstelle.open",root,function()
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(567, 241, 377, 225, "Tankstelle", false)

        GUIEditor.label[1] = guiCreateLabel(10, 26, 357, 34, "Liter:", false, GUIEditor.window[1])
        GUIEditor.edit[1] = guiCreateEdit(10, 70, 357, 31, "", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(10, 111, 357, 28, "Liter tanken", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(10, 149, 357, 28, "Volltanken", false, GUIEditor.window[1])
        GUIEditor.button["Close"] = guiCreateButton(10, 187, 357, 28, "Schließen", false, GUIEditor.window[1])
		
		setWindowDatas("set",1)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			local edit = guiGetText(GUIEditor.edit[1])
			if(#edit >= 1 and tonumber(edit))then
				triggerServerEvent("Tankstelle.server",localPlayer,edit)
			else infobox("Du hast keine gültige Literanzahl eingetragen!",255,0,0)end
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			triggerServerEvent("Tankstelle.server",localPlayer)
		end,false)
    end
end)