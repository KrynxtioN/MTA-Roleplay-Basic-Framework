Ammunation = { -- waffe, munition, preis
	{"Desert Eagle",50,250},
	{"Mp5",100,1000},
	{"M4",200,1500},
	{"Rifle",25,1250},
}
   
for i = 1,2 do
	local ammunationmarker = createMarker(295.4345703125,-80.809967041016,1001.515625-0.9,"cylinder",1,200,0,0)
	setElementDimension(ammunationmarker,i)
	setElementInterior(ammunationmarker,4)
	
	addEventHandler("onClientMarkerHit",ammunationmarker,function(player)
		if(player == localPlayer)then
			if(getElementDimension(localPlayer) == getElementDimension(source))then
				if(isWindowOpen())then
					GUIEditor.window[1] = guiCreateWindow(540, 189, 324, 382, "Waffenladen", false)

					GUIEditor.gridlist[1] = guiCreateGridList(9, 26, 305, 256, false, GUIEditor.window[1])
					waffe = guiGridListAddColumn(GUIEditor.gridlist[1], "Waffe", 0.4)
					munition = guiGridListAddColumn(GUIEditor.gridlist[1], "Munition", 0.3)
					preis = guiGridListAddColumn(GUIEditor.gridlist[1], "Preis", 0.3)
					GUIEditor.button[1] = guiCreateButton(9, 292, 305, 35, "Kaufen", false, GUIEditor.window[1])
					GUIEditor.button["Close"] = guiCreateButton(9, 337, 305, 35, "Schließen", false, GUIEditor.window[1])
					
					setWindowDatas("set")
					
					for _,v in pairs(Ammunation)do
						local row = guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1],row,waffe,v[1],false,false)
						guiGridListSetItemText(GUIEditor.gridlist[1],row,munition,v[2],false,false)
						guiGridListSetItemText(GUIEditor.gridlist[1],row,preis,v[3].."$",false,false)
					end
					
					addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
						local item = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
						if(not(item == ""))then
							triggerServerEvent("Ammunation.buy",localPlayer,item)
						else infobox("Du hast keine Waffe ausgewählt!",255,0,0)end
					end,false)
				end
			end
		end
	end)
end