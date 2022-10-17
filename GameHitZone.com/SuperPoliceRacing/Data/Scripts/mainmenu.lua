local script = globalObject;

local interface;
local commandMap = {};

local delay = 0; 
local continue_enable = false;
local bNewGame = false;

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

local function Window()
	local name = GetCurrentParams(script);
	if (name == "logo")
	then
		GoURL("website.url");
	end
end


local function Button()
	local name = GetCurrentParams(script);
	PlaySpecialSound("button_click");
	if (name == "new_game")
	then
		LockButton(interface, "new_game");
		LockButton(interface, "continue");
		LockButton(interface, "options");
		LockButton(interface, "help");
		LockButton(interface, "exit");
--		if(not bNewGame)
--		then
			SendCommandByName("main", "enter_name", "");
--		else
--			SendCommandByName("main", "select", "");
--		end
	elseif (name == "continue")
	then
		LockButton(interface, "new_game");
		LockButton(interface, "continue");
		LockButton(interface, "options");
		LockButton(interface, "help");
		LockButton(interface, "exit");
		SendCommandByName("main", "continue", "");
	elseif("options" == name)
	then
		LockButton(interface, "new_game");
		LockButton(interface, "continue");
		LockButton(interface, "options");
		LockButton(interface, "help");
		LockButton(interface, "exit");
		SendCommandByName("main", "options", "");
	elseif("help" == name)
	then
		LockButton(interface, "new_game");
		LockButton(interface, "continue");
		LockButton(interface, "options");
		LockButton(interface, "help");
		LockButton(interface, "exit");
		SendCommandByName("main", "help", "");
	elseif (name == "exit")
	then
	--	SendCommandByName("main", "help", "");
		LockButton(interface, "new_game");
		LockButton(interface, "continue");
		LockButton(interface, "options");
		LockButton(interface, "help");
		LockButton(interface, "exit");
		local tm = 0;
		while(tm < 0.5)
		do
			UpdateInterface(interface);		
			Update();
			tm = tm + GetDeltaTime();
		end
		KillAllTasks();
	end
end

local flag = true; 

local function MouseOver()
	flag = false; 
	delay = 0; 
	local name = GetCurrentParams(script);
	SetWindowVisible(interface, name .. "_square", true); 
--	SetWindowVisible(interface, "square", false); 
	UpdateInterfaceBuffers(interface);
end

local function MouseOut()
	flag = true; 
	delay = 0.3; 
	SetWindowVisible(interface, "new_game_square", false); 
	SetWindowVisible(interface, "continue_square", false); 
	SetWindowVisible(interface, "options_square", false);
	SetWindowVisible(interface, "help_square", false);
	SetWindowVisible(interface, "exit_square", false);
	UpdateInterfaceBuffers(interface);
end 

local function MouseOverW()
	local name = GetCurrentParams(script);
	if (name == "logo")
	then
		SendCommandByName("logo_a", "set_visible", "1");
		SendCommandByName("logo_na", "set_visible", "0");
	end
end

local function MouseOutW()
	local name = GetCurrentParams(script);
	if (name == "logo")
	then
		SendCommandByName("logo_a", "set_visible", "0");
		SendCommandByName("logo_na", "set_visible", "1");
	end
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

local function CheckSaves()
	local count, map = GetSaves();
	for i = 1, count do
		if(map[i] ~= "")
		then
			continue_enable = true;
			return;
		end
	end
	continue_enable = false;
end

local bLogo = false;


local function AddObject()
	local obj = GetCurrentParams(script);
	interface = StringToPointer(obj);
	CheckSaves();
	SetWindowVisible(interface, "new_game_square", false); 
	SetWindowVisible(interface, "continue_square", false); 
	SetWindowVisible(interface, "options_square", false);
	SetWindowVisible(interface, "help_square", false);
	SetWindowVisible(interface, "exit_square", false);
--	SetWindowVisible(interface, "square", true);
	SetWindowVisible(interface, "square", false); 
	
	if (IsFileExists("fsdata/logo_a.png") and IsFileExists("fsdata/logo_na.png"))
	then
		bLogo = true;
		local x,y = GetTextureSize("fsdata/logo_a.png");
		SetWindowVisible(interface, "logo", true);
		SetWindowSize(interface, "logo", x, y);
	end


	UnlockButton(interface, "new_game");
	if(continue_enable)
	then
		UnlockButton(interface, "continue");
	else
		LockButton(interface, "continue");
	end
	
	UnlockButton(interface, "options");
	UnlockButton(interface, "help");
	UnlockButton(interface, "exit");
	
	bNewGame = false;
	
	IMenuRight();
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

commandMap["release_all"] = ReleaseAll;
commandMap["add_object"] = AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["mouse_button_over"] = MouseOver; 
commandMap["mouse_button_out"] = MouseOut; 
commandMap["mouse_window_over"] = MouseOverW; 
commandMap["mouse_window_out"] = MouseOutW; 
commandMap["button"] = Button; 
commandMap["window"] = Window; 
commandMap["menu_up"] = MenuUp;
commandMap["menu_down"] = MenuDown;
commandMap["menu_left"] = MenuLeft;
commandMap["menu_right"] = MenuRight;
commandMap["set_new_game"] = function () if("true" == GetCurrentParams(script)) then bNewGame = true; else bNewGame = false; end end

while(true)
do
	deltaTime = GetDeltaTime();
	if (flag)
	then 
		delay = delay + deltaTime; 
	end
--	if (delay >= 0.5)
--	then
--		SetWindowVisible(interface, "square", true); 
--		UpdateInterfaceBuffers(interface);
--	end
	SaveLog("Main Menu Update");
	ExecuteCommands();
	UpdateInterface(interface);
	Update();
	
end
