Ammunation = {
	["Desert Eagle"] = {24,50,250},
	["Mp5"] = {29,100,1000},
	["M4"] = {31,200,1500},
	["Rifle"] = {33,25,1250},
}

addEvent("Ammunation.buy",true)
addEventHandler("Ammunation.buy",root,function(waffe)
	local preis = tonumber(Ammunation[waffe][3])
	if(tonumber(getElementData(client,"Geld")) >= preis)then
		setElementData(client,"Geld",getElementData(client,"Geld")-preis)
		infobox(client,"Du hast dir eine "..waffe.." mit "..Ammunation[waffe][2].." Schuss gekauft.",0,255,0)
		giveWeapon(client,Ammunation[waffe][1],Ammunation[waffe][2],true)
	else infobox(client,"Du hast nicht genug Geld bei dir!",255,0,0)end
end)