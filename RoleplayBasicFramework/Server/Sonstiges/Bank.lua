addEvent("Bank.server",true)
addEventHandler("Bank.server",root,function(type,summe)
	local summe = tonumber(summe)
	if(type == "einzahlen")then
		if(tonumber(getElementData(client,"Geld")) >= summe)then
			setElementData(client,"Geld",getElementData(client,"Geld")-summe)
			setElementData(client,"Bankgeld",getElementData(client,"Bankgeld")+summe)
			infobox(client,"Du hast "..summe.."$ eingezahlt.",0,255,0)
		else infobox(client,"Du hast nicht genug Geld bei dir!",255,0,0)end
	else
		if(getElementData(client,"Bankgeld") >= summe)then
			setElementData(client,"Geld",getElementData(client,"Geld")+summe)
			setElementData(client,"Bankgeld",getElementData(client,"Bankgeld")-summe)
			infobox(client,"Du hast "..summe.."$ ausgezahlt.",0,255,0)
		else infobox(client,"Du hast nicht genug Geld auf deinem Konto!",255,0,0)end
	end
	triggerClientEvent(client,"Bank.refresh",client)
end)