Supermarkt = {
	["Hamburger"] = 50,
	["Benzinkanister"] = 100,
}

addEvent("Supermarkt.buy",true)
addEventHandler("Supermarkt.buy",root,function(item)
	local preis = tonumber(Supermarkt[item])
	if(tonumber(getElementData(client,"Geld")) >= preis)then
		setElementData(client,item,getElementData(client,item)+1)
		infobox(client,"Du hast dir einen "..item.." gekauft.",0,255,0)
		setElementData(client,"Geld",getElementData(client,"Geld")-preis)
	else infobox(client,"Du hast nicht genug Geld bei dir!",255,0,0)end
end)