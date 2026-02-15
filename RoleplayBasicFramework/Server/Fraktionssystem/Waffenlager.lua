Waffenlager = { -- x,y,z, Interior, Dimension, Frakion
	{227.14097595215,73.957321166992,1005.0390625,6,0,1},
	{-2166.1652832031,646.33520507813,1052.375,1,0,2},
	{511.60800170898,-80.296241760254,998.9609375,11,0,3},
}
	
for _,v in pairs(Waffenlager)do
	local pickup = createPickup(v[1],v[2],v[3],3,1239,50)
	setElementInterior(pickup,v[4])
	setElementDimension(pickup,v[5])
	
	addEventHandler("onPickupHit",pickup,function(player)
		if(getElementData(player,"Fraktion") == v[6])then
			local einheiten = getDatabaseData("fraktionskasse","ID",getElementData(player,"Fraktion"),"Waffenlager")
			triggerClientEvent(player,"Waffenlager.window",player,einheiten)
		end
	end)
end

addEvent("Waffenlager.use",true)
addEventHandler("Waffenlager.use",root,function()
	local einheiten = getDatabaseData("fraktionskasse","ID",getElementData(client,"Fraktion"),"Waffenlager")
	if(einheiten >= 1)then
		dbExec(handler,"UPDATE fraktionskasse SET Waffenlager = '"..einheiten-1 .."' WHERE ID = '"..getElementData(client,"Fraktion").."'")
		infobox(client,"Du hast dich ausgerüstet!",0,255,0)
		giveWeapon(client,24,300,true)
		giveWeapon(client,29,1000,true)
		giveWeapon(client,31,1000,true)
		triggerClientEvent(client,"setWindowDatas",client,"reset")
	else infobox(client,"Im Lager sind nicht mehr genug Einheiten!",255,0,0)end
end)