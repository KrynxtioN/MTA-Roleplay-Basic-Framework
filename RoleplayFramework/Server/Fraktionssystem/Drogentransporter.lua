Drogentransporter = {state = false}
Drogentransporter.pickup = createPickup(1708.8988037109,701.40649414063,10.8203125,3,1239,50)

addEventHandler("onPickupHit",Drogentransporter.pickup,function(player)
	if(not(isPedInVehicle(player)))then
		if(isEvil(player))then
			triggerClientEvent(player,"Drogentransporter.open",player)
		end
	end
end)

addEvent("Drogentransporter.start",true)
addEventHandler("Drogentransporter.start",root,function()
	if(getDistanceBetweenPoints3D(1708.8988037109,701.40649414063,10.8203125,getElementPosition(client)) <= 10)then
		if(Drogentransporter.state == false)then
			Drogentransporter.state = true
				
			setTimer(function()
				Drogentransporter.state = false
				outputChatBox("Es kann wieder ein Drogentransporter gestartet werden.",root,0,125,0)
				if(isElement(Drogentransporter.vehicle))then destroyElement(Drogentransporter.vehicle)end
			end,1800000,1)
				
			Drogentransporter.vehicle = createVehicle(455,1703.8000488281,691.20001220703,11.39999961853,0,0,0)
			warpPedIntoVehicle(client,Drogentransporter.vehicle)
			triggerClientEvent(client,"Drogentransporter.create",client,"create")
			outputChatBox("Ein Drogentransporter wurde gestartet!",root,125,0,0)
			triggerClientEvent(client,"setWindowDatas",client,"reset")
			infobox(client,"Bringe den Drogentransporter zu deiner Basis!",0,255,0)
				
			addEventHandler("onVehicleExit",Drogentransporter.vehicle,function(client)
				triggerClientEvent(client,"Drogentransporter.create",client)
			end)
				
			addEventHandler("onVehicleEnter",Drogentransporter.vehicle,function(client)
				if(getPedOccupiedVehicleSeat(client) == 0)then
					triggerClientEvent(client,"Drogentransporter.create",client,"create")
				end
			end)
				
			addEventHandler("onVehicleExplode",Drogentransporter.vehicle,function()
				destroyElement(Drogentransporter.vehicle)
				outputChatBox("Der Drogentransporter wurde zerstört aufgefunden!",root,125,0,0)
					
				for _,v in pairs(getElementsByType("client"))do
					triggerClientEvent(v,"Drogentransporter.create",v)
				end
			end)
		else infobox(client,"Zurzeit kann kein Drogentransporter gestartet werden!",255,0,0)end
	end
end)

addEvent("Drogentransporter.abgabe",true)
addEventHandler("Drogentransporter.abgabe",root,function()
	if(isPedInVehicle(client))then
		local veh = getPedOccupiedVehicle(client)
		if(veh == Drogentransporter.vehicle)then
			destroyElement(Drogentransporter.vehicle)
			outputChatBox("Der Drogentransporter wurde abgegeben!",root,125,0,0)
			putMoneyInFactionDepot(10000,getElementData(client,"Fraktion"))
			infobox(client,"Es wurden 10.000$ in eure Fraktionskasse gelegt.",0,255,0)
			triggerClientEvent(client,"Drogentransporter.create",client)
		end
	end
end)