Helpmenue = {open = false,
	["Kategorien"] = {"Starthilfe","Fahrzeuge","Geld"},
	["Texte"] = {
		["Starthilfe"] = "/",
		["Fahrzeuge"] = "/",
		["Geld"] = "/"},
	}

bindKey("f1","down",function()
	if(Helpmenue.open == true)then
		Helpmenue.open = false
		setWindowDatas("reset")
	else
		if(isWindowOpen())then
			Helpmenue.open = true
			GUIEditor.window[1] = guiCreateWindow(496, 209, 583, 415, "Hilfemenü", false)

			GUIEditor.gridlist[1] = guiCreateGridList(10, 28, 228, 377, false, GUIEditor.window[1])
			kategorie = guiGridListAddColumn(GUIEditor.gridlist[1], "Kategorie", 0.9)
			GUIEditor.label[1] = guiCreateLabel(248, 28, 325, 377, "Klicke links eine Kategorie an, um Hilfe zu dieser zu erhalten.", false, GUIEditor.window[1])   
			
			setWindowDatas("set",1)
			
			for _,v in pairs(Helpmenue["Kategorien"])do
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1],row,kategorie,v,false,false)
			end
			
			addEventHandler("onClientGUIClick",GUIEditor.gridlist[1],function()
				local kategorie = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(kategorie ~= "")then
					guiSetText(GUIEditor.label[1],Helpmenue["Texte"][kategorie])
				end
			end,false)
		end
	end
end)