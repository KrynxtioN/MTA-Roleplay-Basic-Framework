addEvent("Bank.open",true)
addEventHandler("Bank.open",root,function()
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(492, 236, 350, 198, "Bankautomat", false)

        GUIEditor.label[1] = guiCreateLabel(10, 27, 330, 33, "Konto: "..getElementData(localPlayer,"Bankgeld").."$\nSumme:", false, GUIEditor.window[1])
        GUIEditor.edit[1] = guiCreateEdit(75, 70, 201, 33, "", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(10, 113, 160, 32, "Einzahlen", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(180, 113, 160, 32, "Auszahlen", false, GUIEditor.window[1])
        GUIEditor.button["Close"] = guiCreateButton(10, 155, 330, 33, "Schließen", false, GUIEditor.window[1])
		
		setWindowDatas("set",1)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			local summe = guiGetText(GUIEditor.edit[1])
			if(#summe >= 1 and tonumber(summe))then
				triggerServerEvent("Bank.server",localPlayer,"einzahlen",summe)
			else infobox("Du hast keine gültige Summe eingetragen!",255,0,0)end
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			local summe = guiGetText(GUIEditor.edit[1])
			if(#summe >= 1 and tonumber(summe))then
				triggerServerEvent("Bank.server",localPlayer,"auszahlen",summe)
			else infobox("Du hast keine gültige Summe eingetragen!",255,0,0)end
		end,false)
	end
end)

addEvent("Bank.refresh",true)
addEventHandler("Bank.refresh",root,function()
	guiSetText(GUIEditor.label[1],"Konto: "..getElementData(localPlayer,"Bankgeld").."$\nSumme:")
end)