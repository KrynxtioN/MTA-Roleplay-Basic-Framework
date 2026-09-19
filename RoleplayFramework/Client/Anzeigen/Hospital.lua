Hospital = {}

function Hospital.render()
    dxDrawText(Hospital.sek, 537*(x/1440), 10*(y/900), 904*(x/1440), 90*(y/900), tocolor(255, 255, 255, 255), 2.50, "default-bold", "center", "center", false, false, false, false, false)
end

addEvent("Hospital.create",true)
addEventHandler("Hospital.create",root,function()
	Hospital.sek = 5
	addEventHandler("onClientRender",root,Hospital.render)
	setWindowDatas("set",_,"no")
	setElementInterior(localPlayer,0)
	setElementDimension(localPlayer,0)
	setCameraMatrix(1217.0627441406,-1362.8322753906,38.825199127197,1216.3743896484,-1362.2628173828,38.375846862793)
	setTimer(function()
		Hospital.sek = Hospital.sek - 1
		if(Hospital.sek == 0)then
			setWindowDatas("reset")
			removeEventHandler("onClientRender",root,Hospital.render)
			triggerServerEvent("respawnPlayer",localPlayer)
		end
	end,1000,Hospital.sek)
end)