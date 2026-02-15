Tankstelle = {preis = math.random(5,10),
	["Marker"] = {
		{1938.1999511719,-1771.4000244141,12.5},
		{1000,-940.5,41.299999237061},
	}
}

for _,v in pairs(Tankstelle["Marker"])do
	local marker = createMarker(v[1],v[2],v[3],"cylinder",3,0,0,200)
	createBlip(v[1],v[2],v[3],42,0,0,0,0,0,0,100)
	
	addEventHandler("onMarkerHit",marker,function(player)
		if(getElementType(player) == "vehicle")then
			local player = getVehicleOccupant(player,0)
			if(getPedOccupiedVehicleSeat(player) == 0)then
				setElementData(player,"entfreezeAfterClose",true)
				setElementFrozen(getPedOccupiedVehicle(player),true)
				triggerClientEvent(player,"Tankstelle.open",player)
			end
		end
	end)
end

addEvent("Tankstelle.server",true)
addEventHandler("Tankstelle.server",root,function(liter)
	local benzin = getElementData(getPedOccupiedVehicle(client),"Benzin")
	if(liter)then
		if(tonumber(getElementData(client,"Geld")) >= liter*Tankstelle.preis)then
			if(benzin+liter <= 100)then
				setElementData(getPedOccupiedVehicle(client),"Benzin",getElementData(getPedOccupiedVehicle(client),"Benzin")+liter)
				setElementData(client,"Geld",getElementData(client,"Geld")-liter*Tankstelle.preis)
				infobox(client,"Das Fahrzeug wurde betankt.",0,255,0)
			else infobox(client,"So viel Liter kannst du nicht tanken!",255,0,0)end
		else infobox(client,"Du hast nicht genug Geld!",255,0,0)end
	else
		local liter = 100 - benzin
		if(tonumber(getElementData(client,"Geld")) >= liter*Tankstelle.preis)then
			setElementData(getPedOccupiedVehicle(client),"Benzin",100)
			setElementData(client,"Geld",getElementData(client,"Geld")-liter*Tankstelle.preis)
			infobox(client,"Das Fahrzeug wurde betankt.",0,255,0)
		else infobox(client,"Du hast nicht genug Geld!",255,0,0)end
	end
end)