for _,v in pairs(Fraktionssystem["Fahrzeuge"])do
	local vehicle = createVehicle(v[1],v[2],v[3],v[4],0,0,v[5],v[6])
	setElementData(vehicle,"Fraktion",v[7])
	if(not(v[8]))then
		setVehicleColor(vehicle,Fraktionssystem["Fraktioncolors"][v[7]][1],Fraktionssystem["Fraktioncolors"][v[7]][2],Fraktionssystem["Fraktioncolors"][v[7]][3])
	end
	
	addEventHandler("onVehicleStartEnter",vehicle,function(player)
		if(getPedOccupiedVehicleSeat(player) == 0)then
			if(getElementData(player,"Fraktion") ~= getElementData(source,"Fraktion"))then
				infobox(player,"Du bist nicht in der richtigen Fraktion!",255,0,0)
				cancelEvent()
			end
		end
	end)
end