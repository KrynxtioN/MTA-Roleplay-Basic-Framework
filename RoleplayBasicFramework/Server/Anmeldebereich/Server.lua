Anmeldebereich = {payday = {},
	["Daten"] = {"Fraktion","Fraktionsrang","Adminlevel","Geld","Kills","Tode","Bankgeld","Autoschein","Motorradschein","Lkwschein","Flugschein","Skin","Housekey","Hamburger","Weed","Benzinkanister","Spielstunden","Job"},}

addEvent("Anmeldebereich.checkAccount",true)
addEventHandler("Anmeldebereich.checkAccount",root,function()
	local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Name = '"..getPlayerName(client).."'"),-1)
	if(#result >= 1)then
		triggerClientEvent(client,"Anmeldebereich.create",client,"Einloggen")
	else
		triggerClientEvent(client,"Anmeldebereich.create",client,"Registrieren")
	end
end)

addEvent("Anmeldebereich.server",true)
addEventHandler("Anmeldebereich.server",root,function(password,type)
	local password = md5(password)
	if(type == "Einloggen")then
		local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Name = '"..getPlayerName(client).."' AND Passwort = '"..password.."'"),-1)
		if(#result >= 1)then
			local result = dbPoll(dbQuery(handler,"SELECT * FROM bans WHERE Name = '"..getPlayerName(client).."'"),-1)
			if(#result == 0)then
				infobox(client,"Herzlich Willkommen zurück, "..getPlayerName(client).."!",0,255,0)
				setDatasAfterLogin(client)
			else infobox(client,"Du wurdest permanent gebannt! Grund: "..getDatabaseData("bans","Name",getPlayerName(client),"Grund"),255,0,0)end
		else infobox(client,"Die angegebene Username/Passwort Kombination existiert nicht!",255,0,0)end
	else
		local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Serial = '"..getPlayerSerial(client).."'"),-1)
		if(#result == 0)then
			infobox(client,"Du hast dich erfolgreich registriert!",0,255,0)
			dbExec(handler,"INSERT INTO userdata (Name,Passwort,Serial) VALUES ('"..getPlayerName(client).."','"..password.."','"..getPlayerSerial(client).."')")
			setDatasAfterLogin(client)
		else infobox(client,"Du hast bereits einen Account bei uns! ("..getDatabaseData("userdata","Serial",getPlayerSerial(client),"Name")..")",255,0,0)end
	end
end)

function setDatasAfterLogin(player)
	setCameraTarget(player)
	triggerClientEvent(player,"setWindowDatas",player,"reset")
	createPrivateVehicles(player)
	bindKey(player,"f3","down",Fraktionssystem.open)
	bindKey(player,"f4","down",Fahrzeugsystem.openVerwaltung)
	bindKey(player,"g","down",Fahrzeugsystem.handbremse)
	bindKey(player,"x","down",Fahrzeugsystem.motor)
	bindKey(player,"l","down",Fahrzeugsystem.licht)
	bindKey(player,"f5","down",Haussystem.menu)
	setElementData(player,"loggedin",1)
	Anmeldebereich.spawnPlayer(player)
	
	for _,v in pairs(Anmeldebereich["Daten"])do
		setElementData(player,v,getDatabaseData("userdata","Name",getPlayerName(player),v))
	end
	
	Anmeldebereich.payday[player] = setTimer(function(player)
		setElementData(player,"Spielstunden",getElementData(player,"Spielstunden")+1)
		if(math.floor(getElementData(player,"Spielstunden")/60) == (getElementData(player,"Spielstunden")/60))then
			local fraktionsmoney = 0
			if(getElementData(player,"Fraktion") >= 1)then
				fraktionsmoney = getElementData(player,"Fraktionsrang")+1*250
			end
			outputChatBox("_____| Payday |_____",player,0,255,0)
			outputChatBox("Fraktionsgehalt: "..fraktionsmoney.."$",player,0,200,0)
			outputChatBox("Das Geld wurde auf dein Konto überwiesen.",player,200,200,0)
			savePlayerDatas(player)
		end
	end,60000,0,player)
end

function Anmeldebereich.spawnPlayer(player)
	local x,y,z,rotation = getDatabaseData("userdata","Name",getPlayerName(player),"Posx"),getDatabaseData("userdata","Name",getPlayerName(player),"Posy"),getDatabaseData("userdata","Name",getPlayerName(player),"Posz"),getDatabaseData("userdata","Name",getPlayerName(player),"Rotz")
	local interior,dimension = getDatabaseData("userdata","Name",getPlayerName(player),"Interior"),getDatabaseData("userdata","Name",getPlayerName(player),"Dimension")
	spawnPlayer(player,x,y,z,rotation,_,interior,dimension)
	if(getDatabaseData("userdata","Name",getPlayerName(player),"Housespawn") == 1)then
		setElementData(player,"spawnImHaus",true)
	end
	setCameraTarget(player)
end

function savePlayerDatas(player)
	if(getElementData(player,"loggedin") == 1)then
		for _,v in pairs(Anmeldebereich["Daten"])do
			dbExec(handler,"UPDATE userdata SET "..v.." = '"..getElementData(player,v).."' WHERE Name = '"..getPlayerName(player).."'")
		end
	end
	if(isTimer(Anmeldebereich.payday[player]))then killTimer(Anmeldebereich.payday[player])end
end
addEventHandler("onPlayerQuit",root,savePlayerDatas)