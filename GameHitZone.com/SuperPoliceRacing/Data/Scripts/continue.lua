local script = globalObject;

local interface;
local commandMap = {};

local	delay = 0; 

local wnd_map = {"", "", ""};
local count = 0;
local curr_wnd = 1;

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

local function FindNext(wnd)
	wnd = wnd + 1;
	if(wnd > 3)
	then
		wnd = 1;
	end
	local j = 0;
	while(wnd_map[wnd] == "")
	do
		wnd = wnd + 1;
		if(wnd > 3)
		then
			wnd = 1;
		end
		j = j + 1;
		if(j > 3)
		then
			return -1;
		end
	end
	
	return wnd;
end

local function FindPrev(wnd)
	wnd = wnd - 1;
	if(wnd < 1)
	then
		wnd = 3;
	end
	local j = 0;
	while(wnd_map[wnd] == "")
	do
		wnd = wnd - 1;
		if(wnd < 1)
		then
			wnd = 3;
		end
		j = j + 1;
		if(j > 3)
		then
			return -1;
		end
	end
	
	return wnd;
end

local function BuildTextes()
	local map = {"", "", ""};
	count, map = GetSaves();
	wnd_map = {"", "", ""};
	local j = 1;
	for i = 1, count do
		if(j > count)
		then
			return;
		end
		while(map[j] == "")
		do
			j = j + 1;
			if(j > count)
			then
				return;
			end
		end
		wnd_map[i] = map[j];
		wnd_map[tostring(i)] = j;
		
		SetWindowVisible(interface, "blank" .. i, false);
		SetText(interface, "file" .. i, wnd_map[i]);
		SetText(interface, "file" .. i .. "_red", "");
		j = j + 1;
	end
end

local function Button()
	local name = GetCurrentParams(script);
	PlaySpecialSound("button_click");
	if ("back" == name)
	then
		LockButton(interface, "back");
		SendCommandByName("main", "mainmenu", "");
	elseif("load" == name and wnd_map[curr_wnd] ~= "")
	then
		LockButton(interface, "load");
		LockButton(interface, "delete");
		LockButton(interface, "back");
		
		local n = wnd_map[tostring(curr_wnd)]  - 1;
		SaveLog("Loading: " .. n);
		LoadGame("save" .. n .. ".sav");
		SendCommandByName("main", "game_loaded", "true");
		SendCommandByName("main", "road", "");
	 --SendCommandByName("main", "set_single", "true");
		-- SendCommandByName("main", "road", "");
	
		UnlockButton(interface, "load");
		UnlockButton(interface, "delete");
		UnlockButton(interface, "back");
	elseif("delete" == name and wnd_map[curr_wnd] ~= "")
	then		
		LockButton(interface, "load");
		LockButton(interface, "delete");
		LockButton(interface, "back");
		
		local n = wnd_map[tostring(curr_wnd)]  - 1;
		DeleteSave("save" .. n .. ".sav");
		
		BuildTextes();
		
		for i = 1, count do
			SetWindowVisible(interface, "blank" .. i, false);
			SetText(interface, "file" .. i, wnd_map[i]);
			SetText(interface, "file" .. i .. "_red", "");
		end
		
		curr_wnd = FindNext(curr_wnd);
		if(-1 == curr_wnd) then
			SendCommandByName("main", "mainmenu", "");
			return;
		end
		
		UnlockButton(interface, "load");
		UnlockButton(interface, "delete");
		UnlockButton(interface, "back");
		
		curr_wnd = 1;
		SetWindowVisible(interface, "blank" .. curr_wnd, true);
		SetText(interface, "file" .. curr_wnd, "");
		SetText(interface, "file" .. curr_wnd .. "_red", wnd_map[curr_wnd]);
		
		UpdateInterfaceBuffers(interface);
	end
end

local function Window()
	local name = GetCurrentParams(script);
	if("blend" == string.sub(name, 1, string.len(name) - 1))
	then
		curr_wnd = tonumber(string.sub(name, -1));

		if(wnd_map[curr_wnd] == "")
		then
			return;
		end
		
		for i = 1, 3 do
			SetWindowVisible(interface, "blank" .. i, false);
			SetText(interface, "file" .. i, tostring(wnd_map[i]));
			SetText(interface, "file" .. i .. "_red", "");
		end
		
		SetWindowVisible(interface, "blank" .. curr_wnd, true);
		SetText(interface, "file" .. curr_wnd, "");
		SetText(interface, "file" .. curr_wnd .. "_red", wnd_map[curr_wnd]);
		UpdateInterfaceBuffers(interface);
	end
end

local flag = true; 

local function MouseOver()
	flag = false; 
	delay = 0; 
	local name = GetCurrentParams(script);
--	SaveLog(name .. "_square");
	SetWindowVisible(interface, name .. "_square", true); 
--	SetWindowVisible(interface, "square", false); 
	UpdateInterfaceBuffers(interface);
end

local function MouseOut()
	flag = true; 
	delay = 0.3; 
	SetWindowVisible(interface, "load_square", false); 
	SetWindowVisible(interface, "delete_square", false);
	SetWindowVisible(interface, "back_square", false);
	UpdateInterfaceBuffers(interface);
end 

local function MenuUp()
	curr_wnd = FindNext(curr_wnd);
	SendCommandByName("continue", "window", "blend" .. curr_wnd);
end

local function MenuDown()
	curr_wnd = FindPrev(curr_wnd);
	SendCommandByName("continue", "window", "blend" .. curr_wnd);
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
	
	BuildTextes();

	SetWindowVisible(interface, "load_square", false);
	SetWindowVisible(interface, "delete_square", false);
	SetWindowVisible(interface, "back_square", false);
	SetWindowVisible(interface, "square", true);
	
	curr_wnd = FindNext(0);
	SetWindowVisible(interface, "blank" .. curr_wnd, true);
	SetText(interface, "file" .. curr_wnd, "");
	SetText(interface, "file" .. curr_wnd .. "_red", wnd_map[curr_wnd]);
	
	UnlockButton(interface, "load");
	UnlockButton(interface, "delete");
	UnlockButton(interface, "back");
	IMenuRight();
	SetWindowVisible(interface, "square", false); 

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

commandMap["release_all"] = ReleaseAll;
commandMap["add_object"] = AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["mouse_button_over"] = MouseOver; 
commandMap["mouse_button_out"] = MouseOut; 
commandMap["button"] = Button; 
commandMap["window"] = Window;
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
	
	ExecuteCommands();
	UpdateInterface(interface);
	Update();
	
end
