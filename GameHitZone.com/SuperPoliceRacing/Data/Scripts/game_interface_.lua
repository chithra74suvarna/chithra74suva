local script = globalObject;

local interface;
local commandMap = {};

local game_started = false;
local active_side = "";
local ingame = false;
local damaged  = false;
local damaged_time = 0;
local game_finish = false;
--local pArrow = CreateArrow("arrow.rdf", 2);

--zil_130 			azot_flame --zil_130_
--uaz_469 			galogen_lights --uaz
--gaz_z110 			force_wall --gaz_3110_main
--audi_tt 			tornado
--bmw_i745 			lifting --bmw
--Volkswaken_Touareg	outforce --volswaken_toureg	 

local cars_abilities = {};
cars_abilities["zil_130"]		= "azot_flame";
cars_abilities["uaz_469"]	= "galogen_lights";
cars_abilities["gaz_z110"]	= "force_wall";   
cars_abilities["audi_tt"]		= "tornado";
cars_abilities["bmw_i745"] 	= "lifting"; 
cars_abilities["volk_t"] 		= "outforce"; 

local cars_abilities_hollow = {};
cars_abilities_hollow["zil_130"]	= "hollow_azot_flame";
cars_abilities_hollow["uaz_469"]	= "hollow_galogen_lights";
cars_abilities_hollow["gaz_z110"]	= "hollow_force_wall"; 
cars_abilities_hollow["audi_tt"]	= "hollow_tornado";
cars_abilities_hollow["bmw_i745"]	= "hollow_lifting";
cars_abilities_hollow["volk_t"]		= "hollow_outforce"; 

local leader = "leader_frame"; 
local Points = 0;
local players = {}; 
players			= SetPlayersPanel();

local dt			= 0;
local dt2			= 0;
local ddt			= 0;
local blink_time 	= 0;
local blink_dt 		= 0;
local blink_ddt		= 0;
local blink_abilitiy 	= 0;
local bBlink		= false;

local round = {}; 

local CheckpointTime = -1;

round[1] = "round_1"; 
round[2] = "round_2"; 
round[3] = "round_3"; 
round[4] = "round_4"; 
round[5] = "round_5";
round[6] = "round_6";
round[7] = "round_7";
round[8] = "round_8";
round[9] = "round_9";
round[10] = "round_10";

local round_time = {}; 

round_time[1] = "round_1_time";
round_time[2] = "round_2_time";
round_time[3] = "round_3_time";
round_time[4] = "round_4_time";
round_time[5] = "round_5_time";
round_time[6] = "round_6_time";
round_time[7] = "round_7_time";
round_time[8] = "round_8_time";
round_time[9] = "round_9_time";
round_time[10] = "round_10_time";


local function ExecuteCommands()
	while(SetNextCommand(script))
	do
		local command = GetCurrentCommand(script);
		if (commandMap[command])
		then
--			SaveLog(command);
			commandMap[command]();
			
		end
	end
end

local function DrawAbilities()
--~ 	local n, max_ab	= ActivateAbilities();
--~ 	local acar			= GetActiveCar();
--~ 	
--~ 	local height = (46 / max_ab) * n;
--~ 	SetWindowSize(interface, "bar_ab_f", 6, -height);
--~ 	
--~ 	if((n == 0) and (not bBlink))
--~ 	then
--~ 		SetWindowVisible(interface, cars_abilities_hollow[acar], true);
--~ 		SetWindowVisible(interface, cars_abilities[acar], false);
--~ 	elseif(not bBlink)
--~ 	then
--~ 		SetWindowVisible(interface, cars_abilities_hollow[acar], false);
--~ 		SetWindowVisible(interface, cars_abilities[acar], true);
--~ 	end
--~ 	
--~ 	UpdateInterfaceBuffers(interface);
end

local function Blink()
--~ 	if(bBlink)
--~ 	then		
--~ 		blink_dt = blink_dt + GetDeltaTime();
--~ 		if(blink_dt < blink_time)
--~ 		then
--~ 			if(0 == blink_abilitiy)
--~ 			then
--~ 				blink_dt = 0.0;
--~ 				bBlink = false;
--~ 				DrawAbilities();
--~ 				return;
--~ 			end
--~ 			
--~ 			local acar = GetActiveCar();
--~ 			
--~ 			blink_ddt = blink_ddt + GetDeltaTime();
--~ 			
--~ 			if(blink_ddt > 0.4)
--~ 			then
--~ 				blink_ddt = 0.0;
--~ 			elseif(blink_ddt > 0.2)
--~ 			then
--~ 				SetWindowVisible(interface, cars_abilities[acar], true);
--~ 				SetWindowVisible(interface, cars_abilities_hollow[acar], false);
--~ 			else
--~ 				SetWindowVisible(interface, cars_abilities_hollow[acar], true);
--~ 				SetWindowVisible(interface, cars_abilities[acar], false);
--~ 			end
--~ 		else
--~ 			blink_dt = 0.0;
--~ 			bBlink = false;
--~ 			DrawAbilities();
--~ 		end
--~ 	end
end

local function DrawEnemiesPoints()
--~ 	local size;
--~ 	local map = {}; 
--~ 	size, map = GetAIPositions();
--~ 	
--~ 	local f = 1;
--~ 	local j = 1;
--~ --	SaveLog(size);
--~ 	for i = 1, size, 3 
--~ 	do 
--~ 		local wnd = "enemy_point"..j;
--~ --		if(true == map[i + 2])
--~ --		then
--~ --			wnd = "friend_point"..f;
--~ --			f = f + 1;
--~ --		else
--~ 			j = j + 1;
--~ --		end
--~ --		SaveLog(wnd);
--~ 		SetWindowPosition(interface, wnd,  map[i], map[i+1]);
--~ 		SetWindowVisible(interface, wnd, true);
--~ 	end 
--~ 	UpdateInterfaceBuffers(interface);
end

local function DrawSummonPanel()
--	local mana = GetPlayerMana();
--	local height = (46 / 100) * mana;
--	SetWindowSize(interface, "bar_summon_f", 6, -height);
--	UpdateInterfaceBuffers(interface);
end

local function DrawPlayersPanel()



	players = SetPlayersPanel(); 
	
--	SetPlayerName("viper");
	local cur_car = GetPlayerName(); 
	for i = 1, 6 do
	--	SaveLog("Player "..players[i]);
		if (players[i] == "10") 
		then
			SetText(interface, "round_curr2", i);
			
		end
	end 
	
	UpdateInterfaceBuffers(interface);
end

local function DrawRoundsInfo()
	
--~ 	local zero = "0"; 
--~ 	local lap_time = {};
--~ 	local count, lap_time = UpdateRoundsTime();
--~ 	
--~ 	local str = {}; 
--~ 	local vis = {};
--~ 	
--~ 	local j = 1;
--~ 	for i = 1, count, 4 do
--~ 		str[j] = string.format("%0.2d:%0.2d:%0.2d ", lap_time[i], lap_time[i+1], lap_time[i+2]);
--~ 		vis[j] = lap_time[i+3];
--~ 		j = j + 1
--~ 	end
--~ 	
--~ 	
--~ 	for i = 1, 10 do 
--~ 		SetWindowVisible(interface, round[i], vis[i]); 
--~ 		if(vis[i])
--~ 		then
--~ 			SetText(interface, round_time[i], str[i]);
--~ 		end;
--~ 		SetWindowVisible(interface, round_time[i], vis[i])
--~ 	end 
end

local function DrawRoundsUpheader()
	local rounds 	= GetRoundsNumber(); 
	local round_curr 	= GetCurrentRound();
	
	if(round_curr <= rounds)
	then
		SetText(interface, "round_curr", round_curr); 
	end
end 

local function DrawTime()
 	local 	minutes, secs, msecs = GetTime(); 
 	local 	str = string.format("%0.2d:%0.2d:%0.2d ", minutes, secs, msecs);
 	SetText(interface, "time", str); 
			local speed = GetPlayerSpeed() * 3.6 / 1.6093 * 2.0;
			local 	str = string.format("%0.3d", speed);
			SetText(interface, "speed", str); 
			local 	str2 = string.format("%0.3d", GetNitro());
			SetText(interface, "nitro", str2); 
  	local 	minutes2, secs2, msecs2 = GetTimeBest(); 
  	local 	str2_ = string.format("%0.2d:%0.2d:%0.2d ", minutes2, secs2, msecs2);
  	SetText(interface, "best", str2_); 
		if (not IsSingleMode())
		then
			local 	minutes3, secs3, msecs3 = GetCheckpointTime(); 
				local 	str4_ = string.format("%0.2d:%0.2d ", secs3, msecs3);
				SetText(interface, "checkpointtime", str4_); 
			end
end

local bSign 		= false;
local bSignVisible	= true;
local function StopSign()
--~ 	local pangle, spangle = GetPlayerSplineAngle();
--~ 	local angle = pangle - spangle;
--~ 	while(angle > 6.283)
--~ 	do
--~ 		angle = angle - 6.283;
--~ 	end
--~ 	while(angle < 0)
--~ 	do
--~ 		angle = angle + 6.283;
--~ 	end

--~ 	if((angle > 1.570) and (angle < 4.713))
--~ 	then
--~ 		bSign = true;
--~ 	else
--~ 		if(bSignVisible)
--~ 		then
--~ 			SetWindowVisible(interface, "stopsign", false);
--~ 		end
--~ 		bSign = false;
--~ 	end
	
	if(IsPlayerMovingBackwards())
	then
		bSign = true;
	else
		if(bSignVisible)
		then
			SetWindowVisible(interface, "stopsign", false);
			SetText(interface, "spawn", "");
		end
		bSign = false;
	end
	
--	SaveLog("updateinterface3_5");

	if(bSign)
	then
		dt = dt + GetDeltaTime();
		if(dt > 0.5)
		then
			if(bSignVisible)
			then
				SetWindowVisible(interface, "stopsign", false);
			SetText(interface, "spawn", "");
				
				bSignVisible = false;
				dt = 0;
			else
				SetWindowVisible(interface, "stopsign", true);
				SetTextString(interface, "spawn", "spawn");
				bSignVisible = true;
				dt = 0;
			end
		end
	end
end

local bSign2 		= false;
local bSignVisible2	= true;
local function UseNitro()
--~ 	local pangle, spangle = GetPlayerSplineAngle();
--~ 	local angle = pangle - spangle;
--~ 	while(angle > 6.283)
--~ 	do
--~ 		angle = angle - 6.283;
--~ 	end
--~ 	while(angle < 0)
--~ 	do
--~ 		angle = angle + 6.283;
--~ 	end

--~ 	if((angle > 1.570) and (angle < 4.713))
--~ 	then
--~ 		bSign = true;
--~ 	else
--~ 		if(bSignVisible)
--~ 		then
--~ 			SetWindowVisible(interface, "stopsign", false);
--~ 		end
--~ 		bSign = false;
--~ 	end
	
	if(GetNitro() > 0 and not IsNitro())
	then
		bSign2 = true;
	else
		if(bSignVisible2)
		then
			SetWindowVisible(interface, "use_nitro", false);
		end
		bSign2 = false;
	end
	
--	SaveLog("updateinterface3_5");

	if(bSign2)
	then
		dt2 = dt2 + GetDeltaTime();
		if(dt2 > 0.5)
		then
			if(bSignVisible2)
			then
				SetWindowVisible(interface, "use_nitro", false);
				bSignVisible2 = false;
				dt2 = 0;
			else
				SetWindowVisible(interface, "use_nitro", true);
				bSignVisible2 = true;
				dt2 = 0;
			end
		end
	end
end

local function DrawHealth()
--~ 	if(bDrawHealth)
--~ 	then
--~ 		SetWindowVisible(interface, "helth_bar", true);
--~ 		SetWindowPosition(interface, "helth_bar", GetHelthBarCoord(pCar));
--~ 	end
end

local HelthBar = 
{
	fDt		= 0.0;
	pCar		= nil;
	bDraw	= false;
	Draw		= nil;
	Reset		= nil;
};

HelthBar.Draw = function ()
--~ 	if(HelthBar.bDraw)
--~ 	then
--~ 		local x, y, width = GetHelthBarCoord(HelthBar.pCar);
--~ 		if(width < 0.0)
--~ 		then
--~ 			width = 0.0;
--~ 		end
--~ 		
--~ 		SetWindowPosition(interface, "health", x, y);
--~ 		SetWindowPosition(interface, "health_f", x + 3, y + 3);
--~ 		
--~ 		SetWindowSize(interface, "health_f", width, 6);
--~ 		
--~ 		SetWindowVisible(interface, "health", true);
--~ 		SetWindowVisible(interface, "health_f", true);
--~ 		
--~ 		HelthBar.fDt = HelthBar.fDt +GetDeltaTime();
--~ 		if(HelthBar.fDt >= 5.0)
--~ 		then
--~ 			HelthBar.fDt	= 0.0;
--~ 			HelthBar.bDraw	= false;
--~ 			
--~ 			SetWindowVisible(interface, "health", false);
--~ 			SetWindowVisible(interface, "health_f", false);
--~ 		end
--~ 	end
end

HelthBar.Reset = function ()
--	HelthBar.pCar = StringToPointer(GetCurrentParams(script));
--	HelthBar.bDraw	= true;
--	HelthBar.fDt	= 0.0;
end

local lastpoints = 0;

local initbonusx, initbonusy = 0,0;
local initbonusx2, initbonusy2 = 0,0;
local lastbonusx, lastbonusy = 0,0;
local dirx,diry = 0, 0;
local dirx2,diry2 = 0, 0;

local lastPoints = 0;
local TimeTosend = 0;
local lastPoints2 = 0;
local TimeTosend2 = 0;
local statusArrow = 0;
local localPoints = 0;

local function SetPointsLocal(pts)
	localPoints = pts;
end
local function GetPointsLocal()
	return localPoints;
end


local rflag1, rflag2, rflag3, rflag4, rflag5, rflag6, rflag7, rflag8 = false,false,false,false,false,false,false, false;
local rtime = 0;
local rupdatetime = false;
local rpoints = 0;
local rlastpoints = 0;
local showresults = false;
local rplace = 0;
local InitialPoints = 0;

local function HideResults()
	SetWindowVisible(interface, "results_back", false);
	SetWindowVisible(interface, "results_back1", false);
	SetWindowVisible(interface, "results_back2", false);
	SetWindowVisible(interface, "results_text", false);
	SetText(interface, "race_points", "");
	SetText(interface, "race_points_text", "");
	SetText(interface, "finished", "");
	SetText(interface, "finished_text", "");
	SetText(interface, "total", "");
	SetText(interface, "total_points", "");
	SetText(interface, "car_unlocked", "");
	rflag1, rflag2, rflag3, rflag4, rflag5, rflag6, rflag7, rflag8 = false,false,false,false,false,false,false,false;
	rtime = 0;	
	rupdatetime = false;
	rpoints = 0;
	rlastpoints = 0;
	showresults = false;
	rplace = 0;
end
local function ShowResults()
	SetWindowVisible(interface, "1st", false);
	SetWindowVisible(interface, "2nd", false);
	SetWindowVisible(interface, "3rd", false);
	SetWindowVisible(interface, "results_back", true);
	SetWindowVisible(interface, "results_back1", true);
	SetWindowVisible(interface, "results_back2", true);
	SetWindowVisible(interface, "results_text", true);
	rupdatetime = true;
	showresults = true;
end

local function UpdateResults()
	local tt = GetDeltaTime();
	if (rupdatetime)
	then
		rtime = rtime + tt;
	end
	if (not rflag1 and rtime >= 0.5)
	then
		SetTextString(interface, "race_points", "race_points");
		rflag1 = true;
		rtime = 0;
		PlaySpecialSound("fin");
	elseif (rflag1 and not rflag2 and rtime >= 0.5)
	then
		if (rupdatetime)
		then
			rlastpoints = 0;
			rupdatetime = false;
		end
		if (GetPointsLocal() ~= rpoints)
		then
			local num = rpoints + math.max(1, GetDeltaTime() * 100.0);
			num = math.min(num, GetPointsLocal());
			rpoints = num;
			if (rlastpoints + 150 >= num)
			then
				rlastpoints = num;
				PlaySpecialSound("points");
			end
		else
			rupdatetime = true;
			rflag2 = true;
		end
		local 	str2 = string.format("%0.4d", rpoints);
		SetText(interface, "race_points_text", str2);
	elseif (rflag2 and not rflag3 and rtime >= 0.5)
	then
		PlaySpecialSound("fin");
		SetTextString(interface, "finished", "finished"..rplace);
		rflag3 = true;
		rtime = 0;
	elseif (rflag3 and not rflag4 and rtime >= 0.5)
	then
		if (rupdatetime)
		then
			rlastpoints = 0;
			rupdatetime = false;
			rpoints = 0;
		end
		if (300 - ((rplace-1) * 150) ~= rpoints)
		then
			local num = rpoints + math.max(1, GetDeltaTime() * 100.0);
			num = math.min(num, 300 - ((rplace-1) * 150));
			rpoints = num;
			if (rlastpoints + 150 >= num)
			then
				rlastpoints = num;
				PlaySpecialSound("points");
			end
		else
			rupdatetime = true;
			rflag4 = true;
		end
		local 	str2 = string.format("%0.4d", rpoints);
		SetText(interface, "finished_text", str2);
	elseif (rflag4 and not rflag5 and rtime >= 0.5)
	then
		SetTextString(interface, "total", "total_points");
		rflag5 = true;
		rtime = 0;
	elseif (rflag5 and not rflag6 and rtime >= 0.5)
	then
		if (rupdatetime)
		then
			rupdatetime = false;
			rpoints = GetPoints();
			rlastpoints = rpoints;
		end
		if (300 - ((rplace-1) * 150) + GetPointsLocal() + GetPoints() ~= rpoints)
		then
			local num = rpoints + math.max(1, GetDeltaTime() * 100.0);
			num = math.min(num, 300 - ((rplace-1) * 150) + GetPointsLocal() + GetPoints());
			rpoints = num;
			if (rlastpoints + 150 >= num)
			then
				rlastpoints = num;
				PlaySpecialSound("points");
			end
		else
			rupdatetime = true;
			rflag6 = true;
			SetPoints(rpoints);
		end
		local 	str2 = string.format("%0.5d", rpoints);
		SetText(interface, "total_points", str2);
	elseif (rflag6 and not rflag7 and rtime >= 0.5)
	then
		rflag7 = true;
		rtime = 0;
		local newcar = false;
		if (GetPoints() >= 1200 and InitialPoints < 1200)
		then
				newcar = true;
		elseif (GetPoints() >= 2500 and InitialPoints < 2500)
		then
				newcar = true;
		elseif (GetPoints() >= 5000 and InitialPoints < 5000)
		then
				newcar = true;
		elseif (GetPoints() >= 8000 and InitialPoints < 8000)
		then
				newcar = true;
		end
		if (newcar)
		then
				PlaySpecialSound("checkpoint");
				SetTextString(interface, "car_unlocked", "car_unlocked");
		end

--		SendCommandByName("main", "player_finish", "");
	elseif (rflag7 and not rflag8 and rtime >= 1)
	then
		rflag8 = true;
		rtime = 0;
		SendCommandByName("main", "player_finish", "");
		
	end
		
end

local GameMessage = 
{
	Initialize	= nil;
	ShowMsg	= nil;
	Update	= nil;
	Release	= nil;
	dt		= 0.0;
	dt2 = 0;
	wnd		= "";
	bShow	= false;
};

GameMessage.Initialize = function ()
--	SetWindowVisible(interface, "uskorenie!", false);
--	SetWindowVisible(interface, "zamedlenie!", false);
--	SetWindowVisible(interface, "remont!", false);
--	SetWindowVisible(interface, "zavulon!", false);
----	SetWindowVisible(interface, "gesser!", false);
--	SetWindowVisible(interface, "uron_x2!", false);
--	SetWindowVisible(interface, "sposobnost+1!", false);
--	SetWindowVisible(interface, "sposobnost-1!", false);
	SetWindowVisible(interface, "start!", false);
	SetWindowVisible(interface, "finish!", false);
	SetWindowVisible(interface, "krug_proiden!", false);
--	SetWindowVisible(interface, "proigrish!_1", false);
--	SetWindowVisible(interface, "proigrish!_2", false);
	SetWindowVisible(interface, "ready!", false);
	SetWindowVisible(interface, "steady!", false);
	SetWindowVisible(interface, "lost!", false);
--	SetWindowVisible(interface, "drift!", false);

	GameMessage.dt 		= 0.0;
	GameMessage.bShow 	= false;
	GameMessage.wnd 	= "";
end
local MAX_TIME = 1.5;
GameMessage.ShowMsg = function ()
	if(GameMessage.bShow)
	then
		if("proigrish!" == GameMessage.wnd)
		then
			SetWindowVisible(interface, "proigrish!_1", false);
			SetWindowVisible(interface, "proigrish!_2", false);
		else
			SetWindowVisible(interface, GameMessage.wnd, false);
		end	
	end
	MAX_TIME = 1.5;
	GameMessage.wnd = GetCurrentParams(script);
--	SaveLog(GameMessage.wnd);
	
	if (not game_finish)
	then
		PlaySpecialSound("text");
		if("proigrish!" == GameMessage.wnd)
		then
			SetWindowVisible(interface, "proigrish!_1", true);
			SetWindowVisible(interface, "proigrish!_2", true);
			game_finish = true;
		elseif ("finish!" == GameMessage.wnd)
		then
			MAX_TIME = 5;
			game_finish = true;
			SetWindowVisible(interface, GameMessage.wnd, true);
	elseif ("lost!" == GameMessage.wnd)
		then
			MAX_TIME = 5;
			game_finish = true;
			SetWindowVisible(interface, GameMessage.wnd, true);
			SaveGame();

		elseif ("posledniy_krug!" == GameMessage.wnd)
		then
			PlaySpecialSound("start_a");
			SetWindowVisible(interface, GameMessage.wnd, true);
		else
			SetWindowVisible(interface, GameMessage.wnd, true);
		end
	end
	
	
	if("start!" == GameMessage.wnd)
	then
		game_started = true;
		SendCommandByName("jeep", "game_started", "");
	end
	
	
	GameMessage.dt		= 0.0;
	GameMessage.bShow	= true
	UpdateInterfaceBuffers(interface);

end

GameMessage.Update = function ()
	if(GameMessage.dt < MAX_TIME)
	then
		GameMessage.dt = GameMessage.dt + GetDeltaTime();
	elseif(GameMessage.bShow)
	then
		if("proigrish!" == GameMessage.wnd)
		then
			SetWindowVisible(interface, "proigrish!_1", false);
			SetWindowVisible(interface, "proigrish!_2", false);
		elseif("finish!" == GameMessage.wnd)
		then
			SetWindowVisible(interface, GameMessage.wnd, false);
			if (not IsSingleMode())
			then
				ShowResults();
			else
				SendCommandByName("main", "player_finish", "");
			end
		elseif("lost!" == GameMessage.wnd)
		then
			SetWindowVisible(interface, GameMessage.wnd, false);
			SendCommandByName("main", "player_exit", "");
		else
			SetWindowVisible(interface, GameMessage.wnd, false);
		end
		GameMessage.bShow = false;
		UpdateInterfaceBuffers(interface);
	
	end
end

local function UpdateArrows()
	statusArrow = tonumber(GetCurrentParams(script));
	if (statusArrow == 0)
	then
		SetWindowVisible(interface, "wnd_left", false);
		SetWindowVisible(interface, "wnd_right", false);
		SetText(interface, "drift", "");
	elseif (statusArrow == -1)
	then
		SetWindowVisible(interface, "wnd_left", true);
		SetWindowVisible(interface, "wnd_right", false);
		SetTextString(interface, "drift", "drift");
	elseif (statusArrow == 1)
	then
		SetWindowVisible(interface, "wnd_left", false);
		SetWindowVisible(interface, "wnd_right", true);
		SetTextString(interface, "drift", "drift");
	end
end

local function InitSettings()
	ingame = true;
	damaged  = false;
	damaged_time = 0;
	game_finish = false;
	SetPointsLocal(0);
	Points = GetPointsLocal();
	lastpoints = Points;
	lastPoints = 0;
	lastPoints2 = 0;
	initbonusx, initbonusy = GetTextPosition(interface, "bonus_pos");
	initbonusx2, initbonusy2 = GetTextPosition(interface, "bonus_pos2");
	lastbonusx, lastbonusy = GetTextPosition(interface, "points");
	dirx = lastbonusx - initbonusx;
	diry = lastbonusy - initbonusy;
	local sq = math.sqrt(dirx * dirx + diry * diry);
	dirx = dirx / sq;
	diry = diry / sq;
	dirx2 = lastbonusx - initbonusx2;
	diry2 = lastbonusy - initbonusy2;
	local sq2 = math.sqrt(dirx2 * dirx2 + diry2 * diry2);
	dirx2 = dirx2 / sq2;
	diry2 = diry2 / sq2;
	TimeTosend = 0;
	TimeTosend2 = 0;
	SetText(interface, "bonus_text", "");
	SetText(interface, "bonus_text2", "");
	statusArrow = 0;
		SetText(interface, "spawn", "");
		InitialPoints = GetPoints();
		
	if (not IsSingleMode())
	then
		SetWindowVisible(interface, "wnd_checkpointtime", true);
		SetWindowVisible(interface, "wnd_points", true);
	else
		SetWindowVisible(interface, "wnd_checkpointtime", false);
		SetWindowVisible(interface, "wnd_points", false);
		SetText(interface, "checkpointtime", "");
		SetText(interface, "points", "");
	end
	
end

local function AddObject()
--	SaveLog("add_object");
	local obj = GetCurrentParams(script);
	interface = StringToPointer(obj);
--	DrawAbilities(); 
	DrawPlayersPanel(); 
	DrawRoundsInfo(); 
	DrawRoundsUpheader(); 
	DrawTime();
	GameMessage.Initialize();
--	SaveLog("initialized");
	
	game_started = false;
	dt			= 0;
	dt2 = 0;
	blink_time 	= 0;
	blink_dt 		= 0;
	blink_ddt		= 0;
	blink_abilitiy	= 0;
	bBlink		= false;
--	GetPlayerSplineAngle(true);

	SetWindowVisible(interface, "stopsign", false);
	SetWindowVisible(interface, "use_nitro", false);
	SetWindowVisible(interface, "1st", false);
	SetWindowVisible(interface, "2nd", false);
	SetWindowVisible(interface, "3rd", false);
			SetWindowVisible(interface, "checkpoint!", false);	
			SetWindowVisible(interface, "timeout!", false);	
--	SetWindowVisible(interface, GetActiveCar().."_", true);
	
--~ 	SetText(interface, "round_1_time", "");
--~ 	SetText(interface, "round_2_time", "");
--~ 	SetText(interface, "round_3_time", "");
--~ 	SetText(interface, "round_4_time", "");
--~ 	SetText(interface, "round_5_time", "");
--~ 	SetText(interface, "round_6_time", "");
--~ 	SetText(interface, "round_7_time", "");
--~ 	SetText(interface, "round_8_time", "");
--~ 	SetText(interface, "round_9_time", "");
--~ 	SetText(interface, "round_10_time", "");
--~ 	SetWindowVisible(interface, "round_1_time", false);
--~ 	SetWindowVisible(interface, "round_2_time", false);
--~ 	SetWindowVisible(interface, "round_3_time", false);
--~ 	SetWindowVisible(interface, "round_4_time", false);
--~ 	SetWindowVisible(interface, "round_5_time", false);
--~ 	SetWindowVisible(interface, "round_6_time", false);
--~ 	SetWindowVisible(interface, "round_7_time", false);
--~ 	SetWindowVisible(interface, "round_8_time", false);
--~ 	SetWindowVisible(interface, "round_9_time", false);
--~ 	SetWindowVisible(interface, "round_10_time", false);
	

--	SetPlayerMana(0);
--	DrawSummonPanel();	
--	local acar = GetActiveCar();
--~ 	if((acar == "audi_tt") or (acar == "bmw_i745") or (acar == "volk_t"))
--~ 	then
--~ 		SetWindowVisible(interface, "zavulon", true);
--~ 		active_side = "dark";
--~ 	else
--~ 		SetWindowVisible(interface, "gesser", true);
--~ 		active_side = "light";
--~ 	end
	
--	SetText(interface, "time_curr", "TIME:");
--	SetText(interface, "time_best", "BEST:");
	InitSettings();
	HideResults();
	UpdateInterfaceBuffers(interface);
--	SaveLog("interface_updated");
end
local function UpdateBonusText()
	local dt = GetDeltaTime();
	TimeTosend = math.max(0, 	TimeTosend - dt);
	if (lastPoints ~= 0 and TimeTosend == 0)
	then
		initbonusx = initbonusx + dirx * dt * 1500.0;
		initbonusy = initbonusy + diry * dt * 1500.0;
		SetTextPosition(interface, "bonus_text", initbonusx, initbonusy);
		if (initbonusx >= lastbonusx and initbonusy <= lastbonusy)
		then
			SendCommandByName("game_interface", "add_points", lastPoints);
			lastPoints = 0;
			SetText(interface, "bonus_text", "");
		end
	end
end

local function UpdateBonusText2()
	local dt = GetDeltaTime();
	TimeTosend2 = math.max(0, 	TimeTosend2 - dt);
	if (lastPoints2 ~= 0 and TimeTosend2 == 0)
	then
		initbonusx2 = initbonusx2 + dirx2 * dt * 1500.0;
		initbonusy2 = initbonusy2 + diry2 * dt * 1500.0;
		SetTextPosition(interface, "bonus_text2", initbonusx2, initbonusy2);
		if (initbonusx2 >= lastbonusx and initbonusy2 <= lastbonusy)
		then
			SendCommandByName("game_interface", "add_points", lastPoints2);
			lastPoints2 = 0;
			SetText(interface, "bonus_text2", "");
		end
	end
end


local function SetBonusText()
		if (not IsSingleMode())
		then
			local name, title, sec = GetCurrentParams(script);
			if (name == "time")
			then
				local str = string.format("%s^%.1fsec X 10 = %d", title, tonumber(sec), tonumber(sec) * 10);
				SetText(interface, "bonus_text", str);
				lastPoints = tonumber(sec) * 10;
				TimeTosend = 1.5;
				initbonusx, initbonusy = GetTextPosition(interface, "bonus_pos");
				SetTextPosition(interface, "bonus_text", initbonusx, initbonusy);
			end
		end
end

local function SetBonusText2()
		if (not IsSingleMode())
		then
			local name, title, sec = GetCurrentParams(script);
			if (name == "time")
			then
				local str = string.format("%s^%.1fsec X 10 = %d", title, tonumber(sec), tonumber(sec) * 10);
				SetText(interface, "bonus_text2", str);
				lastPoints2 = tonumber(sec) * 10;
				TimeTosend2 = 0.5;
				initbonusx2, initbonusy2 = GetTextPosition(interface, "bonus_pos2");
				SetTextPosition(interface, "bonus_text2", initbonusx2, initbonusy2);
			end
		end
end

local function DeleteObject()
--~ 	SetWindowVisible(interface, cars_abilities[GetActiveCar()], false);
--~ 	SetWindowVisible(interface, cars_abilities_hollow[GetActiveCar()], false);
--~ 	SetWindowVisible(interface, GetActiveCar().."_", false);
--~ 	SetWindowVisible(interface, "zavulon", false);
--~ 	SetWindowVisible(interface, "gesser", false);
	
	Release(interface);
	interface = nil;
	
	StopScript(script);
	ingame = false;
--	Update();
end

local function ReleaseAll()
--~ 	SetWindowVisible(interface, cars_abilities[GetActiveCar()], false);
--~ 	SetWindowVisible(interface, cars_abilities_hollow[GetActiveCar()], false);
--~ 	SetWindowVisible(interface, GetActiveCar().."_", false);
	
	Release(interface);
	interface = nil;
end


local function UpdatePoints()
	if (GetPointsLocal() ~= Points)
	then
		local num = GetPointsLocal() + math.max(1, GetDeltaTime() * 5.0);
		num = math.min(num, Points);
		SetPointsLocal(num);
		if (lastpoints + 10 >= num)
		then
			lastpoints = num;
			PlaySpecialSound("points");
		end
	end
	local 	str2 = string.format("%0.4d", GetPointsLocal());
	SetText(interface, "points", str2);
end

local function ShowPlace()
--	SaveLog("add_object");
	local name = GetCurrentParams(script);
	SetWindowVisible(interface, name, true);
	if (name == "1st")
	then	
		rplace = 1;
	elseif (name == "2nd")
	then	
		rplace = 2;
	elseif (name == "3rd")
	then	
		rplace = 3;
	end
end

local function ShowCheckpoint()
--	SaveLog("add_object");
		if (not IsSingleMode())
		then
			local name, type = GetCurrentParams(script);
			if (type ~= "0")
			then
				SetWindowVisible(interface, name, true);	
				CheckpointTime = 1;
				if (name == "checkpoint!")
				then
					PlaySpecialSound("checkpoint");
				end
			end
		end
end

local function AddPoints()
		if (not IsSingleMode())
		then
		--	SaveLog("add_object");
			local name = tonumber(GetCurrentParams(script));
			Points = Points + name;	
		end
end

commandMap["release_all"] 		= ReleaseAll;
commandMap["add_object"] 		= AddObject;
commandMap["delete_object"] 	= DeleteObject;
--commandMap["redraw_abilities"] 	= DrawAbilities;
--commandMap["blink_abilitiy"]		= function () DrawAbilities(); blink_time, blink_abilitiy = GetCurrentParams(script); blink_time = tonumber(blink_time); blink_abilitiy = tonumber(blink_abilitiy); bBlink = true; end;
--commandMap["show_health"]		= HelthBar.Reset;
commandMap["show_message"]	= GameMessage.ShowMsg;
commandMap["place"]	= ShowPlace;
commandMap["checkpoint"]	= ShowCheckpoint;
commandMap["add_points"]	= AddPoints;
commandMap["bonus_points"]	= SetBonusText;
commandMap["bonus_points2"]	= SetBonusText2;
commandMap["update_arrows"]	= UpdateArrows;

while(true)
do
	ExecuteCommands();
	if (ingame)
	then

		UpdateInterface(interface);
		if (not IsSingleMode())
		then
			UpdateBonusText();
			UpdateBonusText2();
		end
	--	SaveLog("updateinterface2");
--		local x, y = GetWindowPosition(interface, "arrow");
		--DrawArrow(pArrow, 920, 665);
--		DrawArrow(pArrow, x, y);
--		DrawEnemiesPoints(); 
		DrawRoundsUpheader();
		DrawRoundsInfo();
		if (not IsSingleMode())
		then
			UpdatePoints();
		--	SaveLog("updateinterface3");
			if (showresults)
			then
				UpdateResults();
			end
		end
		ddt = ddt + GetDeltaTime();
		if (not IsSingleMode())
		then
			if (CheckpointTime > 0)
			then
				CheckpointTime = CheckpointTime - GetDeltaTime();
				if (CheckpointTime <= 0)
				then
					SetWindowVisible(interface, "checkpoint!", false);	
					SetWindowVisible(interface, "timeout!", false);	
				end
			end
		end
		local dddt;
		if (active_side == "dark")
		then
			dddt = 0.2 / 1.2;
		else
			dddt = 0.2 / 1.6;
		end
		if(ddt >= dddt and game_started)
		then
			local mana = GetPlayerMana();
			if(mana < 100)
			then
				SetPlayerMana((mana + 1));
			end
			
	--		DrawSummonPanel();
			DrawPlayersPanel();
			ddt = 0.0;
--~ 			if (GetPlayerDamage() < 75)
--~ 			then
--~ 				SetWindowVisible(interface, GetActiveCar().."_", true);
--~			end
		end
		
	--	SaveLog("updateinterface3_1");
	--	HelthBar.Draw();
		GameMessage.Update();
	--	SaveLog("updateinterface3_2");
		
		StopSign();
		if (IsLevelStarted())
		then
			UseNitro();
		end
	--	SaveLog("updateinterface3_3");
	--	Blink();
	--	SaveLog("updateinterface3_4");
		DrawTime();
	--	SaveLog("updateinterface4");
		
--~ 		if (GetPlayerDamage() >= 75)
--~ 		then
--~ 			if (damaged_time > 2 and damaged == true)
--~ 			then
--~ 				damaged_time = 0;
--~ 				damaged = false;
--~ 				SetWindowVisible(interface, GetActiveCar().."_", false);
--~ 			end
--~ 			if (damaged_time > 0.5 and damaged == false)
--~ 			then
--~ 				damaged_time = 0;
--~ 				damaged = true;
--~ 				SetWindowVisible(interface, GetActiveCar().."_", true);
--~ 				PlaySpecialSound("sos");
--~ 			end
--~ 			damaged_time = damaged_time + GetDeltaTime();
--~ 		end
	end
	Update();
end
