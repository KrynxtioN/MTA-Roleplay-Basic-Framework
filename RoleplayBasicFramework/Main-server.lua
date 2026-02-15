setFPSLimit(65)
Servername = "Selfmade Grundgerüst"
setGameType(Servername)

setTime(getRealTime().hour,getRealTime().minute)
setMinuteDuration(60000)

handler = dbConnect("mysql","dbname=selfmadehost=localhost","root","")

if(handler)then
	outputDebugString("Datenbankverbindung konnte hergestellt werden.")
else
	outputDebugString("Datenbankverbindung konnte nicht hergestellt werden.")
end

function getDatabaseData(from,where,name,data)
	local result = dbQuery(handler,"SELECT * FROM "..from.." WHERE "..where.." = '"..name.."'")
	if(result)then
		local rows = dbPoll(result,-1)
		for _,v in pairs(rows)do
			return v[data]
		end
	end
end

function infobox(player,text,r,g,b)
	triggerClientEvent(player,"infobox",player,text,r,g,b)
end

addEventHandler("onPlayerClick",root,function(button,state,clickedElement)
	if(button == "left" and state == "down")then
		if(getElementData(source,"elementClicked") ~= true)then
			if(clickedElement)then
				local ox,oy,oz = getElementPosition(clickedElement)
				local model = getElementModel(clickedElement)
				if(getDistanceBetweenPoints3D(ox,oy,oz,getElementPosition(source)) <= 5)then
					if(model == 2942)then
						triggerClientEvent(source,"Bank.open",source)
					end
				end
			end
		end
	end
end)

addEventHandler("onPlayerChangeNick",root,function()
	cancelEvent()
end)

addEventHandler("onPlayerWasted",root,function()
	triggerClientEvent(source,"setWindowDatas",source,"reset")
	triggerClientEvent(source,"Hospital.create",source)
end)

addEvent("respawnPlayer",true)
addEventHandler("respawnPlayer",root,function()
	Anmeldebereich.spawnPlayer(client)
end)