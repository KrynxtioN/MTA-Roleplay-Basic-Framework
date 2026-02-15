Adminsystem = {open = false}

bindKey("f2","down",function()	
	if(Adminsystem.open == true)then
		Adminsystem.open = false
		setWindowDatas("reset")
	else
		if(isWindowOpen())then
			if(getElementData(localPlayer,"Adminlevel") >= 1)then
				Adminsystem.open = true
				GUIEditor.window[1] = guiCreateWindow(580, 189, 522, 322, "Adminsystem", false)

				GUIEditor.gridlist[1] = guiCreateGridList(10, 26, 204, 286, false, GUIEditor.window[1])
				player = guiGridListAddColumn(GUIEditor.gridlist[1], "Spielername", 0.9)
				GUIEditor.button[1] = guiCreateButton(219, 26, 293, 34, "Kicken", false, GUIEditor.window[1])
				GUIEditor.button[2] = guiCreateButton(219, 70, 293, 34, "Bannen", false, GUIEditor.window[1])
				GUIEditor.button[3] = guiCreateButton(219, 114, 293, 34, "Leader machen", false, GUIEditor.window[1])
				GUIEditor.label[1] = guiCreateLabel(219, 158, 292, 34, "ID / Grund:", false, GUIEditor.window[1])
				GUIEditor.edit[1] = guiCreateEdit(219, 202, 292, 34, "", false, GUIEditor.window[1])    
				
				setWindowDatas("set",1)
				
				for _,v in pairs(getElementsByType("player"))do
					local row = guiGridListAddRow(GUIEditor.gridlist[1])
					guiGridListSetItemText(GUIEditor.gridlist[1],row,player,getPlayerName(v),false,false)
				end
				
				addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
					local target = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
					local edit = guiGetText(GUIEditor.edit[1])
					if(target ~= "" and #edit >= 1)then
						triggerServerEvent("Adminsystem.kicken",localPlayer,target,edit)
					else infobox("Du hast keinen Spieler ausgewählt und/oder keinen Grund angegeben!",255,0,0)end
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
					local target = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
					local edit = guiGetText(GUIEditor.edit[1])
					if(target ~= "" and #edit >= 1)then
						triggerServerEvent("Adminsystem.bannen",localPlayer,target,edit)
					else infobox("Du hast keinen Spieler ausgewählt und/oder keinen Grund angegeben!",255,0,0)end
				end,false)

				addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
					local target = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
					local edit = guiGetText(GUIEditor.edit[1])
					if(target ~= "" and #edit >= 1 and tonumber(edit))then
						triggerServerEvent("Adminsystem.leader",localPlayer,target,edit)
					else infobox("Du hast keinen Spieler ausgewählt und/oder gültige Fraktion angegeben!",255,0,0)end
				end,false)
			end
		end
	end
end)