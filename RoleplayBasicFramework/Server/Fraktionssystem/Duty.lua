Duty = {}
Duty.pickup = createPickup(257.02114868164,70.427200317383,1003.640625,3,1239,50)
setElementInterior(Duty.pickup,6)

addEventHandler("onPickupHit",Duty.pickup,function(player)
	if(getElementData(player,"Fraktion") == 1)then
		triggerClientEvent(player,"Duty.window",player)
	end
end)

addEvent("Duty.server",true)
addEventHandler("Duty.server",root,function()
	if(getElementData(client,"Fraktion") == 1)then
		if(getDistanceBetweenPoints3D(257.02114868164,70.427200317383,1003.640625,getElementPosition(client)) <= 5)then
			if(getElementData(client,"duty") == true)then
				infobox(client,"Du hast den Dienst verlassen.",255,0,0)
				setElementModel(client,getElementData(client,"Skin"))
				takeAllWeapons(client)
				setElementData(client,"duty",false)
			else
				infobox(client,"Du hast den Dienst betreten.",0,255,0)
				giveWeapon(client,24,99,true)
				setPedArmor(client,100)
				setElementHealth(client,100)
				setElementModel(client,265)
				setElementData(client,"duty",true)
			end
			triggerClientEvent(client,"setWindowDatas",client,"reset")
		end
	end
end)