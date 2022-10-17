local script = globalObject;

local interface;
local commandMap = {};

local	delay = 0; 
local lock_flag = true;

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
	if (name == "ok")
	then
		LockButton(interface, "ok");
		--NewPlayer(GetEditBoxText(interface, "name"));
		--SetPlayerName(GetEditBoxText(interface, "name"));
		SetProfileName(GetEditBoxText(interface, "name"));
		--SetEditBoxText(interface, "name", "");
		SendCommandByName("main", "set_new_game", "true");
		SendCommandByName("main", "road", ""); 
		SendCommandByName("gamemode", "back", "mainmenu");
--		SendCommandByName("main", "team", "");
	elseif (name == "cancel")
	then
		LockButton(interface, "cancel");
		SendCommandByName("main", "set_new_game", "true");
		SendCommandByName("main", "set_new_game", "false");
		--SetEditBoxText(interface, "name", "");
		SendCommandByName("main", "mainmenu", "");
	end
end

local function Key()
	local key = GetCurrentParams(script);
	
	key = tonumber(key);
	EditBoxProcessKey(interface, "name", key);
	
	if(0 ~= EditBoxTextLength(interface, "name") and lock_flag)
	then
		lock_flag = false;
		UnlockButton(interface, "ok");
		SetWindowVisible(interface, "nook", false);
		IMenuRight();
	elseif(0 == EditBoxTextLength(interface, "name") and not lock_flag)
	then
		lock_flag = true;
		LockButton(interface, "ok");
		SetWindowVisible(interface, "nook", true);
	end
	UpdateInterfaceBuffers(interface);
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
	SetWindowVisible(interface, "ok_square", false); 
	SetWindowVisible(interface, "cancel_square", false); 
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
local mtime = 0;
local bvis = true;

local function AddObject()
	local obj = GetCurrentParams(script);
	interface = StringToPointer(obj);
	
	SetWindowVisible(interface, "ok_square", false); 
	SetWindowVisible(interface, "cancel_square", false); 
--	SetWindowVisible(interface, "square", true);
	SetWindowVisible(interface, "square", false); 
	if(0 == EditBoxTextLength(interface, "name"))
	then
		LockButton(interface, "ok");
		SetWindowVisible(interface, "nook", true);
		EditBoxProcessKey(interface, "name", 8);
	else
		UnlockButton(interface, "ok");
		SetWindowVisible(interface, "nook", false);
	end
	SetWindowVisible(interface, "name", true);
	mtime = 0;
	bvis = true;
	UpdateInterfaceBuffers(interface);
	IMenuRight();
	UnlockButton(interface, "cancel");
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
commandMap["button"] = Button; 
commandMap["key"] = Key;
commandMap["menu_up"] = MenuUp;
commandMap["menu_down"] = MenuDown;
commandMap["menu_left"] = MenuLeft;
commandMap["menu_right"] = MenuRight;

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

--~ 	mtime = mtime + deltaTime;
--~ 	if (mtime >= 0.5)
--~ 	then
--~ 		mtime = 0;
--~ 		bvis = not bvis;
--~ 		SetWindowVisible(interface, "name", bvis);
--~ 		UpdateInterfaceBuffers(interface);
--~ 	end

	ExecuteCommands();
	UpdateInterface(interface);
	Update();
	
end
