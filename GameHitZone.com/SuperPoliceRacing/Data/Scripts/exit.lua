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

local function Button()
	local name = GetCurrentParams(script);
	if ("no" == name)
	then
		LockButton(interface, "no");
		SendCommandByName("main", "exit_interface", "");
		SetTemp(0);
		SetCamera(true);
	elseif("yes" == name)
	then
		SetTemp(1);
		SetCamera(false);
		LockButton(interface, "yes");
		SendCommandByName("main", "player_exit", "");
		SendCommandByName("jeep", "game_over", "");
	elseif("restart" == name)
	then
		SetTemp(1);
		SetCamera(false);
		LockButton(interface, "yes");
		SendCommandByName("main", "player_restart", "");
		SendCommandByName("jeep", "game_over", "");
	end
end

local function AddObject()
	local obj = GetCurrentParams(script);
	interface = StringToPointer(obj);
	SetTemp(0);
	SetCamera(true);
	
	UnlockButton(interface, "yes");
	UnlockButton(interface, "no");
end

local function DeleteObject()
	Release(interface);
	StopScript(script);
	SetTemp(1);
	SetCamera(false);
	interface = nil;
end

local function ReleaseAll()
	Release(interface);
	interface = nil;
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

commandMap["release_all"] = ReleaseAll;
commandMap["add_object"] = AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["button"] = Button; 
commandMap["menu_up"] = MenuUp;
commandMap["menu_down"] = MenuDown;
commandMap["menu_left"] = MenuLeft;
commandMap["menu_right"] = MenuRight;

while(true)
do
	ExecuteCommands();
	UpdateInterface(interface);
	Update();
end
