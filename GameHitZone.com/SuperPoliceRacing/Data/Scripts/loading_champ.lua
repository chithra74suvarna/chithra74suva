local script = globalObject;

local interface;
local commandMap = {};

local function ExecuteCommands()
	while(SetNextCommand(script))
	do
		local command = GetCurrentCommand(script);
		if (commandMap[command])
		then
			commandMap[command]();
		end
	end
end



local function AddObject()
	local obj = GetCurrentParams(script);
	interface = StringToPointer(obj);
--	SetTextString(interface, "road1", ""); 
	SetTextString(interface, "road1_red", ""); 
--	SetTextString(interface, "road2", ""); 
	SetTextString(interface, "road2_red", "");  
--	SetTextString(interface, "road3", ""); 
	SetTextString(interface, "road3_red", "");  
--	SetTextString(interface, "road4", ""); 
	SetTextString(interface, "road4_red", "");  
--	SetTextString(interface, "road5", ""); 
	SetTextString(interface, "road5_red", ""); 
--	SetTextString(interface, "road6", ""); 
	SetTextString(interface, "road6_red", ""); 
	SetTextString(interface, "road7_red", ""); 
	SetTextString(interface, "road8_red", ""); 
	SetTextString(interface, "road9_red", ""); 
	SetTextString(interface, "road10_red", ""); 
	
	local num = GetCurrentMission();
	local num2 = num;


	SetTextString(interface, "text", "win"..num);
	UpdateInterfaceBuffers(interface);

	
	
	SetTextString(interface, "road"..num2.."_red", "road"..num); 
--~ 	if (num == 1)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "market")
--~ 	elseif (num == 2)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "airplane");
--~ 	elseif (num == 3)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "electro");
--~ 	elseif (num == 4)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "olga");
--~ 	elseif (num == 5)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "vampires");
--~ 	elseif (num == 6)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel");
--~ 	elseif (num == 7)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel2");
--~ 	elseif (num == 8)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel3");
--~ 	elseif (num == 9)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel4");
--~ 	elseif (num == 10)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel5");
--~ 	elseif (num == 11)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel6");
--~ 	elseif (num == 12)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel7");
--~ 	elseif (num == 13)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel8");
--~ 	elseif (num == 14)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel9");
--~ 	elseif (num == 15)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel10");
--~ 	elseif (num == 16)
--~ 	then
--~ 		SendCommandByName("main", "road_picture", "funnel11");
--~ 	end

	UpdateInterfaceBuffers(interface);
	
end

local function DeleteObject()
	Release(interface);
	StopScript(script);
	interface = nil;
end

local function ReleaseAll()
	Release(interface);
	interface = nil;
end

local function UpdateGameInterface1()
	UpdateGameInterface(interface);
end

commandMap["release_all"] = ReleaseAll;
commandMap["add_object"] = AddObject;
commandMap["delete_object"] = DeleteObject;


while(true)
do
	ExecuteCommands();
	UpdateInterface(interface);

	Update();
end
