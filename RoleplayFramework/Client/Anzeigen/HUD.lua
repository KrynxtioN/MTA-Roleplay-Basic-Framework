local HUDDatas = {"ammo","armour","breath","clock","health","money","weapon","wanted"}

function HUDRender()
	if(getElementData(localPlayer,"loggedin") == 1)then
		if(isWindowOpen())then
			local px,py,pz = getElementPosition(localPlayer)
			local zone = getZoneName(px,py,pz)
			
			local time = getRealTime()
			local hour = time.hour
			local minute = time.minute
		 
			dxDrawRectangle(1217*(x/1440), 10*(y/900), 213*(x/1440), 12*(y/900), tocolor(209, 0, 0, 255), false)
			dxDrawRectangle(1217*(x/1440), 22*(y/900), 213*(x/1440), 12*(y/900), tocolor(254, 21, 27, 255), false)
			dxDrawImage(1113*(x/1440), 10*(y/900), 94*(x/1440), 77*(y/900), "Files/Waffenicons/"..tostring(getPedWeapon(localPlayer))..".png",0,0,0, tocolor(255, 255, 255, 255), false)
			dxDrawRectangle(1217*(x/1440), 56*(y/900), 213*(x/1440), 12*(y/900), tocolor(71, 71, 71, 255), false)
			dxDrawRectangle(1217*(x/1440), 44*(y/900), 213*(x/1440), 12*(y/900), tocolor(56, 56, 56, 255), false)
			dxDrawText(getPedAmmoInClip(localPlayer).." | "..getPedTotalAmmo(localPlayer) - getPedAmmoInClip(localPlayer), 1113*(x/1440), 97*(y/900), 1207*(x/1440), 126*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(zone..", "..hour..":"..minute.." Uhr", 1217*(x/1440), 78*(y/900), 1430*(x/1440), 97*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(getElementData(localPlayer,"Geld").."$", 1217*(x/1440), 107*(y/900), 1430*(x/1440), 126*(y/900), tocolor(0, 255, 0, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(math.floor(getElementHealth(localPlayer)).."%", 1217*(x/1440), 10*(y/900), 1430*(x/1440), 32*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(math.floor(getPedArmor(localPlayer)).."%", 1217*(x/1440), 44*(y/900), 1430*(x/1440), 66*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		end
	end
end
addEventHandler("onClientRender",root,HUDRender)

for _,v in pairs(HUDDatas)do
	setPlayerHudComponentVisible(v,false)
end