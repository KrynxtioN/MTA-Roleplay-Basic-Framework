Eigenmenu = {
	["Standard"] = { -- x,y,z,rot, Interior, Dimension
		["Noobspawn"] = {1468.9000244141,-1771.8000488281,18.799999237061,0,0,0},},
	["Fraktionen"] = {
		[1] = {253.89999389648,79.800003051758,1003.5999755859,180,6,0},
		[2] = {-2158.6999511719,645.90002441406,1057.5999755859,90,1,0},
		[3] = {508.29998779297,-86.900001525879,999,0,11,0},
	},
}
	
addEvent("Eigenmenu.spawn",true)
addEventHandler("Eigenmenu.spawn",root,function(spawn)
	if(spawn == "Fraktion")then
		x,y,z,rotation = Eigenmenu["Fraktionen"][getElementData(client,"Fraktion")][1],Eigenmenu["Fraktionen"][getElementData(client,"Fraktion")][2],Eigenmenu["Fraktionen"][getElementData(client,"Fraktion")][3],Eigenmenu["Fraktionen"][getElementData(client,"Fraktion")][4]
		interior,dimension = Eigenmenu["Fraktionen"][getElementData(client,"Fraktion")][5],Eigenmenu["Fraktionen"][getElementData(client,"Fraktion")][6]
		dbExec(handler,"UPDATE userdata SET Housespawn = '0' WHERE Name = '"..getPlayerName(client).."'")
	elseif(spawn == "Haus")then	
		local id = getDatabaseData("haussystem","Besitzer",getPlayerName(client),"ID")
		local int = getDatabaseData("haussystem","Besitzer",getPlayerName(client),"Interior")
		x,y,z,rotation = Haussystem["Interiors"][int][2],Haussystem["Interiors"][int][3],Haussystem["Interiors"][int][4],Haussystem["Interiors"][int][5]
		interior,dimension = Haussystem["Interiors"][int][1],id
		dbExec(handler,"UPDATE userdata SET Housespawn = '1' WHERE Name = '"..getPlayerName(client).."'")
	else
		x,y,z,rotation = Eigenmenu["Standard"][spawn][1],Eigenmenu["Standard"][spawn][2],Eigenmenu["Standard"][spawn][3],Eigenmenu["Standard"][spawn][4]
		interior,dimension = Eigenmenu["Standard"][spawn][5],Eigenmenu["Standard"][spawn][6]
		dbExec(handler,"UPDATE userdata SET Housespawn = '0' WHERE Name = '"..getPlayerName(client).."'")
	end
	dbExec(handler,"UPDATE userdata SET Posx = '"..x.."', Posy = '"..y.."', Posz = '"..z.."', Rotz = '"..rotation.."', Interior = '"..interior.."', Dimension = '"..dimension.."' WHERE Name = '"..getPlayerName(client).."'")
	infobox(client,"Du hast deinen Spawnpunkt geändert.",0,255,0)
end)