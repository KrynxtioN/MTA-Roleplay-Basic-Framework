Busfahrer = {
	["Fahrzeuge"] = { -- model,x,y,z,rx,ry,rz
		{431,1065.3000488281,-1775.5,13.60000038147,0,0,270},
		{431,1065.3000488281,-1769.7001953125,13.60000038147,0,0,270},
		{431,1065.3000488281,-1763.900390625,13.60000038147,0,0,270},
		{431,1065.3000488281,-1757.8000488281,13.60000038147,0,0,270},},
	}
	
for _,v in pairs(Busfahrer["Fahrzeuge"])do
	local vehicle = createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7],"Busjob")
	setElementFrozen(vehicle,true)
	
	addEventHandler("onVehicleEnter",vehicle,function(player)
		if(getPedOccupiedVehicleSeat(player) == 0)then
			if(getElementData(player,"Job") == "Busfahrer")then
				setElementData(source,false)
				triggerClientEvent(player,"Busfahrer.createMarker",player,"create")
			else
				exitVehicle(player)
				infobox(player,"Du bist kein Busfahrer!",255,0,0)
			end
		end
	end)
	
	addEventHandler("onVehicleExit",vehicle,function(player)
		triggerClientEvent(player,"Busfahrer.createMarker",player)
		triggerClientEvent(player,"Busfahrer.reset",player)
		respawnVehicle(source)
	end)
end

addEvent("Busfahrer.stop",true)
addEventHandler("Busfahrer.stop",root,function()
	respawnVehicle(getPedOccupiedVehicle(client))
	infobox(client,"Route beendet - du hast 1000$ erhalten.",0,255,0)
	setElementData(client,"Geld",getElementData(client,"Geld")+1000)
	triggerClientEvent(client,"Busfahrer.reset",client)
	triggerClientEvent(client,"Busfahrer.createMarker",client,"create")
end)

addEvent("Busfahrer.passanten",true)
addEventHandler("Busfahrer.passanten",root,function()
	local passanten = math.random(1,5)
	local money = passanten*5
	infobox(client,"Es sind "..passanten.." Passanten eingestiegen, du erhältst einen Bonus von "..money.."$.",0,255,0)
	setElementData(client,"Geld",getElementData(client,"Geld")+money)
end)