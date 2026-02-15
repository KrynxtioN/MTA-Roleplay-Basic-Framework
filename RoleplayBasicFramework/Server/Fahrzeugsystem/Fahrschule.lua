Fahrschule = {fahrzeug = {}}

addEvent("Fahrschule.beantragen",true)
addEventHandler("Fahrschule.beantragen",root,function(schein,preis)
	local preis = tonumber(preis)
	if(tonumber(getElementData(client,"Geld")) >= preis)then
		if(getElementData(client,schein) ~= 1)then
			setElementData(client,"Geld",getElementData(client,"Geld")+preis)
			if(schein ~= "Autoschein")then
				setElementData(client,schein,1)
				infobox(client,"Du bist nun im Besitz des "..schein..".",0,255,0)
			else
				triggerClientEvent(client,"Fahrschule.fragebogen",client)
			end
		else infobox(client,"Du hast den Schein bereits!",255,0,0)end
	else infobox(client,"Du hast nicht genug Geld bei dir!",255,0,0)end
end)

addEvent("Fahrschule.vehicle",true)
addEventHandler("Fahrschule.vehicle",root,function()
	if(isElement(Fahrschule.fahrzeug[client]))then
		destroyElement(Fahrschule.fahrzeug[client])
	else
		Fahrschule.fahrzeug[client] = createVehicle(560,689.32586669922,-1571.8088378906,14.2421875,0,0,180)
		warpPedIntoVehicle(client,Fahrschule.fahrzeug[client])
		setElementInterior(client,0)
		setElementDimension(client,0)
	end
end)