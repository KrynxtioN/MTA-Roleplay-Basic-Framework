Faggioverleih = {vehicles = {}}
Faggioverleih.marker = createMarker(1466.1999511719,-1738.9000244141,12.60000038147,"cylinder",1.5,0,0,200,100)

addEventHandler("onMarkerHit",Faggioverleih.marker,function(player)
	if(not(isPedInVehicle(player)))then
		bindKey(player,"j","down",Faggioverleih.server)
		infobox(player,"Drücke 'j', um dir ein Faggio auszuleihen.",0,255,0)
	end
end)

addEventHandler("onMarkerLeave",Faggioverleih.marker,function(player)
	unbindKey(player,"j","down",Faggioverleih.server)
end)

function Faggioverleih.server(player)
	if(not(isPedInVehicle(player)))then
		if(getElementData(player,"loggedin") == 1)then
			if(isElementWithinMarker(player,Faggioverleih.marker))then
				if(isElement(Faggioverleih.vehicles[player]))then destroyElement(Faggioverleih.vehicles[player])end
				Faggioverleih.vehicles[player] = createVehicle(462,1457.1999511719,-1743.3000488281,13.199999809265,0,0,0,getPlayerName(player))
				warpPedIntoVehicle(player,Faggioverleih.vehicles[player])
			end
		end
	end
end