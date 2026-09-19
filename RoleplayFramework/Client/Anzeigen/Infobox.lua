local infoboxState = false
local infoboxKoordinaten = {
	[1] = {544*(x/1440), 11*(y/900), 359*(x/1440), 141*(y/900),554*(x/1440), 21*(y/900), 893*(x/1440), 142*(y/900)}, -- kein Fenster geöffnet
	[2] = {544*(x/1440), 11+30*(y/900), 359*(x/1440), 141*(y/900),554*(x/1440), 21+60*(y/900), 893*(x/1440), 142*(y/900)}, -- ein Fenster geöffnet
}

function infobox(text,r,g,b)
	infoboxText = text
	infoboxR = r
	infoboxG = g
	infoboxB = b
	
	if(infoboxState == false)then
		infoboxState = true
		addEventHandler("onClientRender",root,infoboxRender)
		setTimer(function()
			infoboxState = false
			removeEventHandler("onClientRender",root,infoboxRender)
		end,6000,1)
	end
end
addEvent("infobox",true)
addEventHandler("infobox",root,infobox)

function infoboxRender()
	if(isWindowOpen())then state = 1 else state = 2 end
    dxDrawRectangle(infoboxKoordinaten[state][1],infoboxKoordinaten[state][2],infoboxKoordinaten[state][3],infoboxKoordinaten[state][4], tocolor(17, 17, 17, 200), false)
    dxDrawText(infoboxText, infoboxKoordinaten[state][5],infoboxKoordinaten[state][6],infoboxKoordinaten[state][7],infoboxKoordinaten[state][8], tocolor(infoboxR,infoboxG,infoboxB, 255), 1.20, "default-bold", "center", "center", false, true, false, false, false)
end