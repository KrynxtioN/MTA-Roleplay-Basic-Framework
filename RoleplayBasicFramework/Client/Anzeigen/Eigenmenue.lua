Eigenmenue = {}

addCommandHandler("self",function()
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(484, 205, 471, 377, "Eigenmenü", false)

        GUIEditor.button[1] = guiCreateButton(10, 25, 133, 35, "Statistiken", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(153, 25, 133, 35, "Lizenzen", false, GUIEditor.window[1])
        GUIEditor.button[3] = guiCreateButton(296, 25, 133, 35, "Spawnpunkt", false, GUIEditor.window[1])
        GUIEditor.button["Close"] = guiCreateButton(439, 25, 22, 35, "X", false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(10, 70, 451, 297, "Klicke etwas an, um das Jeweilige anzeigen zu lassen.", false, GUIEditor.window[1]) 

		setWindowDatas("set",1)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			Eigenmenue.check()
			GUIEditor.label[1] = guiCreateLabel(10, 70, 451, 297, "Statistiken:\n\nFraktion: "..getElementData(localPlayer,"Fraktion").."\nFraktionsrang: "..getElementData(localPlayer,"Fraktionsrang").."\nAdminlevel: "..getElementData(localPlayer,"Adminlevel").."\nKills/Tode: "..getElementData(localPlayer,"Kills").."/"..getElementData(localPlayer,"Tode").."\nHand-/Bankgeld: "..getElementData(localPlayer,"Geld").."$/"..getElementData(localPlayer,"Bankgeld").."$", false, GUIEditor.window[1])  
			setWindowDatas("set",1)
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			Eigenmenue.check()
			if(getElementData(localPlayer,"Autoschein") == 1)then autoschein = "Vorhanden" else autoschein = "Nicht vorhanden" end
			if(getElementData(localPlayer,"Motorradschein") == 1)then motorradschein = "Vorhanden" else motorradschein = "Nicht vorhanden" end
			if(getElementData(localPlayer,"Lkwschein") == 1)then lkwschein = "Vorhanden" else lkwschein = "Nicht vorhanden" end
			if(getElementData(localPlayer,"Bootschein") == 1)then bootschein = "Vorhanden" else bootschein = "Nicht vorhanden" end
			if(getElementData(localPlayer,"Flugschein") == 1)then flugschein = "Vorhanden" else flugschein = "Nicht vorhanden" end
			GUIEditor.label[1] = guiCreateLabel(10, 70, 451, 297, "Lizenzen:\n\nFührerschein: "..autoschein.."\nMotorradschein: "..motorradschein.."\nLkwschein: "..lkwschein.."\nBootschein: "..bootschein.."\nFlugschein: "..flugschein, false, GUIEditor.window[1])  
			setWindowDatas("set",1)
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
			Eigenmenue.check()
			GUIEditor.gridlist[1] = guiCreateGridList(12, 66, 274, 301, false, GUIEditor.window[1])
			spawn = guiGridListAddColumn(GUIEditor.gridlist[1], "Spawnunkt", 0.9)
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1],row,spawn,"Noobspawn",false,false)
			if(getElementData(localPlayer,"Fraktion") >= 1)then
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1],row,spawn,"Fraktion",false,false)
			end
			if(getElementData(localPlayer,"Housekey") == 1)then
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1],row,spawn,"Haus",false,false)
			end
			GUIEditor.label[1] = guiCreateLabel(296, 66, 165, 100, "Nutze einen Doppelklick, um deinen Spawnpunkt zu ändern.", false, GUIEditor.window[1])
			setWindowDatas("set",1)
			
			addEventHandler("onClientGUIDoubleClick",GUIEditor.gridlist[1],function()
				local spawn = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(spawn ~= "")then
					triggerServerEvent("Eigenmenu.spawn",localPlayer,spawn)
				else infobox("Du hast keinen Spawn ausgewählt!",255,0,0)end
			end,false)
		end,false)
	end
end)

function Eigenmenue.check()
	if(isElement(GUIEditor.gridlist[1]))then destroyElement(GUIEditor.gridlist[1])end
	destroyElement(GUIEditor.label[1])
end