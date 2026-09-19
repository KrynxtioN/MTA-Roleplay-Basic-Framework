Supermarkt = { -- item, preis
	{"Hamburger",50},
	{"Benzinkanister",100},
}

for i = 1,1 do
	local supermarktmarker = createMarker(-23.460718154907,-55.632041931152,1003.546875-0.9,"cylinder",1,200,0,0)
	setElementDimension(supermarktmarker,i)
	setElementInterior(supermarktmarker,6)
	
	addEventHandler("onClientMarkerHit",supermarktmarker,function(player)
		if(player == localPlayer)then
			if(getElementDimension(localPlayer) == getElementDimension(source))then
				if(isWindowOpen())then
					GUIEditor.window[1] = guiCreateWindow(540, 189, 324, 382, "Supermarkt", false)

					GUIEditor.gridlist[1] = guiCreateGridList(9, 26, 305, 256, false, GUIEditor.window[1])
					item = guiGridListAddColumn(GUIEditor.gridlist[1], "Item", 0.5)
					preis = guiGridListAddColumn(GUIEditor.gridlist[1], "Preis", 0.5)
					GUIEditor.button[1] = guiCreateButton(9, 292, 305, 35, "Kaufen", false, GUIEditor.window[1])
					GUIEditor.button["Close"] = guiCreateButton(9, 337, 305, 35, "Schließen", false, GUIEditor.window[1])
					
					setWindowDatas("set")
					
					for _,v in pairs(Supermarkt)do
						local row = guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1],row,item,v[1],false,false)
						guiGridListSetItemText(GUIEditor.gridlist[1],row,preis,v[2].."$",false,false)
					end
					
					addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
						local item = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
						if(not(item == ""))then
							triggerServerEvent("Supermarkt.buy",localPlayer,item)
						else infobox("Du hast keine Item ausgewählt!",255,0,0)end
					end,false)
				end
			end
		end
	end)
end