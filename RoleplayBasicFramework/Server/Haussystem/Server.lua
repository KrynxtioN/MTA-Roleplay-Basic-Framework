Haussystem = {house = {},
	["Interiors"] = {
		[1] = {1,223.19999694824,1287.5,1082.0999755859,0},
		[2] = {5,2233.8000488281,-1114.5,1050.9000244141,0},
		[3] = {8,2365.3000488281-1135.0999755859,1050.9000244141,0},
	},}

function Haussystem.load()
	local result = dbPoll(dbQuery(handler,"SELECT * FROM haussystem"),-1)
	for _,v in pairs(result)do
		if(not(isElement(Haussystem.house[v["ID"]])))then
			if(v["Besitzer"] == "Niemand")then id = 1273 else id = 1272 end
			Haussystem.house[v["ID"]] = createPickup(v["Posx"],v["Posy"],v["Posz"],3,id,50)
			setElementData(Haussystem.house[v["ID"]],"Besitzer",v["Besitzer"])
			setElementData(Haussystem.house[v["ID"]],"Preis",v["Preis"])
			setElementData(Haussystem.house[v["ID"]],"Interior",v["Interior"])
			setElementData(Haussystem.house[v["ID"]],"ID",v["ID"])
			
			addEventHandler("onPickupHit",Haussystem.house[v["ID"]],function(player)
				if(not(isPedInVehicle(player)))then
					setElementData(player,"Hausmarker",source)
					local preis = getElementData(source,"Preis")
					local besitzer = getElementData(source,"Besitzer")
					triggerClientEvent(player,"Haussystem.window",player,preis,besitzer)
				end
			end)
		end
	end
end
Haussystem.load()

addCommandHandler("createhouse",function(player,cmd,interior,preis)
	if(getElementData(player,"Adminlevel") >= 1)then
		if(getElementDimension(player) == 0 and getElementInterior(player) == 0)then
			if(isPedOnGround(player))then
				if(interior and preis)then
					local x,y,z = getElementPosition(player)
					dbExec(handler,"INSERT INTO haussystem (Posx,Posy,Posz,Besitzer,Preis,Interior) VALUES ('"..x.."','"..y.."','"..z.."','Niemand','"..preis.."','"..interior.."')")
					Haussystem.load()
				else infobox(player,"Du hast kein Interior und keinen Preis angegeben!",255,0,0)end
			end
		end
	end
end)

addEvent("Haussystem.buySell",true)
addEventHandler("Haussystem.buySell",root,function(type)
	local hauspickup = getElementData(client,"Hausmarker")
	local x,y,z = getElementPosition(hauspickup)
	if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client)) <= 5)then
		if(type == "Kaufen")then
			if(tonumber(getElementData(client,"Geld")) >= getElementData(hauspickup,"Preis"))then
				if(getElementData(hauspickup,"Besitzer") == "Niemand")then
					setElementData(client,"Geld",getElementData(client,"Geld")-getElementData(hauspickup,"Preis"))
					setElementData(hauspickup,"Besitzer",getPlayerName(client))
					dbExec(handler,"UPDATE haussystem SET Besitzer = '"..getPlayerName(client).."' WHERE ID = '"..getElementData(hauspickup,"ID").."'")
					infobox(client,"Du hast dir das Haus gekauft.",0,255,0)
					triggerClientEvent(client,"setWindowDatas",client)
					setElementData(client,"Housekey",1)
				else infobox(client,"Das Haus gehört bereits wem anders!",255,0,0)end
			else infobox(client,"Du hast nicht genug Geld bei dir!",255,0,0)end
		else
			if(getElementData(hauspickup,"Besitzer") == getPlayerName(client))then
				local preis = getDatabaseData("haussystem","ID",getElementData(hauspickup,"ID"),"Preis")
				setElementData(client,"Geld",getElementData(client,"Geld")+preis)
				setElementData(hauspickup,"Besitzer","Niemand")
				dbExec(handler,"UPDATE haussystem SET Besitzer = 'Niemand' WHERE ID = '"..getElementData(hauspickup,"ID").."'")
				infobox(client,"Du hast dein Haus verkauft und "..preis.."$ zurückbekommen.",0,255,0)
				triggerClientEvent(client,"setWindowDatas",client)
				setElementData(client,"Housekey",0)
			else infobox(client,"Das Haus gehört nicht dir!",255,0,0)end
		end
	end
end)

addEvent("Haussystem.betreten",true)
addEventHandler("Haussystem.betreten",root,function()
	local hauspickup = getElementData(client,"Hausmarker")
	if(getElementData(hauspickup,"Besitzer") == getPlayerName(client))then
		local interior = getElementData(hauspickup,"Interior")
		local id = getElementData(hauspickup,"ID")
		local hausinterior = Haussystem["Interiors"][interior][1]
		local x,y,z,rotation = Haussystem["Interiors"][interior][2],Haussystem["Interiors"][interior][3],Haussystem["Interiors"][interior][4],Haussystem["Interiors"][interior][5]
		setElementPosition(client,x,y,z)
		setPedRotation(client,rotation)
		setElementInterior(client,hausinterior)
		setElementDimension(client,id)
		setElementData(client,"HouseID",id)
		setElementData(client,"inHouse",true)
		triggerClientEvent(client,"setWindowDatas",client)
		infobox(client,"Tippe /out, um dein Haus wieder zu verlassen.",0,255,0)
	else infobox(client,"Das Haus gehört nicht dir!",255,0,0)end
end)

addCommandHandler("out",function(player)
	if(getElementData(player,"inHouse") == true)then
		local hauspickup = getElementData(player,"Hausmarker")
		x,y,z = getElementPosition(hauspickup)
	elseif(getElementData(player,"spawnImHaus") == true)then
		x,y,z = getDatabaseData("haussystem","Besitzer",getPlayerName(player),"Posx"),getDatabaseData("haussystem","Besitzer",getPlayerName(player),"Posy"),getDatabaseData("haussystem","Besitzer",getPlayerName(player),"Posz")
	end
	if(x and y and z)then
		setElementPosition(player,x,y,z)
		setElementInterior(player,0)
		setElementDimension(player,0)
		setElementData(player,"inHouse",false)
	end
end)

function Haussystem.menu(player)
	if(getElementData(player,"inHouse") == true or getElementData(player,"spawnImHaus") == true)then
		local inhalt = getDatabaseData("haussystem","ID",getElementData(player,"HouseID"),"Hauskasse")
		triggerClientEvent(player,"Haussystem.menu",player,inhalt)
	end
end

addCommandHandler("id",function(player)
	setElementData(player,"HouseID",1)
end)

addEvent("Haussystem.einAuszahlen",true)
addEventHandler("Haussystem.einAuszahlen",root,function(type,summe)
	local summe = tonumber(summe)
	local geldinhalt = tonumber(getDatabaseData("haussystem","ID",getElementData(client,"HouseID"),"Hauskasse"))
	if(type == "einzahlen")then
		if(tonumber(getElementData(client,"Geld")) >= summe)then
			setElementData(client,"Geld",getElementData(client,"Geld")-summe)
			infobox(client,"Du hast "..summe.."$ eingezahlt.",0,255,0)
			dbExec(handler,"UPDATE haussystem SET Hauskasse = '"..geldinhalt+summe.."' WHERE ID = '"..getElementData(client,"HouseID").."'")
		else infobox(client,"Du hast nicht genug Geld bei dir!",255,0,0)end
	else
		if(getPlayerName(client) == getDatabaseData("haussystem","ID",getElementData(client,"HouseID"),"Besitzer"))then
			if(geldinhalt >= summe)then
				setElementData(client,"Geld",getElementData(client,"Geld")+summe)
				infobox(client,"Du hast "..summe.."$ ausgezahlt.",0,255,0)
				dbExec(handler,"UPDATE haussystem SET Hauskasse = '"..geldinhalt-summe.."' WHERE ID = '"..getElementData(client,"HouseID").."'")
			else infobox(client,"In der Fraktionskasse befindet sich nicht genug Geld!",255,0,0)end
		else infobox(client,"Du bist nicht befugt!",255,0,0)end
	end
	triggerClientEvent(client,"Haussystem.refresh",client,getDatabaseData("haussystem","ID",getElementData(client,"HouseID"),"Hauskasse"))
end)

addEvent("Haussystem.heilen",true)
addEventHandler("Haussystem.heilen",root,function()
	setElementHealth(client,100)
	setPedArmor(client,100)
	infobox(client,"Du hast dich geheilt.",0,255,0)
end)