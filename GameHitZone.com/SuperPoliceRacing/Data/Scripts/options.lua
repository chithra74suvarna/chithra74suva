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

local edited_key = -1;
	music_tiles[1] = "music0";
	music_tiles[2] = "music1";
	music_tiles[3] = "music2";
	music_tiles[4] = "music3";
	music_tiles[5] = "music4";
	music_tiles[6] = "music5";
	music_tiles[7] = "music6";
	music_tiles[8] = "music7";
	music_tiles[9] = "music8";
	music_tiles[10] = "music9";
	music_tiles[11] = "music10";
	music_tiles[12] = "music11";
	music_tiles[13] = "music12";
	music_tiles[14] = "music13";
	music_tiles[15] = "music14";
	music_tiles[16] = "music15";
	
	sound_tiles[1] = "sound0";
	sound_tiles[2] = "sound1";
	sound_tiles[3] = "sound2";
	sound_tiles[4] = "sound3";
	sound_tiles[5] = "sound4";
	sound_tiles[6] = "sound5";
	sound_tiles[7] = "sound6";
	sound_tiles[8] = "sound7";
	sound_tiles[9] = "sound8";
	sound_tiles[10] = "sound9";
	sound_tiles[11] = "sound10";
	sound_tiles[12] = "sound11";
	sound_tiles[13] = "sound12";
	sound_tiles[14] = "sound13";
	sound_tiles[15] = "sound14";
	sound_tiles[16] = "sound15";

local function SetSliders()
	left_indent = GetWindowPosition(interface, "bright_less");
	left_indent = left_indent + 20;
	right_indent = GetWindowPosition(interface, "bright_more");
	right_indent = right_indent - 20;
	
	brightness = GetBrightness();
	sound = GetSoundVolume();
	music = GetMusicVolume();
	
	local x, y = GetWindowPosition(interface, "bright_jumper");
	bright_x = 229.0 * brightness + left_indent;
	SetWindowPosition(interface, "bright_jumper", bright_x, y);
	
	x, y = GetWindowPosition(interface, "sound_jumper");
	sound_x = sound * 10.0;
	SetWindowPosition(interface, "sound_jumper", sound_x, y);
	
	x, y = GetWindowPosition(interface, "music_jumper");
	music_x = music * 10.0;
	SetWindowPosition(interface, "music_jumper", music_x, y);
	
	for i = 1, 10
	do
		SetWindowVisible(interface, sound_tiles[i], false);
		SetWindowVisible(interface, music_tiles[i], false);
	end
	for i = 1, tonumber(music_x)
	do
		SetWindowVisible(interface, music_tiles[i], true);
	end
	for i = 1, tonumber(sound_x)
	do
		SetWindowVisible(interface, sound_tiles[i], true);
	end
end

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
--		LoadActions("Actions.cfg");
		UpdateActions();
		SendCommandByName("main", "mainmenu", "");
		SetMusicVolume(music_x / 10.0);
		SetSoundVolume(sound_x / 10.0);
		SetBrightness((bright_x - left_indent) / 229.0);
	elseif("bright_less" == name)
	then
		bright_x = bright_x - 10;
		if (bright_x < left_indent)
		then
			bright_x = left_indent;
		end
		
		local x, y = GetWindowPosition(interface, "bright_jumper");
		SetWindowPosition(interface, "bright_jumper", bright_x, y);
		SetBrightness((bright_x - left_indent) / 229.0);
	elseif("bright_more" == name)
	then
		bright_x = bright_x + 10;
		if (bright_x > right_indent)
		then
			bright_x = right_indent;
		end
		
		local x, y = GetWindowPosition(interface, "bright_jumper");
		SetWindowPosition(interface, "bright_jumper", bright_x, y);
		SetBrightness((bright_x - left_indent) / 229.0);
	elseif("music_less" == name)
	then
		music_x = music_x - 1;
		if (music_x < 0)
		then
			music_x = 0;
		end
		
		local x, y = GetWindowPosition(interface, "music_jumper");
		SetWindowPosition(interface, "music_jumper", music_x, y);
		SetMusicVolume(music_x/10.0);
		SetSliders();		
	elseif ("music_more" == name)
	then
		music_x = music_x + 1;
		if (music_x > 10)
		then
			music_x = 10;
		end
		
		local x, y = GetWindowPosition(interface, "music_jumper");
		SetWindowPosition(interface, "music_jumper", music_x, y);
		SetMusicVolume(music_x/10.0);
		SetSliders();		
	elseif("sound_less" == name)
	then
		sound_x = sound_x - 1;
		if (sound_x < 0)
		then
			sound_x = 0;
		end
		local x, y = GetWindowPosition(interface, "sound_jumper");
		SetWindowPosition(interface, "sound_jumper", sound_x, y);
		SetSoundVolume(sound_x / 10.0);
		
		PlaySpecialSound("car_brake");
		SetSliders();		
	elseif("sound_more" == name)
	then
		sound_x = sound_x + 1;
		if (sound_x > 10)
		then
			sound_x = 10;
		end
		local x, y = GetWindowPosition(interface, "sound_jumper");
		SetWindowPosition(interface, "sound_jumper", sound_x, y);
		SetSoundVolume(sound_x / 10.0);
		
		PlaySpecialSound("car_brake");
		SetSliders();		
	elseif("joy_on" == name)
	then
		use_joy = false;
		SetWindowVisible(interface, "joy_off", true);
		SetWindowVisible(interface, "joy_on", false);
		IMenuLeft();
	elseif("joy_off" == name)
	then
		use_joy = true;
		SetWindowVisible(interface, "joy_on", true);
		SetWindowVisible(interface, "joy_off", false);
		IMenuRight();
	end
end

local function Window()
	local name, x, y = GetCurrentParams(script);
	local sub = string.sub(name, 1, 4);
	if ("keys" == sub)
	then
		local number;
		if (string.len(name) == 5)
		then
			number = string.sub(name, -1);
		else
			number = string.sub(name, -2);
		end
		
		edited_key = tonumber(number);
		if (edited_key <= acount)
		then
			menu_move = false;
			SetText(interface, "key" .. number, "...");
			SetCursor(interface, "none");
			SetAssignKey();
		end
	end
end

local function KeyAssign()
	local name = GetCurrentParams(script);
	SetText(interface, "key".. edited_key, name);
	SetCursor(interface, "cursor");
	SetAction(names[edited_key], name, use_joy);
	acount, actions, names = GetActionNames(); 
	for i = 1, acount
	do
		SetTextString(interface, "action"..i, names[i]);
		--SetText(interface, "action"..i, names[i]);
		SetText(interface, "key"..i, actions[i]);
	end
	
	if((curr_key > 0) and (curr_key < 11))
	then
		SetFontString(interface, "action" .. curr_key, "font02", names[curr_key]);
		SetFont(interface, "key" .. curr_key, "font02", actions[curr_key]);
	end
	
	menu_move = true;
end

local function Key()
	local key,  p = GetCurrentParams(script);
	if(("enter" == key) and ("0" == p) and (curr_key > 0) and (curr_key < 11))
	then
		SendCommandByName("options", "window", "keys" .. curr_key);
	--	if(curr_key <= acount)
	--	then
	--		menu_move = false;
	--		SetText(interface, "key" .. curr_key, "...");
	--		SetCursor(interface, "none");
	--		SetAssignKey();
	--	end
	end
end

local function AddObject()
	local obj = GetCurrentParams(script);
	interface = StringToPointer(obj);
	UnlockButton(interface, "exit");
	
	SetWindowVisible(interface, "joy_off", true);
	SetWindowVisible(interface, "joy_on", false);
	
	SetSliders();
	
	acount, actions, names = GetActionNames(); 
	for i = 1, acount
	do
		SetTextString(interface, "action"..i, names[i]);
		--SetText(interface, "action"..i, names[i]);
		SetText(interface, "key"..i, actions[i]);
	end
	
	curr_key = 0;
	
	if(menu_move)
	then
		IMenuRight();
	end
	
	
end

local function MouseWndOver()
	local name = GetCurrentParams(script);
	
	local sub = string.sub(name, 1, 4);
	if ("keys" == sub)
	then
		local num;
		if (string.len(name) == 5)
		then
			num = string.sub(name, -1);
		else
			num = string.sub(name, -2);
		end

		if((curr_key > 0) and (curr_key < 11))
		then
			SetFontString(interface, "action" .. curr_key, "font01", names[curr_key]);
			SetFont(interface, "key" .. curr_key, "font01", actions[curr_key]);
		end
		
		if((tonumber(num) > 0) and (tonumber(num) < 11))
		then
			curr_key = tonumber(num);
			SetFontString(interface, "action" .. curr_key, "font02", names[curr_key]);
			SetFont(interface, "key" .. curr_key, "font02", actions[curr_key]);
		end
	end
end

local function MouseWndOut()
	local name = GetCurrentParams(script);

	local sub = string.sub(name, 1, 4);
	if ("keys" == sub)
	then
		local num;
		if (string.len(name) == 5)
		then
			num = string.sub(name, -1);
		else
			num = string.sub(name, -2);
		end


		if((curr_key > 0) and (curr_key < 11))
		then
			SetFontString(interface, "action" .. curr_key, "font01", names[curr_key]);
			SetFont(interface, "key" .. curr_key, "font01", actions[curr_key]);
		end
		
		curr_key = 0;
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
	UpdateInterfaceBuffers(interface);
	Update();
end
