Fahrzeugsystem = {vehicle = {},
	["Fahrzeuge"] = { -- Model, x,y,z,xr,xy,yz
		-- Grotti
		{560,565.40002441406,-1291.5999755859,17.10000038147,0,0,0},
		{411,561.5,-1291.5,17,0,0,0},
		{541,557.59997558594,-1291.8000488281,16.89999961853,0,0,0},
		{401,553.40002441406,-1291.5,17.10000038147,0,0,0},
		{474,549,-1291.0999755859,17.10000038147,0,0,0},
		{555,544.90002441406,-1291.5,17,0,0,0},
		{429,540.90002441406,-1291.5,17,0,0,0},
		-- Coutt and Schutz
		{549,2119.5,-1122.0999755859,25.299999237061,0,0,252},
		{518,2119.5,-1127,25.200000762939,0,0,252},
		{545,2118.6999511719,-1131.4000244141,25.200000762939,0,0,252},
		{496,2118.5,-1136,25,0,0,252},
		{421,2135.8000488281,-1128.0999755859,25.60000038147,0,0,90},
		{536,2135.6999511719,-1132.3000488281,25.5,0,0,90},
		{491,2135.8000488281,-1136.5999755859,25.5,0,0,90},},
	["Daten"] = {
		-- Grotti
		[560] = {35000,544.7998046875,-1258.5,16.700000762939,0,0,306},
		[411] = {55000,544.7998046875,-1258.5,16.700000762939,0,0,306},
		[541] = {75000,544.7998046875,-1258.5,16.700000762939,0,0,306},
		[401] = {22000,544.7998046875,-1258.5,16.700000762939,0,0,306},
		[474] = {29000,544.7998046875,-1258.5,16.700000762939,0,0,306},
		[555] = {25000,544.7998046875,-1258.5,16.700000762939,0,0,306},
		[429] = {45000,544.7998046875,-1258.5,16.700000762939,0,0,306},
		-- Coutt and Schutz
		[549] = {1900,2162.1000976563,-1142.9000244141,24.89999961853,0,0,90},
		[518] = {5000,2162.1000976563,-1142.9000244141,24.89999961853,0,0,90},
		[545] = {8000,2162.1000976563,-1142.9000244141,24.89999961853,0,0,90},
		[496] = {7500,2162.1000976563,-1142.9000244141,24.89999961853,0,0,90},
		[421] = {11000,2162.1000976563,-1142.9000244141,24.89999961853,0,0,90},
		[536] = {13500,2162.1000976563,-1142.9000244141,24.89999961853,0,0,90},
		[491] = {9500,2162.1000976563,-1142.9000244141,24.89999961853,0,0,90},}
	}
	
for _,v in pairs(Fahrzeugsystem["Fahrzeuge"])do
	local vehicle = createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
	setElementFrozen(vehicle,true)
	setVehicleDamageProof(vehicle,true)
	
	addEventHandler("onVehicleEnter",vehicle,function(player)
		local model = getElementModel(getPedOccupiedVehicle(player))
		local preis = Fahrzeugsystem["Daten"][model][1]
		triggerClientEvent(player,"Fahrzeugsystem.window",player,preis)
	end)
end

addEvent("Fahrzeugsystem.buy",true)
addEventHandler("Fahrzeugsystem.buy",root,function()
	local veh = getPedOccupiedVehicle(client)
	local model = getElementModel(veh)
	local preis = Fahrzeugsystem["Daten"][model][1]
	if(tonumber(getElementData(client,"Geld")) >= preis)then
		local x,y,z = Fahrzeugsystem["Daten"][model][2],Fahrzeugsystem["Daten"][model][3],Fahrzeugsystem["Daten"][model][4]
		local rx,ry,rz = Fahrzeugsystem["Daten"][model][5],Fahrzeugsystem["Daten"][model][6],Fahrzeugsystem["Daten"][model][7]
		setElementData(client,"Geld",getElementData(client,"Geld")-preis)
		dbExec(handler,"INSERT INTO fahrzeuge (Besitzer,Model,Posx,Posy,Posz,Rotz,Benzin) VALUES ('"..getPlayerName(client).."','"..model.."','"..x.."','"..y.."','"..z.."','"..rz.."','100')")
		setElementData(client,"buyedVehicle",true)
		createPrivateVehicles(client)
		triggerClientEvent(client,"setWindowDatas",client)
	else infobox(client,"Du hast nicht genug Geld bei dir!",255,0,0)end
end)

function createPrivateVehicles(player)
	local result = dbPoll(dbQuery(handler,"SELECT * FROM fahrzeuge"),-1)
	for _,v in pairs(result)do
		if(v["Besitzer"] == getPlayerName(player))then
			if(not(isElement(Fahrzeugsystem.vehicle[v["ID"]])))then
				Fahrzeugsystem.vehicle[v["ID"]] = createVehicle(v["Model"],v["Posx"],v["Posy"],v["Posz"],0,0,v["Rotz"],v["Besitzer"])
				setElementData(Fahrzeugsystem.vehicle[v["ID"]],"Besitzer",v["Besitzer"])
				setElementFrozen(Fahrzeugsystem.vehicle[v["ID"]],true)
				setElementData(Fahrzeugsystem.vehicle[v["ID"]],"ID",v["ID"])
				setElementData(Fahrzeugsystem.vehicle[v["ID"]],"Benzin",v["Benzin"])
				
				if(getElementData(player,"buyedVehicle") == true)then
					warpPedIntoVehicle(player,Fahrzeugsystem.vehicle[v["ID"]])
					setElementData(player,"buyedVehicle",nil)
					setElementFrozen(Fahrzeugsystem.vehicle[v["ID"]],false)
				end
			end
		end
	end
end

function Fahrzeugsystem.openVerwaltung(player)
	local result = dbPoll(dbQuery(handler,"SELECT * FROM fahrzeuge"),-1)
	local vehicles = {}
	for _,v in pairs(result)do
		if(v["Besitzer"] == getPlayerName(player))then
			table.insert(vehicles,{v["ID"],getVehicleNameFromModel(v["Model"])})
		end
	end
	triggerClientEvent(player,"Fahrzeugsystem.verwaltung",player,vehicles)
end

addEvent("Fahrzeugsystem.verkaufen",true)
addEventHandler("Fahrzeugsystem.verkaufen",root,function(id,name)
	local preis = Fahrzeugsystem["Daten"][getVehicleModelFromName(name)][1]
	setElementData(client,"Geld",getElementData(client,"Geld")+preis)
	dbExec(handler,"DELETE FROM fahrzeuge WHERE ID = '"..id.."'")
	infobox(client,"Du hast dein Fahrzeug für "..preis.."$ verkauft.",0,255,0)
end)

addEvent("Fahrzeugsystem.orten",true)
addEventHandler("Fahrzeugsystem.orten",root,function(id)
	local id = tonumber(id)
	local x,y,z = getElementPosition(Fahrzeugsystem.vehicle[id])
	local zone = getZoneName(x,y,z)
	infobox(client,"Dein Fahrzeug befindet sich in "..zone..".",0,255,0)
end)

addEvent("Fahrzeugsystem.respawnen",true)
addEventHandler("Fahrzeugsystem.respawnen",root,function(id)
	local id = tonumber(id)
	local x,y,z = getDatabaseData("fahrzeuge","ID",id,"Posx"),getDatabaseData("fahrzeuge","ID",id,"Posy"),getDatabaseData("fahrzeuge","ID",id,"Posz")
	local rotation = getDatabaseData("fahrzeuge","ID",id,"Rotz")
	setElementPosition(Fahrzeugsystem.vehicle[id],x,y,z)
	setElementRotation(Fahrzeugsystem.vehicle[id],0,0,rotation)
	fixVehicle(Fahrzeugsystem.vehicle[id])
	infobox(client,"Dein Fahrzeug wurde respawnt.",0,255,0)
end)

function Fahrzeugsystem.handbremse(player)
	if(isPedInVehicle(player))then
		if(getPedOccupiedVehicleSeat(player) == 0)then
			local veh = getPedOccupiedVehicle(player)
			if(getElementData(veh,"Besitzer") == getPlayerName(player))then
				if(isElementFrozen(veh))then
					setElementFrozen(veh,false)
					infobox(player,"Du hast die Handbremse gelöst.",0,255,0)
				else
					setElementFrozen(veh,true)
					infobox(player,"Du hast die Handbremse angezogen.",0,255,0)
				end
			end
		end
	end
end
addCommandHandler("handbremse",Fahrzeugsystem.handbremse)

addCommandHandler("park",function(player)
	if(isPedInVehicle(player))then
		if(getPedOccupiedVehicleSeat(player) == 0)then
			local veh = getPedOccupiedVehicle(player)
			if(getElementData(veh,"Besitzer") == getPlayerName(player))then
				local x,y,z = getElementPosition(veh)
				local rx,ry,rz = getElementRotation(veh)
				dbExec(handler,"UPDATE fahrzeuge SET Posx = '"..x.."', Posy = '"..y.."', Posz = '"..z.."', Rotz = '"..rz.."' WHERE ID = '"..getElementData(veh,"ID").."'")
				infobox(player,"Du hast dein Fahrzeug umgeparkt.",0,255,0)
			end
		end
	end
end)

addCommandHandler("lock",function(player)
	for _,v in pairs(getElementsByType("vehicle"))do
		if(getElementData(v,"Besitzer") == getPlayerName(player))then
			local x,y,z = getElementPosition(v)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player)) <= 3.5)then
				if(isVehicleLocked(v))then
					setVehicleLocked(v,false)
					infobox(player,"Du hast dein Fahrzeug aufgeschlossen.",0,255,0)
				else
					setVehicleLocked(v,true)
					infobox(player,"Du hast dein Fahrzeug abgeschlossen.",255,0,0)
				end
			end
		end
	end
end)

function Fahrzeugsystem.motor(player)
	if(isPedInVehicle(player))then
		if(getPedOccupiedVehicleSeat(player) == 0)then
			local veh = getPedOccupiedVehicle(player)
			
			if(getElementData(veh,"Besitzer") or getElementData(veh,"Fraktion"))then
				if(getElementData(veh,"Besitzer") == getPlayerName(player) or getElementData(veh,"Fraktion") == getElementData(player,"Fraktion"))then
					return true
				else
					return false
				end
			end
			
			if(getVehicleEngineState(veh))then
				setVehicleEngineState(veh,false)
				setElementData(veh,"motor","off")
			else
				setVehicleEngineState(veh,true)
				setElementData(veh,"motor","on")
			end
		end
	end
end

function Fahrzeugsystem.licht(player)
	if(isPedInVehicle(player))then
		if(getPedOccupiedVehicleSeat(player) == 0)then
			local veh = getPedOccupiedVehicle(player)
			
			if(getElementData(veh,"Besitzer") or getElementData(veh,"Fraktion"))then
				if(getElementData(veh,"Besitzer") == getPlayerName(player) or getElementData(veh,"Fraktion") == getElementData(player,"Fraktion"))then
					return true
				else
					return false
				end
			end
			
			if(getVehicleOverrideLights(veh) ~= 2)then
				setVehicleOverrideLights(veh,2)
				setElementData(veh,"licht","on")
			else
				setVehicleOverrideLights(veh,1)
				setElementData(veh,"licht","off")
			end
		end
	end
end

addEventHandler("onVehicleEnter",root,function(player)
	if(not(getElementData(source,"motor")))then setElementData(source,"motor","off")end
	if(not(getElementData(source,"licht")))then setElementData(source,"licht","off")end
	if(not(getElementData(source,"Benzin")))then setElementData(source,"Benzin",100)end
	
	if(getElementData(source,"motor") == "on")then
		setVehicleEngineState(source,true)
	else
		setVehicleEngineState(source,false)
	end
	if(getElementData(source,"licht") == "on")then
		setVehicleOverrideLights(source,2)
	else
		setVehicleOverrideLights(source,1)
	end
end)

setTimer(function()
	for _,v in pairs(getElementsByType("vehicle"))do
		if(getElementData(v,"motor") == "on")then
			setElementData(v,"Benzin",getElementData(v,"Benzin")-1)
			if(getElementData(v,"Besitzer"))then
				local id = getElementData(v,"ID")
				dbExec(handler,"UPDATE fahrzeuge SET Benzin = '"..getElementData(v,"Benzin").."' WHERE ID = '"..id.."'")
			end
		end
	end
end,5000,0)

function exitVehicle(player)
	local veh = getPedOccupiedVehicle(player)
	if(isElement(veh))then
		if(getPedOccupiedVehicleSeat(player) == 0)then
			setElementVelocity(veh,0,0,0)
		end
		setControlState(player,"enter_exit",false)
		setTimer(removePedFromVehicle,750,1,player)
		setTimer(setControlState,125,1,player,"enter_exit",false)
		setTimer(setControlState,125,1,player,"enter_exit",true)
		setTimer(setControlState,700,1,player,"enter_exit",false)
	end
end