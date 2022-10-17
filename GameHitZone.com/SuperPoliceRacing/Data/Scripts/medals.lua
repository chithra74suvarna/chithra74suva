local script = globalObject;

local interface;
local commandMap = {};

local x = 0;
local y = 0;
local z = 0;
local aim = nil;


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
		SetWindowVisible(interface, "goldsmall", false);
		SetWindowVisible(interface, "silversmall", false);
		SetWindowVisible(interface, "bronzesmall", false);
		SetText(interface, "goldtime", "");
		SetText(interface, "silvertime", "");
		SetText(interface, "bronzetime", "");
		UpdateInterfaceBuffers(interface);
--	AddRef(interface);
end

local function Medal()
	local level = GetCurrentParams(script);
	local ftime,nmedal = 0,0;--GetLevelMedalTime(level);
	SaveLog("MEDAL "..level.." "..ftime.." "..nmedal);
	if (ftime == 0)
	then
		SetWindowVisible(interface, "goldsmall", false);
		SetWindowVisible(interface, "silversmall", false);
		SetWindowVisible(interface, "bronzesmall", false);
		SetText(interface, "goldtime", "");
		SetText(interface, "silvertime", "");
		SetText(interface, "bronzetime", "");
	elseif (nmedal == 0)
	then
		local m,s,ms = GetFormattedTime(ftime);
		SetWindowVisible(interface, "goldsmall", true);
		SetWindowVisible(interface, "silversmall", false);
		SetWindowVisible(interface, "bronzesmall", false);
		SetText(interface, "goldtime", string.format("%0.2d:%0.2d ", s,ms));
		SetText(interface, "silvertime", "");
		SetText(interface, "bronzetime", "");
	elseif (nmedal == 1)
	then
		local m,s,ms = GetFormattedTime(ftime);
		SetWindowVisible(interface, "goldsmall", false);
		SetWindowVisible(interface, "silversmall", true);
		SetWindowVisible(interface, "bronzesmall", false);
		SetText(interface, "silvertime", string.format("%0.2d:%0.2d ", s,ms));
		SetText(interface, "goldtime", "");
		SetText(interface, "bronzetime", "");
	elseif (nmedal == 2)
	then
		local m,s,ms = GetFormattedTime(ftime);
		SetWindowVisible(interface, "goldsmall", false);
		SetWindowVisible(interface, "silversmall", false);
		SetWindowVisible(interface, "bronzesmall", true);
		SetText(interface, "bronzetime", string.format("%0.2d:%0.2d ", s,ms));
		SetText(interface, "silvertime", "");
		SetText(interface, "goldtime", "");
	end
	
	UpdateInterfaceBuffers(interface);

--	AddRef(interface);
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

local function SetText()
	local text = GetCurrentParams(script);
	SetTextString(interface, "text", text);
end

commandMap["set_text"] = SetText;
commandMap["release_all"] = ReleaseAll;
commandMap["add_object"] = AddObject;
commandMap["medal"] = Medal;
commandMap["delete_object"] = DeleteObject;commandMap["video_end"] = VideoEnd;



while(true)
do
	ExecuteCommands();
	UpdateInterface(interface);

	Update();
end
