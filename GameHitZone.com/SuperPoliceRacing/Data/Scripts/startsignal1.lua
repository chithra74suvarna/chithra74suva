local script = globalObject;

local commandMap = {};
local object = nil;

local green	= nil;
local yellow = nil;
local red	= nil;

local green_a	= nil;
local yellow_a	= nil;
local red_a		= nil;

local sprite1	= nil;
local sprite2	= nil;
local sprite3	= nil;

local bSignals = false;
local dt = 0;

local flag1 = false;
local flag0 = false;
local flag2 = false;

local s1, s2, s3 = false, false, false;

local function UpdateSignals()
	if(bSignals)
	then
		dt = dt + GetDeltaTime();
		if ((dt > 1.0) and (not s1) and (not flag0))
		then
			if (not s1)
			then
				PlaySpecialSound("start_a");
				s1 = true;
				SetVisible(red, true);
				SetVisible(red_a, false);
				SetVisible(sprite3, true);
			end
			flag0 = true;
				SendCommandByName("game_interface", "show_message", "ready!");
		end
		
		if((dt > 2.0) and flag0 and (not flag1))
		then
			if (not s2)
			then
				PlaySpecialSound("start_a");
				s2 = true;
			end
		
			SetVisible(red, false);
			SetVisible(red_a, true);
			
			SetVisible(yellow, true);
			SetVisible(yellow_a, false);
			
			SetVisible(green, false);
			SetVisible(green_a, true);
			
			SetVisible(sprite1, false);
			SetVisible(sprite2, true);
			SetVisible(sprite3, false);
			flag1 = true;
					SendCommandByName("game_interface", "show_message", "steady!");
	end
		if((dt > 3.0) and flag1 and flag0 and (not flag2))
		then
			if (not s3)
			then
				PlaySpecialSound("start_b");
				s3 = true;
			end
			
			SetVisible(red, false);
			SetVisible(red_a, true);
			
			SetVisible(yellow, false);
			SetVisible(yellow_a, true);
			
			SetVisible(green, true);
			SetVisible(green_a, false);
			
			SetVisible(sprite1, true);
			SetVisible(sprite2, false);
			SetVisible(sprite3, false);
			dt = 0;
			flag2 = true;
			bSignal = false;
			LockPlayers(false);
			
			LockPlayer(true);
			Update();
			Update();
			LockPlayer(false);
			
			ClearLevelTimers();
			SetUpdateTime(true);
			SendCommandByName("game_interface", "show_message", "start!");
		end
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

local function AddObject()
	object = StringToPointer(GetCurrentParams(script));
	bSignals = false;
	
	green	= FindObject(object, "green");
	SetVisible(green, false);
	
	yellow = FindObject(object, "yellow");
	SetVisible(yellow, false);
	
	red = FindObject(object, "red");
	SetVisible(red, false);
	
	green_a = FindObject(object, "green_a");
	SetVisible(green_a, true);
	
	yellow_a = FindObject(object, "yellow_a");
	SetVisible(yellow_a, true);
	
	red_a	= FindObject(object, "red_a");
	SetVisible(red_a, true);
	
	sprite1 = FindObject(object, "sprite1");
	SetVisible(sprite1, false);
	
	sprite2 = FindObject(object, "sprite2");
	SetVisible(sprite2, false);
	
	sprite3 = FindObject(object, "sprite3");
	SetVisible(sprite3, false);
	
	s1, s2, s3 = false, false, false;
	
	dt = 0.0;
end

local function DeleteObject()
	Release(object);
	object = nil;
	Release(green);
	green = nil;
	Release(yellow);
	yellow = nil;
	Release(red);
	red = nil;
	Release(green_a);
	green_a = nil;
	Release(yellow_a);
	yellow_a = nil;
	Release(red_a);
	red_a = nil;
	Release(sprite1);
	sprite1 = nil;
	Release(sprite2);
	sprite2 = nil;
	Release(sprite3);
	sprite3 = nil;
end

local function ReleaseAll()
	DeactivateInterface(object);
	object = nil;
	Release(green);
	green = nil;
	Release(yellow);
	yellow = nil;
	Release(red);
	red = nil;
	Release(green_a);
	green_a = nil;
	Release(yellow_a);
	yellow_a = nil;
	Release(red_a);
	red_a = nil;
	Release(sprite1);
	sprite1 = nil;
	Release(sprite2);
	sprite2 = nil;
	Release(sprite3);
	sprite3 = nil;
end

commandMap["add_object"] = AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["release_all"] = ReleaseAll;
commandMap["start_signals"] = function () bSignals = true; flag0 = false; flag1 = false; flag2 = false;  dt = 0.0; end

while(true)
do
	ExecuteCommands();
	if (object ~= nil)
	then
		UpdateSignals();
	end
	Update();
end
