Inventar = {open = false,
	["Items"] = {"Hamburger","Benzinkanister","Weed"},
}

bindKey("i","down",function()
	if(Inventar.open == true)then
		Inventar.open = false
		setWindowDatas("reset")
	else
		if(isWindowOpen())then
			Inventar.open = true
			GUIEditor.window[1] = guiCreateWindow(540, 189, 324, 382, "Inventar", false)

			GUIEditor.gridlist[1] = guiCreateGridList(9, 26, 305, 256, false, GUIEditor.window[1])
			item = guiGridListAddColumn(GUIEditor.gridlist[1], "Item", 0.5)
			anzahl = guiGridListAddColumn(GUIEditor.gridlist[1], "Anzahl", 0.5)
			GUIEditor.button[1] = guiCreateButton(9, 292, 305, 35, "Benutzen", false, GUIEditor.window[1])
			GUIEditor.button["Close"] = guiCreateButton(9, 337, 305, 35, "Schließen", false, GUIEditor.window[1])
			
			setWindowDatas("set")
			Inventar.items()
			
			addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
				local item = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(not(item == ""))then
					triggerServerEvent("Inventar.use",localPlayer,item)
				else infobox("Du hast keine Item ausgewählt!",255,0,0)end
			end,false)
		end
	end
end)

function Inventar.items()
	guiGridListClear(GUIEditor.gridlist[1])
	for _,v in pairs(Inventar["Items"])do
		if(getElementData(localPlayer,v) >= 1)then
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1],row,item,v,false,false)
			guiGridListSetItemText(GUIEditor.gridlist[1],row,anzahl,getElementData(localPlayer,v),false,false)
		end
	end
end
addEvent("Inventar.items",true)
addEventHandler("Inventar.items",root,Inventar.items)

addEvent("Inventar.useWeed",true)
addEventHandler("Inventar.useWeed",root,function()
	if(isTimer(Weedtimer))then killTimer(Weedtimer)end
	setGameSpeed(0.7)
	Weedtimer = setTimer(function()
		setGameSpeed(1)
	end,15000,1)
end)