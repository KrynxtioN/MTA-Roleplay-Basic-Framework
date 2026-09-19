Gates = {
	["Models"] = {
		[2938] = true,
		[968] = true},
	["Objekte"] = { -- model,x,y,z,rx,ry,rz,fraktion,typ
		{2938,1590.4000244141,-1638.3000488281,13.89999961853,0,0,90,1,"Gate"}, -- LSPD Haupttor
		{968,1544.6999511719,-1630.9000244141,13.10000038147,0,90,90,1,"Barriere"}, -- LSPD Barriere
	},
}

for _,v in pairs(Gates["Objekte"])do
	local gate = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
	setElementData(gate,"Fraktion",v[8])
	setElementData(gate,"Status","close")
	setElementData(gate,"Type",v[9])
end

addCommandHandler("gate",function(player)
	for _,v in pairs(getElementsByType("object"))do
		if(Gates["Models"][getElementModel(v)])then
			if(getElementData(player,"Fraktion") == getElementData(v,"Fraktion"))then
				local x,y,z = getElementPosition(v)
				if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player)) <= 15)then
					if(getElementData(v,"Type") == "Gate")then
						if(getElementData(v,"Status") == "close")then
							setElementData(v,"Status","open")
							moveObject(v,5000,x,y,z-5)
						else
							setElementData(v,"Status","close")
							moveObject(v,5000,x,y,z+5)
						end
					elseif(getElementData(v,"Type") == "Barriere")then
						if(getElementData(v,"Status") == "close")then
							setElementData(v,"Status","open")
							moveObject(v,5000,x,y,z,0,-90,0)
						else
							setElementData(v,"Status","close")
							moveObject(v,5000,x,y,z,0,90,0)
						end
					end
				end
				break
			end
		end
	end
end)