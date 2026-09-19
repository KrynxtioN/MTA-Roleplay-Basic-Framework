addEvent("Inventar.use",true)
addEventHandler("Inventar.use",root,function(item)
	if(item == "Hamburger")then
		setElementHealth(client,100)
		infobox(client,"Du hast einen Hamburger gegessen.",0,255,0)
		setElementData(client,item,getElementData(client,item)-1)
	elseif(item == "Weed")then
		setElementHealth(client,100)
		infobox(client,"Du hast 1g Weed geraucht.",0,255,0)
		setElementData(client,item,getElementData(client,item)-1)
		triggerClientEvent(client,"Inventar.useWeed",client)
	elseif(item == "Benzinkanister")then
		if(isPedInVehicle(client))then
			local veh = getPedOccupiedVehicle(client)
			if(getElementData(veh,"Benzin") < 100)then
				setElementData(veh,"Benzin",100)
				if(getElementData(veh,"Besitzer"))then
					local id = getElementData(veh,"ID")
					dbExec(handler,"UPDATE fahrzeuge SET Benzin = '"..getElementData(veh,"Benzin").."' WHERE ID = '"..id.."'")
				end
				setElementData(client,item,getElementData(client,item)-1)
				infobox(client,"Das Fahrzeug wurde betankt.",0,255,0)
			else infobox(client,"Das Fahrzeug ist bereits voll!",0,255,0)end
		else infobox(client,"Du befindest dich in keinem Fahrzeug!",255,0,0)end
	end
	triggerClientEvent(client,"Inventar.items",client)
end)