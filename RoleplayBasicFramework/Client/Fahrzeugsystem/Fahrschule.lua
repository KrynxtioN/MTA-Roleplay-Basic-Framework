Fahrschule = {points = 0, falscheAntworten = 0,
	["Daten"] = {
		{"Autoschein",1000},
		{"Motorradschein",1000},
		{"Lkwschein",1000},
		{"Bootschein",1000},
		{"Flugschein",1000},},
	["Fragen"] = {
		{"Was machst du, wenn sich dir ein Fahrzeug mit Blaulicht nähert?","Onanieren","Xendoms Album laut aufdrehen","Rechts ran fahren und warten","Gegen einen Baum fahren",3},
		{"Wo darfst du parken?","Überall","Auf gekennzeichneten Parkplätzen","Auf Dächern","In fremden Garagen",2},
		{"Was darfst du am Steuer nicht?","Telefonieren","Lenken","Nazi-Bands hören","Abhängen, so wie Julien's Matschauge",1},},
	["Marker"] = {
		{691.60424804688,-1588.4721679688,13.394587516785},
		{756.3818359375,-1589.1047363281,12.998765945435},
		{775.126953125,-1565.0675048828,12.79542350769},
		{799.82189941406,-1424.0096435547,12.804203033447},
		{776.40368652344,-1393.3182373047,12.822834968567},
		{657.46313476563,-1392.9822998047,12.866518974304},
		{624.88763427734,-1446.1469726563,13.546192169189},
		{625.12872314453,-1545.3820800781,14.595982551575},
		{669.52416992188,-1589.2395019531,13.573101997375},
		{699.0966796875,-1572.1915283203,13.651308059692},},
	}
Fahrschule.marker = createMarker(-2033.4307861328,-117.55787658691,1035.171875-0.9,"cylinder",1,0,0,200)
setElementInterior(Fahrschule.marker,3)

addEventHandler("onClientMarkerHit",Fahrschule.marker,function(player)
	if(player == localPlayer)then
		Fahrschule.open()
	end
end)

function Fahrschule.open()
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(540, 189, 324, 382, "Fahrschule", false)

        GUIEditor.gridlist[1] = guiCreateGridList(9, 26, 305, 256, false, GUIEditor.window[1])
        lizenz = guiGridListAddColumn(GUIEditor.gridlist[1], "Lizenz", 0.5)
        preis = guiGridListAddColumn(GUIEditor.gridlist[1], "Preis", 0.5)
        GUIEditor.button[1] = guiCreateButton(9, 292, 305, 35, "Beantragen", false, GUIEditor.window[1])
        GUIEditor.button["Close"] = guiCreateButton(9, 337, 305, 35, "Schließen", false, GUIEditor.window[1])
		
		setWindowDatas("set")
		
		for _,v in pairs(Fahrschule["Daten"])do
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1],row,lizenz,v[1],false,false)
			guiGridListSetItemText(GUIEditor.gridlist[1],row,preis,v[2],false,false)
		end
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			local lizenz = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
			local preis = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),2)
			if(lizenz ~= "")then
				triggerServerEvent("Fahrschule.beantragen",localPlayer,lizenz,preis)
			else infobox("Du hast keine Lizenz ausgewählt!",255,0,0)end
		end,false)
	end
end

function Fahrschule.fragebogen()
	if(isElement(GUIEditor.window[1]))then destroyElement(GUIEditor.window[1])end
	Fahrschule.points = Fahrschule.points + 1

    GUIEditor.window[1] = guiCreateWindow(482, 252, 360, 347, "Fahrschule", false)
	centerWindow(GUIEditor.window[1])

    GUIEditor.label[1] = guiCreateLabel(10, 27, 340, 88, Fahrschule["Fragen"][Fahrschule.points][1], false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
	guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
    GUIEditor.radiobutton[1] = guiCreateRadioButton(10, 125, 340, 27, Fahrschule["Fragen"][Fahrschule.points][2], false, GUIEditor.window[1])
    GUIEditor.radiobutton[2] = guiCreateRadioButton(10, 162, 340, 27, Fahrschule["Fragen"][Fahrschule.points][3], false, GUIEditor.window[1])
    GUIEditor.radiobutton[3] = guiCreateRadioButton(10, 199, 340, 27, Fahrschule["Fragen"][Fahrschule.points][4], false, GUIEditor.window[1])
    guiRadioButtonSetSelected(GUIEditor.radiobutton[3], true)
    GUIEditor.radiobutton[4] = guiCreateRadioButton(10, 236, 340, 27, Fahrschule["Fragen"][Fahrschule.points][5], false, GUIEditor.window[1])
    GUIEditor.button[1] = guiCreateButton(10, 273, 340, 28, "Weiter", false, GUIEditor.window[1])
    GUIEditor.button["Close"] = guiCreateButton(10, 309, 340, 28, "Abbrechen", false, GUIEditor.window[1])
	
	addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
		if(not(guiRadioButtonGetSelected(GUIEditor.radiobutton[Fahrschule["Fragen"][Fahrschule.points][6]])) == true)then
			Fahrschule.falscheAntworten = Fahrschule.falscheAntworten + 1
		end
		if(Fahrschule.points < 3)then
			Fahrschule.fragebogen()
		else
			Fahrschule.points = 0
			if(Fahrschule.falscheAntworten > 1)then
				infobox("Du hast zu viele Fragen falsch beantwortet!",255,0,0)
			else
				Fahrschule.createMarker()
				triggerServerEvent("Fahrschule.vehicle",localPlayer)
			end
			setWindowDatas("reset")
		end
	end,false)
end
addEvent("Fahrschule.fragebogen",true)
addEventHandler("Fahrschule.fragebogen",root,Fahrschule.fragebogen)

function Fahrschule.createMarker()
	if(isElement(Fahrschule.newMarker))then destroyElement(Fahrschule.newMarker)end
	if(isElement(Fahrschule.blip))then destroyElement(Fahrschule.blip)end
	
	if(Fahrschule.points < 10)then
		Fahrschule.points = Fahrschule.points + 1
		Fahrschule.newMarker = createMarker(Fahrschule["Marker"][Fahrschule.points][1],Fahrschule["Marker"][Fahrschule.points][2],Fahrschule["Marker"][Fahrschule.points][3],"checkpoint",2,255,0,0)
		Fahrschule.blip = createBlip(Fahrschule["Marker"][Fahrschule.points][1],Fahrschule["Marker"][Fahrschule.points][2],Fahrschule["Marker"][Fahrschule.points][3],0,2,255,0,0)
		
		addEventHandler("onClientMarkerHit",Fahrschule.newMarker,function(player)
			if(player == localPlayer)then
				if(Fahrschule.points >= 10)then
					triggerServerEvent("Fahrschule.vehicle",localPlayer)
					setElementData(localPlayer,"Autoschein",1)
					infobox("Du hast die Prüfung bestanden und den Autoschein erhalten.",0,255,0)
				end
				Fahrschule.createMarker()
			end
		end)
	end
end