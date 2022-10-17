local script = globalObject;

local interface;
local commandMap = {};

local actions = {};
local names = {};
local acount;

local music_tiles = {};
local sound_tiles = {};

local menu_move = true;
local curr_key = 0;
--local last_move = true;
local use_joy = false;

local left_indent = 0;
local right_indent = 0;

local bright_x = 0;
local sound_x = 0;
local music_x = 0;

local brightness;
local sound;
local music;


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

local function DeleteObject()
	Release(interface);
	StopScript(script);
	interface = nil;
end

local function ReleaseAll()
	Release(interface);
	interface = nil;
end

local function MenuUp()
	if(menu_move)
	then
		curr_key = curr_key + 1;
		if(curr_key > 10)
		then
			SetFontString(interface, "action" .. 10, "font01", names[10]);
			SetFont(interface, "key" .. 10, "font01", actions[10]);
			curr_key = 0;
		else
			if((curr_key - 1 > 0) and  (curr_key - 1 < 11))
			then
				SetFontString(interface, "action" .. curr_key - 1, "font01", names[curr_key - 1]);
				SetFont(interface, "key" .. curr_key - 1, "font01", actions[curr_key - 1]);
			end
			
			SetFontString(interface, "action" .. curr_key, "font02", names[curr_key]);
			SetFont(interface, "key" .. curr_key, "font02", actions[curr_key]);
		end
		DeselectCurrentButton(interface);
	end
end

local function MenuDown()
	if(menu_move)
	then
		curr_key = curr_key - 1;
		if(curr_key < 1)
		then
			SetFontString(interface, "action" .. 1, "font01", names[1]);
			SetFont(interface, "key" .. 1, "font01", actions[1]);
			curr_key = 11;
		else
			if((curr_key + 1 > 0) and  (curr_key + 1 < 11))
			then
				SetFontString(interface, "action" .. curr_key + 1, "font01", names[curr_key + 1]);
				SetFont(interface, "key" .. curr_key + 1, "font01", actions[curr_key + 1]);
			end
			
			SetFontString(interface, "action" .. curr_key, "font02", names[curr_key]);
			SetFont(interface, "key" .. curr_key, "font02", actions[curr_key]);
		end
		DeselectCurrentButton(interface);
	end
end

local function MenuLeft()
	if(menu_move)
	then
		IMenuLeft();
		if((curr_key > 0) and (curr_key < 11))
		then
			SetFontString(interface, "action" .. curr_key, "font01", names[curr_key]);
			SetFont(interface, "key" .. curr_key, "font01", actions[curr_key]);
		end
		
		curr_key = 0;
	end
end

local function MenuRight()
	if(menu_move)
	then
		IMenuRight();

		if((curr_key > 0) and (curr_key < 11))
		then
			SetFontString(interface, "action" .. curr_key, "font01", names[curr_key]);
			SetFont(interface, "key" .. curr_key, "font01", actions[curr_key]);
		end
		
		curr_key = 0;
	end
end

local function Button()
	PlaySpecialSound("button_click");
	local name = GetCurrentParams(script);

	if("exit" == name)
	then
		LockButton(interface, "close");
--		SaveActions();
--		SaveLog("saved actions");
--		LoadActions("Actions.cfg");		UpdateActions();
		SendCommandByName("main", "mainmenu", "");
	end
end




local function AddObject()
	local obj = GetCurrentParams(script);
	interface = StringToPointer(obj);
	
	
	
	curr_key = 0;
	
	if(menu_move)
	then
		IMenuRight();
	end
	
	
end



commandMap["release_all"] = ReleaseAll;
commandMap["add_object"] = AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["button"] = Button;
commandMap["window"] = Window;
commandMap["key_assign"] = KeyAssign;
--commandMap["key"] = Key;
commandMap["mouse_window_over"] = MouseWndOver;
commandMap["mouse_window_out"] = MouseWndOut;
commandMap["menu_up"] = MenuUp;
commandMap["menu_down"] = MenuDown;
commandMap["menu_left"] = MenuLeft;
commandMap["menu_right"] = MenuRight;
commandMap["standart_action"] = Key;

while(true)
do
	ExecuteCommands();
	UpdateInterface(interface);

	Update();
end
