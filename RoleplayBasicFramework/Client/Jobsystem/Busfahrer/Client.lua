Busfahrer = {points = 0,
	["Marker"] = { -- x,y,z
		{1161.6097412109,-1743.0363769531,12.808093070984},
		{1268.8304443359,-1854.3566894531,12.792505264282},
		{1315.1420898438,-1701.1866455078,12.792501449585},
		{1360.4152832031,-1421.8740234375,12.792499542236},
		{1193.0216064453,-1420.0148925781,12.635266304016},
		{1147.4080810547,-1588.3051757813,12.848868370056},
		{1113.7138671875,-1737.7913818359,12.930160522461},},
	}
	
function Busfahrer.createMarker(type)
	if(isElement(Busfahrer.marker))then destroyElement(Busfahrer.marker)end
	if(isElement(Busfahrer.blip))then destroyElement(Busfahrer.blip)end
	
	if(type)then
		Busfahrer.points = Busfahrer.points + 1
		Busfahrer.marker = createMarker(Busfahrer["Marker"][Busfahrer.points][1],Busfahrer["Marker"][Busfahrer.points][2],Busfahrer["Marker"][Busfahrer.points][3],"checkpoint",2,255,0,0)
		Busfahrer.blip = createBlip(Busfahrer["Marker"][Busfahrer.points][1],Busfahrer["Marker"][Busfahrer.points][2],Busfahrer["Marker"][Busfahrer.points][3],0,2,255,0,0)
		
		addEventHandler("onClientMarkerHit",Busfahrer.marker,function(player)
			if(player == localPlayer)then
				if(tonumber(Busfahrer.points) == 7)then
					Busfahrer.createMarker()
					triggerServerEvent("Busfahrer.stop",localPlayer)
				else
					setElementFrozen(getPedOccupiedVehicle(localPlayer),true)
					Busfahrer.timer = setTimer(function()
						setElementFrozen(getPedOccupiedVehicle(localPlayer),false)
						triggerServerEvent("Busfahrer.passanten",localPlayer)
					end,5000,1)
					Busfahrer.createMarker("create")
				end
			end
		end)
	end
end
addEvent("Busfahrer.createMarker",true)
addEventHandler("Busfahrer.createMarker",root,Busfahrer.createMarker)

addEvent("Busfahrer.reset",true)
addEventHandler("Busfahrer.reset",root,function()
	Busfahrer.points = 0
	if(isTimer(Busfahrer.timer))then
		killTimer(Busfahrer.timer)
	end
end)