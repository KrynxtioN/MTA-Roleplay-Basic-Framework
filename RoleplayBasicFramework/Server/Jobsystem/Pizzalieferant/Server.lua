Pizzalieferant = {
	["Fahrzeuge"] = { -- model,x,y,z,rx,ry,rz
		{448,2113,-1789.3000488281,13.199999809265,0,0,0},
		{448,2111.3000488281,-1789.3000488281,13.199999809265,0,0,0},
		{448,2109.6000976563,-1789.3000488281,13.199999809265,0,0,0},},
	}
	
for _,v in pairs(Pizzalieferant["Fahrzeuge"])do
	local vehicle = createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7],"Pizzalieferant")
	setElementFrozen(vehicle,true)
	
	addEventHandler("onVehicleEnter",vehicle,function(player)
		if(getPedOccupiedVehicleSeat(player) == 0)then
			if(getElementData(player,"Job") == "Pizzalieferant")then
				setElementFrozen(source,false)
				triggerClientEvent(player,"Pizzalieferant.createMarker",player,"create")
			else
				exitVehicle(player)
				infobox(player,"Du bist kein Pizzalieferant!",255,0,0)
			end
		end
	end)
	
	addEventHandler("onVehicleExit",vehicle,function(player)
		triggerClientEvent(player,"Pizzalieferant.createMarker",player)
		triggerClientEvent(player,"Pizzalieferant.reset",player)
		respawnVehicle(source)
	end)
end

addEvent("Pizzalieferant.abgeben",true)
addEventHandler("Pizzalieferant.abgeben",root,function()
	local trinkgeld = math.random(5,10)
	local money = 50+trinkgeld
	infobox(client,"Du hast "..money.."$ (Davon "..trinkgeld.."$ Trinkgeld).",0,255,0)
	setElementData(client,"Geld",getElementData(client,"Geld")+money)
end)