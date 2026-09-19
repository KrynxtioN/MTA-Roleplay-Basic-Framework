Scoreboard = {state = false, scroll = 0}

bindKey("tab","down",function()
	if(isWindowOpen())then
		Scoreboard.update()
		setWindowDatas("set",_,true)
		Scoreboard.state = true
		addEventHandler("onClientRender",root,ScoreboardRender)
		bindKey("mouse_wheel_down","down",Scoreboard.scrollDown)
		bindKey("mouse_wheel_up","down",Scoreboard.scrollUp)
		Scoreboard.timer = setTimer(Scoreboard.update,10000,1)
	end
end)

bindKey("tab","up",function()
	if(Scoreboard.state == true)then
		setWindowDatas("reset")
		Scoreboard.state = false
		unbindKey("mouse_wheel_down","down",Scoreboard.scrollDown)
		unbindKey("mouse_wheel_up","down",Scoreboard.scrollUp)
		removeEventHandler("onClientRender",root,ScoreboardRender)
		if(isTimer(Scoreboard.timer))then killTimer(Scoreboard.timer)end
	end
end)

function ScoreboardRender()
    dxDrawRectangle(432*(x/1440), 286*(y/900), 577*(x/1440), 327*(y/900), tocolor(0, 0, 0, 175), false)
    dxDrawLine(432*(x/1440), 325*(y/900), 1009*(x/1440), 325*(y/900), tocolor(255, 255, 255, 255), 1, false)
    dxDrawText("Spielername", 431*(x/1440), 286*(y/900), 642*(x/1440), 325*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Spielstunden", 652*(x/1440), 286*(y/900), 776*(x/1440), 325*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Fraktion", 786*(x/1440), 286*(y/900), 910*(x/1440), 325*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Ping", 920*(x/1440), 286*(y/900), 1009*(x/1440), 325*(y/900), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(647*(x/1440), 286*(y/900), 647*(x/1440), 613*(y/900), tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(780*(x/1440), 286*(y/900), 780*(x/1440), 613*(y/900), tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(915*(x/1440), 286*(y/900), 915*(x/1440), 613*(y/900), tocolor(255, 255, 255, 255), 1, false)
	
	di = 0
	for i = 1 + Scoreboard.scroll,12 + Scoreboard.scroll do
		if(pl[i])then
			dxDrawText(pl[i].name, 432*(x/1440), 335*(y/900)+(35*di)+13, 643*(x/1440), 374*(y/900), tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].spielstunden, 652*(x/1440), 335*(y/900)+(35*di)+13, 776*(x/1440), 374*(y/900), tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].fraktion, 786*(x/1440), 335*(y/900)+(35*di)+13, 910*(x/1440), 374*(y/900), tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].ping, 920*(x/1440), 335*(y/900)+(35*di)+13, 1009*(x/1440), 374*(y/900), tocolor(pl[i].colors[1],pl[i].colors[2],pl[i].colors[3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		
			di = di + 1
		end
	end
end

function Scoreboard.scrollUp()
	if(Scoreboard.scroll <= 2)then
		Scoreboard.scroll = 0
	else
		Scoreboard.scroll = Scoreboard.scroll - 2
	end
end

function Scoreboard.scrollDown()
	if(#getElementsByType("player") - Scoreboard.scroll <= 2)then
		Scoreboard.scroll = #getElementsByType("player")
	else
		Scoreboard.scroll = Scoreboard.scroll + 2
	end
end

function Scoreboard.update()
	pl = {}
	local i = 1
	
	for _,v in pairs(getElementsByType("player"))do
		name = getPlayerName(v)
		if(getElementData(v,"Adminlevel") >= 1)then
			name = "[SG]"..getPlayerName(v)
		end
		ping = getPlayerPing(v)
		fraktion = getElementData(v,"Fraktion")
		r,g,b = Fraktionssystem["Fraktioncolors"][fraktion][1],Fraktionssystem["Fraktioncolors"][fraktion][2],Fraktionssystem["Fraktioncolors"][fraktion][3]
		spielstunden = getElementData(v,"Spielstunden")
		hour = math.floor(spielstunden/60)
		minute = spielstunden-hour*60
		spielstunden = formString(hour)..":"..formString(minute)
		pl[i] = {}
		pl[i].name = name
		pl[i].ping = ping
		pl[i].fraktion = Fraktionssystem["Fraktionsnamen"][fraktion]
		pl[i].colors = {r,g,b}
		pl[i].spielstunden = spielstunden
		i = i + 1
	end
end