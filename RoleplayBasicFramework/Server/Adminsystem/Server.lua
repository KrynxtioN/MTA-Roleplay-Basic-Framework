Adminsystem = {}

addCommandHandler("o",function(player,cmd,...)
	if(getElementData(player,"Adminlevel") >= 1)then
		local msg = {...}
		local text = table.concat(msg," ")
		if(#text >= 1)then
			outputChatBox(getPlayerName(player)..": "..text,root,255,255,255)
		end
	end
end)

addCommandHandler("a",function(player,cmd,...)
	if(getElementData(player,"Adminlevel") >= 1)then
		local msg = {...}
		local text = table.concat(msg," ")
		
		if(#text >= 1)then
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"Adminlevel") >= 1)then
					outputChatBox(getPlayerName(player)..": "..text,v,200,200,0)
				end
			end
		end
	end
end)

addEvent("Adminsystem.kicken",true)
addEventHandler("Adminsystem.kicken",root,function(target,grund)
	local target = getPlayerFromName(target)
	if(isElement(target) and getElementData(target,"loggedin") == 1)then
		outputChatBox(getPlayerName(target).." wurde gekickt! Grund: "..grund,root,125,0,0)
		kickPlayer(target,client,grund)
	else infobox(client,"Der Spieler ist nicht eingeloggt oder nicht auf dem Server!",255,0,0)end
end)

addEvent("Adminsystem.bannen",true)
addEventHandler("Adminsystem.bannen",root,function(target,grund)
	local target = getPlayerFromName(target)
	if(isElement(target) and getElementData(target,"loggedin") == 1)then
		outputChatBox(getPlayerName(target).." wurde gebannt! Grund: "..grund,root,125,0,0)
		dbExec(handler,"INSERT INTO bans (Name,Grund) VALUES ('"..getPlayerName(target).."','"..grund.."')")
		kickPlayer(target,client,grund)
	else infobox(client,"Der Spieler ist nicht eingeloggt oder nicht auf dem Server!",255,0,0)end
end)

addEvent("Adminsystem.leader",true)
addEventHandler("Adminsystem.leader",root,function(target,id)
	local id = tonumber(id)
	local target = getPlayerFromName(target)
	if(isElement(target) and getElementData(target,"loggedin") == 1)then
		setElementData(target,"Fraktion",id)
		setElementData(target,"Fraktionsrang",5)
		infobox(target,"Du wurdest zum Leader von Fraktion "..id.." ernannt.",0,255,0)
		infobox(client,"Du hast "..getPlayerName(target).." zum Leader von Fraktion "..id.." ernannt.",0,255,0)
		dbExec(handler,"UPDATE userdata SET Fraktion = '"..getElementData(target,"Fraktion").."' WHERE Name = '"..getPlayerName(target).."'")
	else infobox(client,"Der Spieler ist nicht eingeloggt oder nicht auf dem Server!",255,0,0)end
end)

addCommandHandler("respawn",function(player,cmd,id)
	local factionID = 0
	if(getElementData(player,"Adminlevel") >= 1)then
		if(id)then
			factionID = id
		else infobox(player,"Du hast keine Fraktion mit angegeben!",255,0,0)end
	else
		if(getElementData(player,"Fraktionsrang") >= 4)then
			factionID = getElementData(player,"Fraktion")
		end
	end
	if(factionID ~= 0)then
		infobox(player,"Die Fahrzeuge wurden respawnt!",0,255,0)
		for _,v in pairs(getElementsByType("vehicle"))do
			if(getElementData(v,"Fraktion") == tonumber(factionID))then
				if(not(getVehicleOccupant(v)))then
					respawnVehicle(v)
				end
			end
		end
	end
end)