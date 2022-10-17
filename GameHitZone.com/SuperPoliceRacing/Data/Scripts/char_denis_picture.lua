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
--	SaveLog("denis");
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

while(true)
do
	ExecuteCommands();
	UpdateInterface(interface);
	Update();
end