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
	local x,y = GetTextureSize("fsdata/logo_na.png");
	SetWindowSize(interface, "logo", x, y);
	SetWindowVisible(interface, "logo", false);
	UpdateInterfaceBuffers(interface);
	
end

local function SetVisible()
	local num = tonumber(GetCurrentParams(script));
	if (num == 0)
	then
		SetWindowVisible(interface, "logo", false);
	else
		SetWindowVisible(interface, "logo", true);
	end
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
commandMap["set_visible"] = SetVisible;

while(true)
do
	ExecuteCommands();
	UpdateInterface(interface);
	Update();
end
