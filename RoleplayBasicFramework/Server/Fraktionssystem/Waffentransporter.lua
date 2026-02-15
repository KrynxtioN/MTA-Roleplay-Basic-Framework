Waffentransporter = {state = false}
Waffentransporter.pickup = createPickup(2323.6462402344,75.80046081543,26.483192443848,3,1239,50)

addEventHandler("onPickupHit",Waffentransporter.pickup,function(player)
	if(not(isPedInVehicle(player)))then
		if(isEvil(player) or isStateFaction(player))then
			triggerClientEvent(player,"Waffentransporter.open",player)
		end
	end
end)

addEvent("Waffentransporter.start",true)
addEventHandler("Waffentransporter.start",root,function()
	if(getDistanceBetweenPoints3D(2323.6462402344,75.80046081543,26.483192443848,getElementPosition(client)) <= 10)then
		if(Waffentransporter.state == false)then
			Waffentransporter.vehicle = createVehicle(455,2327.5,86.800003051758,26.89999961853,0,0,90)
			warpPedIntoVehicle(client,Waffentransporter.vehicle)
			triggerClientEvent(client,"Waffentransporter.create",client,"create")
			outputChatBox("Ein Waffentransporter wurde gestartet!",root,125,0,0)
			
			addEventHandler("onVehicleExit",Waffentransporter.vehicle,function(client)
				triggerClientEvent(client,"Waffentransporter.create",client)
			end)
					
			addEventHandler("onVehicleEnter",Waffentransporter.vehicle,function(client)
				if(getPedOccupiedVehicleSeat(client) == 0)then
					triggerClientEvent(client,"Waffentransporter.create",client,"create")
				end
			end)
					
			addEventHandler("onVehicleExplode",Waffentransporter.vehicle,function()
				destroyElement(Waffentransporter.vehicle)
				outputChatBox("Der Waffentransporter wurde zerstört aufgefunden!",root,125,0,0)
						
				for _,v in pairs(getElementsByType("client"))do
					triggerClientEvent(v,"Waffentransporter.create",v)
				end
			end)
		else infobox(client,"Vor kurzem wurde bereits ein Waffentransporter gestartet!",255,0,0)end
	end
end)

addEvent("Waffentransporter.abgabe",true)
addEventHandler("Waffentransporter.abgabe",root,function()
	if(isPedInVehicle(client))then
		local veh = getPedOccupiedVehicle(client)
		if(veh == Waffentransporter.vehicle)then
			local einheiten = tonumber(getDatabaseData("fraktionskasse","ID",getElementData(client,"Fraktion"),"Waffenlager"))
			if(einheiten < 250)then
				local newEinheiten = einheiten + 25
				if(newEinheiten > 250)then newEinheiten = 250 end
				dbExec(handler,"UPDATE fraktionskasse SET Waffenlager = '"..newEinheiten.."' WHERE ID = '"..getElementData(client,"Fraktion").."'")
				infobox(client,"Es wurden 25 Einheiten ins Lager gelegt.",0,255,0)
			else
				putMoneyInFactionDepot(10000,getElementData(client,"Fraktion"))
				infobox(client,"Es wurden 10.000$ in eure Fraktionskasse gelegt.",0,255,0)
			end
			destroyElement(Waffentransporter.vehicle)
			outputChatBox("Der Waffentransporter wurde abgegeben!",root,125,0,0)
			triggerClientEvent(client,"Waffentransporter.create",client)
		end
	end
end)