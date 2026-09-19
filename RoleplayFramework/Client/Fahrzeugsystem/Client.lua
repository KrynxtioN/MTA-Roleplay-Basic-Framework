Fahrzeugsystem = {open = false}

addEvent("Fahrzeugsystem.window",true)
addEventHandler("Fahrzeugsystem.window",root,function(preis)
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(531, 208, 317, 125, "Autohaus", false)

        GUIEditor.label[1] = guiCreateLabel(10, 28, 297, 42, "Preis: "..preis.."$", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(9, 80, 144, 35, "Kaufen", false, GUIEditor.window[1])
        GUIEditor.button["Close"] = guiCreateButton(163, 80, 144, 35, "Schließen", false, GUIEditor.window[1])
		
		setWindowDatas("set",1)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			triggerServerEvent("Fahrzeugsystem.buy",localPlayer)
		end,false)
	end
end)

addEvent("Fahrzeugsystem.verwaltung",true)
addEventHandler("Fahrzeugsystem.verwaltung",root,function(vehicles)
	if(Fahrzeugsystem.open == true)then
		Fahrzeugsystem.open = false
		setWindowDatas("reset")
	else
		if(isWindowOpen())then
			Fahrzeugsystem.open = true
			GUIEditor.window[1] = guiCreateWindow(427, 252, 629, 347, "Fahrzeugverwaltung", false)

			GUIEditor.gridlist[1] = guiCreateGridList(10, 27, 609, 180, false, GUIEditor.window[1])
			id = guiGridListAddColumn(GUIEditor.gridlist[1], "ID", 0.5)
			fahrzeug = guiGridListAddColumn(GUIEditor.gridlist[1], "Fahrzeug", 0.5)
			GUIEditor.button[1] = guiCreateButton(10, 217, 198, 33, "An den Server verkaufen", false, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(10, 260, 198, 33, "", false, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(10, 303, 198, 33, "", false, GUIEditor.window[1])
			GUIEditor.button[4] = guiCreateButton(218, 217, 198, 33, "Orten", false, GUIEditor.window[1])
			GUIEditor.button[5] = guiCreateButton(218, 260, 198, 33, "", false, GUIEditor.window[1])
			GUIEditor.button[6] = guiCreateButton(218, 303, 198, 33, "", false, GUIEditor.window[1])
			GUIEditor.button[7] = guiCreateButton(426, 217, 193, 33, "Respawnen", false, GUIEditor.window[1])
			GUIEditor.button[8] = guiCreateButton(426, 260, 193, 33, "", false, GUIEditor.window[1])
			GUIEditor.button[9] = guiCreateButton(426, 303, 193, 33, "", false, GUIEditor.window[1])
			
			setWindowDatas("set")

			for _,v in pairs(vehicles)do
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1],row,id,v[1],false,false)
				guiGridListSetItemText(GUIEditor.gridlist[1],row,fahrzeug,v[2],false,false)
			end
			
			addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
				local id = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				local name = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),2)
				if(id ~= "")then
					triggerServerEvent("Fahrzeugsystem.verkaufen",localPlayer,id,name)
				else infobox("Du hast kein Fahrzeug ausgewählt!",255,0,0)end
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[4],function()
				local id = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(id ~= "")then
					triggerServerEvent("Fahrzeugsystem.orten",localPlayer,id)
				else infobox("Du hast kein Fahrzeug ausgewählt!",255,0,0)end
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[7],function()
				local id = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(id ~= "")then
					triggerServerEvent("Fahrzeugsystem.respawnen",localPlayer,id)
				else infobox("Du hast kein Fahrzeug ausgewählt!",255,0,0)end
			end,false)
		end
	end
end)