Reporter = {}

addCommandHandler("news",function(player,cmd,...)
	if(isPedInVehicle(player))then
		if(getElementData(player,"Fraktion") == 4)then
			local veh = getPedOccupiedVehicle(player)
			if(getElementData(veh,"Fraktion") == 4)then
				local msg = {...}
				local text = table.concat(msg," ")
				if(#text >= 1)then
					outputChatBox("Reporter "..getPlayerName(player)..": "..text,root,250,150,0)
				end
			end
		end
	end
end)