local Peds = { -- model,x,y,z,rot,int,dim
	{240,1466.2001953125,-1741.7001953125,13.5,0,0,0},
	{283,251.19999694824,67.699996948242,1003.5999755859,90,6,0},
	{141,359.79998779297,173.60000610352,1008.4000244141,270,3,0},
	{127,2323.6999511719,76.5,26.5,180,0,0}, -- Waffentransporter
	{102,1709.5999755859,701.40002441406,10.800000190735,90,0,0}, -- Drogentransporter
	{23,-23.515432357788,-57.318744659424,1003.546875,0,6,1}, -- Supermarkt
	{258,295.64605712891,-82.541351318359,1001.515625,0,4,1}, -- Ammunation
	{258,295.64605712891,-82.541351318359,1001.515625,0,4,2}, -- Ammunation
	{184,-2034.7686767578,-118.18064880371,1035.171875,270,3,0}, -- Fahrschule
}
	
for _,v in pairs(Peds)do
	local ped = createPed(v[1],v[2],v[3],v[4],v[5])
	setElementInterior(ped,v[6])
	setElementDimension(ped,v[7])
	setElementFrozen(ped,true)
	
	addEventHandler("onClientPedDamage",ped,function()
		cancelEvent()
	end)
end