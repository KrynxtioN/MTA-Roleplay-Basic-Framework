Haussystem = {open = false}

addEvent("Haussystem.window",true)
addEventHandler("Haussystem.window",root,function(preis,besitzer)
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(557, 304, 357, 215, "Haussystem", false)

        GUIEditor.button["Close"] = guiCreateButton(9, 174, 338, 31, "Schließen", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(9, 133, 165, 31, "Kaufen", false, GUIEditor.window[1])
        GUIEditor.button[3] = guiCreateButton(182, 133, 165, 31, "Betreten", false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(10, 27, 337, 96, "Preis: "..preis.."$\nBesitzer: "..besitzer, false, GUIEditor.window[1])  
		if(besitzer ~= "Niemand")then guiSetText(GUIEditor.button[2],"Verkaufen")end
		
		setWindowDatas("set",1)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			triggerServerEvent("Haussystem.buySell",localPlayer,guiGetText(GUIEditor.button[2]))
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
			triggerServerEvent("Haussystem.betreten",localPlayer)
		end,false)
    end
end)

addEvent("Haussystem.menu",true)
addEventHandler("Haussystem.menu",root,function(inhalt)
	if(Haussystem.open == true)then
		Haussystem.open = false
		setWindowDatas("reset")
	else
		if(isWindowOpen())then
			Haussystem.open = true
			GUIEditor.window[1] = guiCreateWindow(466, 283, 392, 227, "Hausmenü", false)
			
			GUIEditor.label[1] = guiCreateLabel(10, 27, 372, 30, "Hauskasse: "..inhalt.."$", false, GUIEditor.window[1])
			GUIEditor.label[2] = guiCreateLabel(10, 67, 191, 30, "Summe:", false, GUIEditor.window[1])
			GUIEditor.edit[1] = guiCreateEdit(211, 67, 171, 30, "", false, GUIEditor.window[1])
			GUIEditor.button[1] = guiCreateButton(10, 110, 372, 29, "Einzahlen", false, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(10, 149, 372, 29, "Auszahlen", false, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(10, 188, 372, 29, "Heilen (Leben + Weste)", false, GUIEditor.window[1])
			
			setWindowDatas("set",2)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
				local edit = guiGetText(GUIEditor.edit[1])
				if(#edit >= 1 and tonumber(edit))then
					triggerServerEvent("Haussystem.einAuszahlen",localPlayer,"einzahlen",edit)
				else infobox("Du hast keine Summe angegeben!",255,0,0)end
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
				local edit = guiGetText(GUIEditor.edit[1])
				if(#edit >= 1 and tonumber(edit))then
					triggerServerEvent("Haussystem.einAuszahlen",localPlayer,"auszahlen",edit)
				else infobox("Du hast keine Summe angegeben!",255,0,0)end
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
				triggerServerEvent("Haussystem.heilen",localPlayer)
			end,false)
		end
	end
end)

addEvent("Haussystem.refresh",true)
addEventHandler("Haussystem.refresh",root,function(inhalt)
	if(Haussystem.open == true)then
		guiSetText(GUIEditor.label[1],"Hauskasse: "..inhalt.."$")
	end
end)