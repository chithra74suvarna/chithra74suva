local script = globalObject;
local god = nil;
local commandMap = {};

local BONUS_COUNT		= 16;
local BONUS_UPDATE_TIME	= 15;
local BONUS_SPAWN_D	= 8.0;

--~ bonus ratio in percents
local BONUS_AXEL_RATION		= 10.0;
local BONUS_BRAKE_RATION	= 1.0;
local BONUS_MINUS_RATION	= 10.0;
local BONUS_PLUS_RATION		= 52.0;
local BONUS_GLOOM_RATION	= 17.0;
local BONUS_REPAIR_RATION	= 10.0;


local bSignals = false;
local dt = 0;

local flag1 = false;
local flag0 = false;
local flag2 = false;
local s1, s2, s3 = false, false, false;

local Bonuses = 
{
	pBonuses		= nil;
	nCount		= BONUS_COUNT;
	
	pLoadBonuses	= nil;
	
	fDt			= 0.0;
	
	bGenerated		= false;
	
	Initialize		= nil;
	Update		= nil;
	Generate		= nil;
	UpdateList		= nil;
	Release		= nil;
	nLinesCount = 0;
	nLineStep = 0;
};

Bonuses.Initialize = function ()
	local pBonusAxel		= LoadRenderObject("bonus_axel.rdf", 20);
	local pBonusBrake	= LoadRenderObject("bonus_brake.rdf", 20);
	local pBonusMinus	= LoadRenderObject("bonus_minus.rdf", 20);
	local pBonusPlus		= LoadRenderObject("bonus_plus.rdf", 20);
--	local pBonusGloom	= LoadRenderObject("checkpoint.rdf", 20);
	local pBonusRepair	= LoadRenderObject("bonus_remont.rdf", 20);
	
	local nPercent = BONUS_COUNT / 100.0;
	
	Bonuses.nLinesCount = GetSplineLineCount();
	Bonuses.nLineStep	= ToInt(Bonuses.nLinesCount / BONUS_COUNT);

	Bonuses.pLoadBonuses = {};
	
	Bonuses.pLoadBonuses[1] = {};
	Bonuses.pLoadBonuses[1][1] = pBonusAxel;
	Bonuses.pLoadBonuses[1][2] = 0.0;
--	Bonuses.pLoadBonuses[1][3] = ToInt(nPercent * BONUS_AXEL_RATION);
--	Bonuses.pLoadBonuses[1][3] = (nPercent * BONUS_AXEL_RATION);
	Bonuses.pLoadBonuses[1][3] = BONUS_AXEL_RATION;
	
	Bonuses.pLoadBonuses[2] = {};
	Bonuses.pLoadBonuses[2][1] = pBonusBrake;
	Bonuses.pLoadBonuses[2][2] = 0.0;
--	Bonuses.pLoadBonuses[2][3] = ToInt(nPercent * BONUS_BRAKE_RATION);
--	Bonuses.pLoadBonuses[2][3] = (nPercent * BONUS_BRAKE_RATION);
	Bonuses.pLoadBonuses[2][3] = BONUS_BRAKE_RATION;
	
	Bonuses.pLoadBonuses[3] = {};
	Bonuses.pLoadBonuses[3][1] = pBonusMinus;
	Bonuses.pLoadBonuses[3][2] = 0.0;
--	Bonuses.pLoadBonuses[3][3] = ToInt(nPercent * BONUS_MINUS_RATION);
--	Bonuses.pLoadBonuses[3][3] = (nPercent * BONUS_MINUS_RATION);
	Bonuses.pLoadBonuses[3][3] = BONUS_MINUS_RATION;
	
	Bonuses.pLoadBonuses[4] = {};
	Bonuses.pLoadBonuses[4][1] = pBonusPlus;
	Bonuses.pLoadBonuses[4][2] = 0.0;
--	Bonuses.pLoadBonuses[4][3] = ToInt(nPercent * BONUS_PLUS_RATION);
--	Bonuses.pLoadBonuses[4][3] = (nPercent * BONUS_PLUS_RATION);
	Bonuses.pLoadBonuses[4][3] = BONUS_PLUS_RATION;
	
	Bonuses.pLoadBonuses[5] = {};
--	Bonuses.pLoadBonuses[5][1] = pBonusGloom;
	Bonuses.pLoadBonuses[5][2] = 0.0;
--	Bonuses.pLoadBonuses[5][3] = ToInt(nPercent * BONUS_GLOOM_RATION);
--	Bonuses.pLoadBonuses[5][3] = (nPercent * BONUS_GLOOM_RATION);
	Bonuses.pLoadBonuses[5][3] = BONUS_GLOOM_RATION;
	
	Bonuses.pLoadBonuses[6] = {};
	Bonuses.pLoadBonuses[6][1] = pBonusRepair;
	Bonuses.pLoadBonuses[6][2] = 0.0;
--	Bonuses.pLoadBonuses[6][3] = ToInt(nPercent * BONUS_REPAIR_RATION);
--	Bonuses.pLoadBonuses[6][3] = (nPercent * BONUS_REPAIR_RATION);
	Bonuses.pLoadBonuses[6][3] = BONUS_REPAIR_RATION;
end

Bonuses.Update = function ()
	if(Bonuses.bGenerated)
	then
		for i = 1, Bonuses.nCount do
			if(CheckVisible(Bonuses.pBonuses[i][1]))
			then
				DrawDynamicObject(Bonuses.pBonuses[i][1]);
			end
		end
	end
	
	Bonuses.fDt = Bonuses.fDt + GetDeltaTime();
	if(Bonuses.fDt >= BONUS_UPDATE_TIME)
	then
		Bonuses.Generate();
		Bonuses.fDt = 0.0;
	end
end

Bonuses.Generate = function ()
	if(not Bonuses.bGenerated)
	then
		--math.randomseed(GetDeltaTime() * 1000.0);
		math.randomseed(os.clock());
		
		local iLine 		= 0;
		for i = 1, BONUS_COUNT do
			local pBonus	= nil;
			local rnd = math.random(100);
			local sum = 0;
			for j = 1,6
			do
				if (rnd >= sum and rnd < sum + Bonuses.pLoadBonuses[j][3])
				then
					pBonus = Clone(Bonuses.pLoadBonuses[j][1]);
					break;
				end
				sum = sum + Bonuses.pLoadBonuses[j][3];
			end
--			while(not bFind)
--			do
--				local rnd = math.random(6);
				
--				if(Bonuses.pLoadBonuses[rnd][2] < Bonuses.pLoadBonuses[rnd][3])
--				then
--					pBonus = Clone(Bonuses.pLoadBonuses[rnd][1]);
--					Bonuses.pLoadBonuses[rnd][2] = Bonuses.pLoadBonuses[rnd][2] + 1;
--					bFind = true;
--				end
--			end
			--local pBonus	= Clone(Bonuses.pLoadBonuses[math.random(6)]);
			iLine = math.random(Bonuses.nLinesCount);
			local x, y		= GetSplineLinePoint(iLine);
			
			SetPosition(
				pBonus,
				x - BONUS_SPAWN_D / 3.0 + math.random() * BONUS_SPAWN_D,
				y - BONUS_SPAWN_D / 3.0 + math.random() * BONUS_SPAWN_D,
				0.5
				);
			AddBonus(pBonus, iLine);
			
--			iLine = iLine + Bonuses.nLineStep;
		end
		
		Bonuses.bGenerated = true;
		Bonuses.UpdateList();
	else
		math.randomseed(os.clock());
		
		local iLine 		= 0;
		
		while(GetBonusesCount() < BONUS_COUNT)
		do
			local pBonus	= nil;
			local rnd = math.random(100);
			local sum = 0;
			for j = 1,6
			do
				if (rnd >= sum and rnd < sum + Bonuses.pLoadBonuses[j][3])
				then
					pBonus = Clone(Bonuses.pLoadBonuses[j][1]);
					break;
				end
				sum = sum + Bonuses.pLoadBonuses[j][3];
			end
--			while(not bFind)
--			do
--				local rnd = math.random(6);
				
--				if(Bonuses.pLoadBonuses[rnd][2] < Bonuses.pLoadBonuses[rnd][3])
--				then
--					pBonus = Clone(Bonuses.pLoadBonuses[rnd][1]);
--					Bonuses.pLoadBonuses[rnd][2] = Bonuses.pLoadBonuses[rnd][2] + 1;
--					bFind = true;
--				end
--			end
			--local pBonus	= Clone(Bonuses.pLoadBonuses[math.random(6)]);
			iLine = math.random(Bonuses.nLinesCount);
			local x, y		= GetSplineLinePoint(iLine);
			
			SetPosition(
				pBonus,
				x - BONUS_SPAWN_D / 3.0 + math.random() * BONUS_SPAWN_D,
				y - BONUS_SPAWN_D / 3.0 + math.random() * BONUS_SPAWN_D,
				0.5
				);
			AddBonus(pBonus, iLine);
		end
		Bonuses.UpdateList();
	
	end
end

Bonuses.UpdateList = function ()
	local name = GetCurrentParams(script);
--~ 	
--~ 	if("axel" == name)
--~ 	then
--~ 		Bonuses.pLoadBonuses[1][2] = Bonuses.pLoadBonuses[1][2] - 1;
--~ 	elseif("brake" == name)
--~ 	then
--~ 		Bonuses.pLoadBonuses[2][2] = Bonuses.pLoadBonuses[2][2] - 1;
--~ 	elseif("minus" == name)
--~ 	then
--~ 		Bonuses.pLoadBonuses[3][2] = Bonuses.pLoadBonuses[3][2] - 1;
--~ 	elseif("plus" == name)
--~ 	then
--~ 		Bonuses.pLoadBonuses[4][2] = Bonuses.pLoadBonuses[4][2] - 1;
--~ 	elseif("gloom" == name)
--~ 	then
--~ 		Bonuses.pLoadBonuses[5][2] = Bonuses.pLoadBonuses[5][2] - 1;
--~ 	elseif("repair" == name)
--~ 	then
--~ 		Bonuses.pLoadBonuses[6][2] = Bonuses.pLoadBonuses[6][2] - 1;
--~ 	end
	
	Bonuses.pBonuses	= GetBonusList();
	Bonuses.nCount		= GetBonusesCount();
end

Bonuses.Release = function ()
	Release(pBonusAxel);
	Release(pBonusBrake);
	Release(pBonusMinus);
	Release(pBonusPlus);
--	Release(pBonusGloom);
	Release(pBonusRepair);
	Bonuses.bGenerated = false;
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
	god = StringToPointer(GetCurrentParams(script));
	
	SetLightCoeff(1);	
	
--	Bonuses.Initialize();
--	Bonuses.Generate();
	
	ClearLevelTimers();
		SetLevelStarted(true);

	
	SetLensFlare(82.801, -315.034, 99.029);
	
	
	
 bSignals = false;
 dt = 0;

 flag1 = false;
 flag0 = false;
 flag2 = false;
 s1, s2, s3 = false, false, false;	
 
-- SetMedalTimes(37.1, 42.7, 46.12);
SetMedalTimes(120, 130, 140);
 SetGoals(40);
	
end

local function DeleteObject()
--	Bonuses.Release();

	Release(god);
	god = nil;
--	Update();
	StopScript(script);
end


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


commandMap["release_all"]			= DeleteObject;
commandMap["add_object"]			= AddObject;
commandMap["delete_object"]		= DeleteObject;
commandMap["update_bonus_list"]	= Bonuses.UpdateList;
commandMap["start_signals"] = function () bSignals = true; flag0 = false; flag1 = false; flag2 = false;  dt = 0.0; end


--LockPlayers(false);
--Update();
--Update();
--LockPlayer(false);

ClearLevelTimers();
--SetUpdateTime(true);
--SendCommandByName("game_interface", "show_message", "start!");


while(true)
do
	ExecuteCommands();
	UpdateSignals();

--	if (god ~= nil)
--	then
--	Bonuses.Update();
--	end
	
	Update();
end
