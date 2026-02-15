Jobcenter = {
	["Jobs"] = {"Busfahrer","Pizzalieferant"},
	["Koordinaten"] = {
		["Busfahrer"] = {1065.3000488281,-1775.5,13.60000038147},
		["Pizzalieferant"] = {2113,-1789.3000488281,13.199999809265},
	},
}
Jobcenter.marker = createMarker(361.82989501953,173.55642700195,1008.3828125-0.9,"cylinder",1,0,0,200)
setElementInterior(Jobcenter.marker,3)

addEventHandler("onClientMarkerHit",Jobcenter.marker,function(player)
	if(player == localPlayer)then
		if(isWindowOpen())then
			GUIEditor.window[1] = guiCreateWindow(540, 189, 324, 382, "Jobcenter", false)

			GUIEditor.gridlist[1] = guiCreateGridList(9, 26, 305, 256, false, GUIEditor.window[1])
			job = guiGridListAddColumn(GUIEditor.gridlist[1], "Job", 0.9)
			GUIEditor.button[1] = guiCreateButton(9, 292, 305, 35, "Anzeigen", false, GUIEditor.window[1])
			GUIEditor.button["Close"] = guiCreateButton(9, 337, 305, 35, "Schließen", false, GUIEditor.window[1])
			
			setWindowDatas("set")
			
			for _,v in pairs(Jobcenter["Jobs"])do
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1],row,job,v,false,false)
			end
			
			addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
				local job = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(not(job == ""))then
					if(isElement(Jobcenter.blip))then destroyElement(Jobcenter.blip)end
					if(isTimer(Jobcenter.blip))then killTimer(Jobcenter.blip)end
					Jobcenter.blip = createBlip(Jobcenter["Koordinaten"][job][1],Jobcenter["Koordinaten"][job][2],Jobcenter["Koordinaten"][job][3],0,2,255,0,0)
					Jobcenter.timer = setTimer(function()
						destroyElement(Jobcenter.blip)
					end,300000,1)
					infobox("Der Job wird dir nun für 5 Minuten in Form eines roten Blips auf der Karte angezeigt!",0,255,0)
					setElementData(localPlayer,"Job",job)
				else infobox("Du hast keine Job ausgewählt!",255,0,0)end
			end,false)
		end
	end
end)