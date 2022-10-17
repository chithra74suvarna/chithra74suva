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

local function VideoEnd()
	SendCommandByName("main", "video_end", "");
end


commandMap["release_all"] = ReleaseAll;
commandMap["add_object"] = AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["video_end"] = VideoEnd;


while(true)
do
	ExecuteCommands();
	UpdateInterface(interface);

	Update();
end