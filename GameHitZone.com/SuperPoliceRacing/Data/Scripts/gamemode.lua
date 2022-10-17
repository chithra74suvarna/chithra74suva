local script = globalObject;

local interface;
local commandMap = {};

local delay = 0;

local strBack = "char";

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


local function Button()
	PlaySpecialSound("button_click");
	local name = GetCurrentParams(script);
	if (name == "back")
	then
		LockButton(interface, "single");
		LockButton(interface, "champ");
		LockButton(interface, "back");
		SendCommandByName("mainmenu", "set_new_game", "false");
--		Update();
		SendCommandByName("main", strBack, ""); 	
	elseif (name == "single")
	 then
		 LockButton(interface, "single");
			LockButton(interface, "champ");
		 LockButton(interface, "back");
 SendCommandByName("main", "set_single", "true");
		 SendCommandByName("main", "road", "");
	elseif(name == "champ")
	then
		LockButton(interface, "single");
		LockButton(interface, "champ");
		LockButton(interface, "back");
		local num = 1;
	if (GetNumRacesPassed() == 1)
	then
		num = 3;
	elseif (GetNumRacesPassed() == 2)
	then
		num = 5;
	elseif (GetNumRacesPassed() == 3)
	then
		num = 4;
	elseif (GetNumRacesPassed() == 4)
	then
		num = 6;
	elseif (GetNumRacesPassed() == 5)
	then
		num = 7;
	elseif (GetNumRacesPassed() == 6)
	then
		num = 8;
	elseif (GetNumRacesPassed() == 7)
	then
		num = 2;
	elseif (GetNumRacesPassed() == 8)
	then
		num = 9;
	elseif (GetNumRacesPassed() == 9)
	then
		num = 1;
	elseif (GetNumRacesPassed() >= 10)
	then
		num = 10;
	end
		Update();
			SendCommandByName("main", "mission", "mission"..num);
		SendCommandByName("main", "set_single", "false");
		SendCommandByName("main", "char", "day"); 
	
		--SendCommandByName("main", "road", "");
--~ 		if (GetNumRacesPassed() == 1)
--~ 		then
--~ 			SetLevelTransportCount(3);
--~ 			SetNumRounds(5);
--~ 		elseif (GetNumRacesPassed() == 2)
--~ 		then
--~ 			SetLevelTransportCount(3);
--~ 			SetNumRounds(5);
--~ 		elseif (GetNumRacesPassed() == 3)
--~ 		then
--~ 			SetLevelTransportCount(3);
--~ 			SetNumRounds(5);
--~ 		elseif (GetNumRacesPassed() == 4)
--~ 		then
--~ 			SetLevelTransportCount(3);
--~ 			SetNumRounds(3);
--~ 		elseif (GetNumRacesPassed() == 5)
--~ 		then
--~ 			SetLevelTransportCount(5);
--~ 			SetNumRounds(5);
--~ 		elseif (GetNumRacesPassed() == 6)
--~ 		then
--~ 			SetLevelTransportCount(3);
--~ 			SetNumRounds(5);
--~ 		end
	end
end

local flag = true;

local function MouseOver()
	flag = false; 
	delay = 0; 
	local name = GetCurrentParams(script);
	if (name == "champ")
	then
		SetTextString(interface, "text", "champ");
	elseif (name == "single")
	then
		SetTextString(interface, "text", "single");
	else
		SetText(interface, "text", "");
	end
--	SetWindowVisible(interface, name .. "_square", true);
--	SetWindowVisible(interface, "square", false);
	UpdateInterfaceBuffers(interface);
end

local function MouseOut()
	flag = true; 
	delay = 0.3; 	
	--SetWindowVisible(interface, "champ_square", false);
	--SetWindowVisible(interface, "single_square", false);
	--SetWindowVisible(interface, "back_square", false);
	SetText(interface, "text", "");
	UpdateInterfaceBuffers(interface);
end 

local function Window()
	local name = GetCurrentParams(script);
	UpdateInterfaceBuffers(interface);
end 



local function MenuUp()
	IMenuRight();
end

local function MenuDown()
	IMenuLeft();
end

local function MenuLeft()
	IMenuLeft();
end

local function MenuRight()
	IMenuRight();
end

local function AddObject()
	local obj = GetCurrentParams(script);
	interface = StringToPointer(obj);
	
	strBack = "mainmenu";
	
	SetWindowVisible(interface, "back_square", false);
	SetWindowVisible(interface, "single_square", false);
	SetWindowVisible(interface, "champ_square", false);
--	SetWindowVisible(interface, "square", true);
	SetWindowVisible(interface, "square", false); 
	
	UnlockButton(interface, "single");
	UnlockButton(interface, "champ");
	UnlockButton(interface, "back");
	
	IMenuRight();
	SetText(interface, "name", GetProfileName());
	local 	str2 = string.format("%0.5d", GetPoints());
	SetText(interface, "points", str2);
	SetText(interface, "races", (GetNumRacesPassed()-1).."/10");
	SetText(interface, "text", "");
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

commandMap["release_all"] 	 = ReleaseAll;
commandMap["add_object"] 	 = AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["mouse_button_over"] = MouseOver; 
commandMap["mouse_button_out"]  = MouseOut; 
commandMap["button"] 	= Button;
commandMap["window"] 	= Window;
commandMap["menu_up"] 	= MenuUp;
commandMap["menu_down"]	= MenuDown;
commandMap["menu_left"]	= MenuLeft;
commandMap["menu_right"]	= MenuRight;
commandMap["back"]		= function () strBack = GetCurrentParams(script); end

while(true)
do
	deltaTime = GetDeltaTime();
	if(flag)
	then 
		delay = delay + deltaTime; 
	end
--	if(delay >= 0.5)
--	then
--		SetWindowVisible(interface, "square", true); 
--		UpdateInterfaceBuffers(interface);
--	end
	ExecuteCommands();
	UpdateInterface(interface);
	Update();
end
