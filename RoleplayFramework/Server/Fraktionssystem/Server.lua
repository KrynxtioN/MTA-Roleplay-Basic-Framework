Fraktionssystem = {
	["Fahrzeuge"] = { -- model,x,y,z,rotation,kennzeichen,fraktion, soll das Fahrzeug nicht gefärbt werden?
		{596,1545.5999755859,-1684.4000244141,5.6999998092651,90,"SFPD",1,true},
		{596,1545.6999511719,-1680.3000488281,5.6999998092651,90,"SFPD",1,true},
		{596,1545.6999511719,-1676.1999511719,5.6999998092651,90,"SFPD",1,true},
		{596,1534.5,-1659.8000488281,13.199999809265,0,"SFPD",1,true},
		{596,1534.400390625,-1653.2998046875,13.199999809265,0,"SFPD",1,true},
		{409,1000.900390625,-1106.7998046875,23.799999237061,91.99951171875,"Yakuza",2},
		{560,997.099609375,-1083.7001953125,23.60000038147,180,"Yakuza",2},
		{560,1001.2998046875,-1083.7001953125,23.60000038147,180,"Yakuza",2},
		{560,1004.599609375,-1083.7001953125,23.60000038147,180,"Yakuza",2},
		{560,1008.7998046875,-1083.7001953125,23.60000038147,180,"Yakuza",2},
		{560,1012,-1083.7001953125,23.60000038147,180,"Yakuza",2},
		{560,1016.400390625,-1083.7001953125,23.60000038147,180,"Yakuza",2},
		{477,1029.099609375,-1104.7998046875,23.700000762939,0,"Yakuza",2},
		{418,1045.2001953125,-1082.2998046875,24,90,"Yakuza",2},
		{418,1045.2001953125,-1086.099609375,24,90,"Yakuza",2},
		{418,1045.2001953125,-1090,24,90,"Yakuza",2},
		{581,1047.5,-1106.2998046875,23.5,0,"Yakuza",2},
		{581,1046.099609375,-1106.2998046875,23.5,0,"Yakuza",2},
		{581,1044.599609375,-1106.2998046875,23.5,0,"Yakuza",2},
		{582,763.5,-1334.0999755859,13.699999809265,180,"Reporter",4},
		{582,767.40002441406,-1334.0999755859,13.699999809265,180,"Reporter",4},
		{582,771.20001220703,-1336.6999511719,13.699999809265,180,"Reporter",4},
		{480,784.20001220703,-1332.3000488281,13.39999961853,90,"Reporter",4},
		{480,784.20001220703,-1336.6999511719,13.39999961853,90,"Reporter",4},
		{480,784.20001220703,-1339.8000488281,13.39999961853,90,"Reporter",4},
		{480,784.20001220703,-1344.1999511719,13.39999961853,90,"Reporter",4},
		{586,785.5,-1361.6999511719,13.10000038147,90,"Reporter",4},
		{586,785.5,-1363.5999755859,13.10000038147,90,"Reporter",4},
		{586,785.5,-1365.5,13.10000038147,90,"Reporter",4},
		{586,785.5,-1367.4000244141,13.10000038147,90,"Reporter",4},},
	["Fraktioncolors"] = {
		[0] = {255,255,255},
		[1] = {0,255,0},
		[2] = {150,0,0},
		[3] = {100,50,50},
		[4] = {250,150,0},},
	}
	
function isStateFaction(player)
	local faction = getElementData(player,"Fraktion")
	if(faction == 1)then return true else return false end
end

function isEvil(player)
	local faction = getElementData(player,"Fraktion")
	if(faction == 2 or faction == 3)then return true else return false end
end

function Fraktionssystem.open(player)
	if(getElementData(player,"Fraktion") >= 1)then
		triggerClientEvent(player,"Fraktionssystem.open",player)
		triggerClientEvent(player,"Fraktionssystem.refresh",player,getFactionDatas(getElementData(player,"Fraktion")))
	end
end

function getFactionDatas(fraktion)
	local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
	local geldinhalt = getDatabaseData("fraktionskasse","ID",fraktion,"GeldInhalt")
	local mitglieder = {}
	for _,v in pairs(result)do
		if(v["Fraktion"] == fraktion)then
			table.insert(mitglieder,{v["Name"],v["Fraktionsrang"]})
		end
	end
	return {geldinhalt,mitglieder}
end

addEvent("Fraktionssystem.inviteUninvite",true)
addEventHandler("Fraktionssystem.inviteUninvite",root,function(type,target)
	local target = getPlayerFromName(target)
	if(getElementData(client,"Fraktionsrang") >= 5)then
		if(isElement(target) and getElementData(target,"loggedin") == 1)then
			if(type == "invite")then
				if(getElementData(target,"Fraktion") == 0)then
					setElementData(target,"Fraktion",getElementData(client,"Fraktion"))
					setElementData(target,"Fraktionsrang",0)
					infobox(target,getPlayerName(client).." hat dich in seine Fraktion aufgenommen.",0,255,0)
					infobox(client,"Du hast "..getPlayerName(target).." in deine Fraktion aufgenommen.",0,255,0)
				else infobox(client,"Dies ist nicht möglich!",255,0,0)end
			else
				if(getElementData(target,"Fraktion") == getElementData(client,"Fraktion"))then
					setElementData(target,"Fraktion",0)
					setElementData(target,"Fraktionsrang",0)
					infobox(target,getPlayerName(client).." hat dich uninvitet!",255,0,0)
					infobox(client,"Du hast "..getPlayerName(target).." uninvitet.",255,0,0)
					triggerClientEvent(target,"Fraktionssystem.checkOpen",target)
				else infobox(client,"Dies ist nicht möglich!",255,0,0)end
			end
			dbExec(handler,"UPDATE userdata SET Fraktion = '"..getElementData(target,"Fraktion").."' WHERE Name = '"..getPlayerName(target).."'")
			triggerClientEvent(client,"Fraktionssystem.refresh",client,getFactionDatas(getElementData(client,"Fraktion")))
		else infobox(client,"Der Spieler ist nicht eingeloggt oder nicht auf dem Server!",255,0,0)end
	else infobox(client,"Du bist nicht befugt!",255,0,0)end
end)

addEvent("Fraktionssystem.rangUpRangDown",true)
addEventHandler("Fraktionssystem.rangUpRangDown",root,function(type,target)
	local target = getPlayerFromName(target)
	if(getElementData(client,"Fraktionsrang") >= 4)then
		if(isElement(target) and getElementData(target,"loggedin") == 1)then
			if(type == "rangup")then
				if(getElementData(target,"Fraktionsrang") < getElementData(client,"Fraktionsrang"))then
					setElementData(target,"Fraktionsrang",getElementData(target,"Fraktionsrang")+1)
					infobox(target,getPlayerName(client).." hat dich befördert!",0,255,0)
					infobox(client,"Du hast "..getPlayerName(target).." befördert.",0,255,0)
				else infobox(client,"Dies ist nicht möglich!",255,0,0)end
			else
				if(getElementData(target,"Fraktionsrang") ~= 0)then
					setElementData(target,"Fraktionsrang",getElementData(target,"Fraktionsrang")-1)
					infobox(target,getPlayerName(client).." hat dich degradiert!",255,0,0)
					infobox(client,"Du hast "..getPlayerName(target).." degradiert.",255,0,0)
				else infobox(client,"Dies ist nicht möglich!",255,0,0)end
			end
			dbExec(handler,"UPDATE userdata SET Fraktionsrang = '"..getElementData(target,"Fraktionsrang").."' WHERE Name = '"..getPlayerName(target).."'")
			triggerClientEvent(client,"Fraktionssystem.refresh",client,getFactionDatas(getElementData(client,"Fraktion")))
		else infobox(client,"Der Spieler ist nicht eingeloggt oder nicht auf dem Server!",255,0,0)end
	else infobox(client,"Du bist nicht befugt!",255,0,0)end
end)

addEvent("Fraktionssystem.einAuszahlen",true)
addEventHandler("Fraktionssystem.einAuszahlen",root,function(type,summe)
	local summe = tonumber(summe)
	local geldinhalt = tonumber(getDatabaseData("fraktionskasse","ID",getElementData(client,"Fraktion"),"GeldInhalt"))
	if(type == "einzahlen")then
		if(tonumber(getElementData(client,"Geld")) >= summe)then
			setElementData(client,"Geld",getElementData(client,"Geld")-summe)
			infobox(client,"Du hast "..summe.."$ eingezahlt.",0,255,0)
			dbExec(handler,"UPDATE fraktionskasse SET Geldinhalt = '"..geldinhalt+summe.."' WHERE ID = '"..getElementData(client,"Fraktion").."'")
		else infobox(client,"Du hast nicht genug Geld bei dir!",255,0,0)end
	else
		if(getElementData(client,"Fraktionsrang") >= 5)then
			if(geldinhalt >= summe)then
				setElementData(client,"Geld",getElementData(client,"Geld")+summe)
				infobox(client,"Du hast "..summe.."$ ausgezahlt.",0,255,0)
				dbExec(handler,"UPDATE fraktionskasse SET Geldinhalt = '"..geldinhalt-summe.."' WHERE ID = '"..getElementData(client,"Fraktion").."'")
			else infobox(client,"In der Fraktionskasse befindet sich nicht genug Geld!",255,0,0)end
		else infobox(client,"Du bist nicht befugt!",255,0,0)end
	end
	triggerClientEvent(client,"Fraktionssystem.refresh",client,getFactionDatas(getElementData(client,"Fraktion")))
end)

function putMoneyInFactionDepot(cash,faction)
	local geld = tonumber(getDatabaseData("fraktionskasse","ID",faction,"GeldInhalt"))
	local newGeld = geld + cash
	dbExec(handler,"UPDATE fraktionskasse SET GeldInhalt = '"..newGeld.."' WHERE ID = '"..faction.."'")
end