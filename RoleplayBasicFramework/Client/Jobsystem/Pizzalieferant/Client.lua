Pizzalieferant = {lastMarker = nil,
	["Marker"] = { -- x,y,z
		{2103.822265625,-1777.7502441406,13.390562057495},
		{2114.0114746094,-1772.6494140625,13.39305305481},},
	}
	
function Pizzalieferant.createMarker(type)
	if(isElement(Pizzalieferant.marker))then destroyElement(Pizzalieferant.marker)end
	if(isElement(Pizzalieferant.blip))then destroyElement(Pizzalieferant.blip)end
	
	if(type)then
		local id = math.random(1,#Pizzalieferant["Marker"])
	
		if(not(id == Pizzalieferant.lastMarker))then
			Pizzalieferant.lastMarker = id
			Pizzalieferant.marker = createMarker(Pizzalieferant["Marker"][id][1],Pizzalieferant["Marker"][id][2],Pizzalieferant["Marker"][id][3],"checkpoint",2,255,0,0)
			Pizzalieferant.blip = createBlip(Pizzalieferant["Marker"][id][1],Pizzalieferant["Marker"][id][2],Pizzalieferant["Marker"][id][3],0,2,255,0,0)
			
			addEventHandler("onClientMarkerHit",Pizzalieferant.marker,function(player)
				if(player == localPlayer)then
					Pizzalieferant.createMarker("create")
					triggerServerEvent("Pizzalieferant.abgeben",localPlayer)
				end
			end)
		else Pizzalieferant.createMarker("create")end
	end
end
addEvent("Pizzalieferant.createMarker",true)
addEventHandler("Pizzalieferant.createMarker",root,Pizzalieferant.createMarker)

addEvent("Pizzalieferant.reset",true)
addEventHandler("Pizzalieferant.reset",root,function()
	Pizzalieferant.lastMarker = nil
end)