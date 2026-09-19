Fraktionssystem = {open = false,
	["Abgabemarker"] = {
		[1] = {1529.6829833984,-1671.1884765625,13.3828125},
		[2] = {962.82214355469,-1103.6389160156,23.6875},
		[3] = {682.22772216797,-482.93872070313,16.1875},},
	["Fraktionsnamen"] = {
		[0] = "Zivlist",
		[1] = "LSPD",
		[2] = "Yakuza",
		[3] = "Biker",
		[4] = "Reporter"},
	["Fraktioncolors"] = {
		[0] = {255,255,255},
		[1] = {0,255,0},
		[2] = {150,0,0},
		[3] = {100,50,50},
		[4] = {250,150,0},},
	}
	
function getAbgabemarker(fraktion)
	local x,y,z = Fraktionssystem["Abgabemarker"][fraktion][1],Fraktionssystem["Abgabemarker"][fraktion][2],Fraktionssystem["Abgabemarker"][fraktion][3]
	return {x,y,z}
end

addEvent("Fraktionssystem.open",true)
addEventHandler("Fraktionssystem.open",root,function()
	if(Fraktionssystem.open == true)then
		Fraktionssystem.open = false
		setWindowDatas("reset")
	else
		if(isWindowOpen())then
			Fraktionssystem.open = true
			GUIEditor.window[1] = guiCreateWindow(580, 189, 522, 378, "Fraktionsverwaltung", false)
			GUIEditor.gridlist[1] = guiCreateGridList(10, 26, 198, 340, false, GUIEditor.window[1])
			name = guiGridListAddColumn(GUIEditor.gridlist[1], "Spielername", 0.5)
			rang = guiGridListAddColumn(GUIEditor.gridlist[1], "Rang", 0.5)
			GUIEditor.button[1] = guiCreateButton(219, 26, 293, 34, "Rang UP", false, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(219, 70, 293, 34, "Rang Down", false, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(219, 114, 293, 34, "Uninvite", false, GUIEditor.window[1])
			GUIEditor.label[1] = guiCreateLabel(219, 158, 292, 34, "Spieler / Menge:", false, GUIEditor.window[1])
			GUIEditor.edit[1] = guiCreateEdit(219, 202, 292, 34, "", false, GUIEditor.window[1])
			GUIEditor.button[4] = guiCreateButton(218, 246, 293, 34, "Invite", false, GUIEditor.window[1])
			GUIEditor.button[5] = guiCreateButton(218, 288, 293, 34, "Einzahlen", false, GUIEditor.window[1])
			GUIEditor.button[6] = guiCreateButton(218, 332, 293, 34, "Auszahlen", false, GUIEditor.window[1])
			
			setWindowDatas("set",1)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
				local target = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(target ~= "")then
					triggerServerEvent("Fraktionssystem.rangUpRangDown",localPlayer,"rangup",target)
				else infobox("Du hast keinen Spieler ausgewählt!",255,0,0)end
			end,false)

			addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
				local target = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(target ~= "")then
					triggerServerEvent("Fraktionssystem.rangUpRangDown",localPlayer,"rangdown",target)
				else infobox("Du hast keinen Spieler ausgewählt!",255,0,0)end
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
				local target = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(target ~= "")then
					triggerServerEvent("Fraktionssystem.inviteUninvite",localPlayer,"uninvite",target)
				else infobox("Du hast keinen Spieler ausgewählt!",255,0,0)end
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[4],function()
				local edit = guiGetText(GUIEditor.edit[1])
				if(#edit >= 1)then
					triggerServerEvent("Fraktionssystem.inviteUninvite",localPlayer,"invite",target)
				else infobox("Du hast keinen Spieler ausgewählt!",255,0,0)end
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[5],function()
				local edit = guiGetText(GUIEditor.edit[1])
				if(#edit >= 1 and tonumber(edit))then
					triggerServerEvent("Fraktionssystem.einAuszahlen",localPlayer,"einzahlen",edit)
				else infobox("Du hast keine Summe angegeben!",255,0,0)end
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[6],function()
				local edit = guiGetText(GUIEditor.edit[1])
				if(#edit >= 1 and tonumber(edit))then
					triggerServerEvent("Fraktionssystem.einAuszahlen",localPlayer,"auszahlen",edit)
				else infobox("Du hast keine Summe angegeben!",255,0,0)end
			end,false)
		end
	end
end)

addEvent("Fraktionssystem.checkOpen",true)
addEventHandler("Fraktionssystem.checkOpen",root,function()
	if(Fraktionssystem.open == true)then
		Fraktionssystem.open = false
		setWindowDatas("reset")
	end
end)

addEvent("Fraktionssystem.refresh",true)
addEventHandler("Fraktionssystem.refresh",root,function(datas)
	if(Fraktionssystem.open == true)then
		guiGridListClear(GUIEditor.gridlist[1])
		for _,v in pairs(datas[2])do
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1],row,name,v[1],false,false)
			guiGridListSetItemText(GUIEditor.gridlist[1],row,rang,v[2],false,false)
		end
		guiSetText(GUIEditor.label[1],"Fraktionskasse: "..datas[1].."$\nSpieler / Menge:")
	end
end)