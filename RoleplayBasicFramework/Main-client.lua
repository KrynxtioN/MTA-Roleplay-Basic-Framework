GUIEditor = {button = {},window = {},edit = {},label = {},gridlist = {},radiobutton = {}}
x,y = guiGetScreenSize()
local KinobalkenState = false
setElementData(localPlayer,"elementClicked",false)
local WindowPoints = 0

function formString(var)
	if(string.len(var) == 1)then
		var = "0"..var
	end
	return var
end

function Kinobalken()
	if(KinobalkenState == false)then
		KinobalkenState = true
	else
		KinobalkenState = false
		KinobalkenTimer = setTimer(function()
			removeEventHandler("onClientRender",root,KinobalkenRender)
			setElementData(localPlayer,"elementClicked",false)
		end,750,1)
	end
end

function KinobalkenRender()
	if(KinobalkenState == true)then
		if(WindowPoints < 35)then
			WindowPoints = WindowPoints + 1
		end
	elseif(KinobalkenState == false)then
		if(WindowPoints > 0)then
			WindowPoints = WindowPoints - 1
		end
	end
	
	dxDrawRectangle(0*(x/1440), 0*(y/900), 1440*(x/1440), WindowPoints*(y/900), tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(0*(x/1440), 900*(y/900), 1440*(x/1440), - WindowPoints*(y/900), tocolor(0, 0, 0, 255), false)
end

function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

function isWindowOpen()
	if(isElement(GUIEditor.window[1]) or getElementData(localPlayer,"elementClicked") == true)then
		return false
	else
		return true
	end
end

function setWindowDatas(type,labelid,cursor)
	if(type == "set")then
		setPlayerHudComponentVisible("radar",false)
		setPlayerHudComponentVisible("area_name",false)
		showChat(false)
		if(not(cursor))then
			showCursor(true)
		end
		if(getElementData(localPlayer,"elementClicked") ~= true)then
			addEventHandler("onClientRender",root,KinobalkenRender)
			Kinobalken()
		end
		setElementData(localPlayer,"elementClicked",true)
		if(isElement(GUIEditor.window[1]))then
			guiWindowSetMovable(GUIEditor.window[1], false)
			guiWindowSetSizable(GUIEditor.window[1], false)
			centerWindow(GUIEditor.window[1])
			
			if(labelid)then
				for i = 1,labelid do
					guiSetFont(GUIEditor.label[i], "default-bold-small")
					guiLabelSetHorizontalAlign(GUIEditor.label[i], "center", true)
					guiLabelSetVerticalAlign(GUIEditor.label[i], "center")
				end
			end
			
			if(isElement(GUIEditor.button["Close"]))then
				addEventHandler("onClientGUIClick",GUIEditor.button["Close"],function()
					Fahrschule.points = 0
					if(getElementData(localPlayer,"entfreezeAfterClose") == true)then
						setElementFrozen(getPedOccupiedVehicle(localPlayer),false)
						setElementData(localPlayer,"entfreezeAfterClose",false)
					end
					setWindowDatas("reset")
				end,false)
			end
		end
	else
		setPlayerHudComponentVisible("radar",true)
		setPlayerHudComponentVisible("area_name",true)
		showChat(true)
		showCursor(false)
		if(isElement(GUIEditor.window[1]))then
			destroyElement(GUIEditor.window[1])
		end
		Kinobalken()
	end
end
addEvent("setWindowDatas",true)
addEventHandler("setWindowDatas",root,setWindowDatas)

bindKey("b","down",function()
    showCursor(not(isCursorShowing()))
end)