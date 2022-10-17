local script = globalObject;

local player = nil;
local killed = true;

local bGameOver = false;

local commandMap = {};

local MAX_SPEED = 1;
local MIN_SPEED = -1;
local MAX_STEER = 0.7;
local spawn_time = 0;

local ACCELERATION_front = 1;
local ACCELERATION_back = 1;

local game_started = true;

local ss = 0.5;
local fov = 5;

local pGesser = nil;
local pZavulon = nil;

local shot = false;

local timesteer = 0;
local steerspeed = 0;

local CurrentWeapon = nil;

local mF, mB, mR, mL, mBrakes;

local FOV_INIT = 50;
FOV_INIT = GetFov1();

mF = false;
mB = false;
mR = false;
mL = false;

local speed = 0;
local steer = 0;

local camera = false;
local cameraPlayer = 0;
local plr = false;
local timetemp = 1.0;

local special1 = "";
local special2 = "";
local nAbilitiy_time = 0;

local bAbilitiy	= false;
local nAbilitiy_dt	= 0;
local alpha 		= 0;
local pWall		= nil;
local pTornado	= nil;
local pLifting	= nil;
local bLifting 	= false;
local pLiftedPlayer = nil;

local pleft = false;
local pright = false;
local pup = false;
local pdown = false;

local active_side = "";

local deathdt = 0;
local deathmsg = false;

local acc = 0;
local acc2 = 0;
local mom2 = 0;
local moment = 0;
local current_gear = 0;

local gears = {};
gears[-1] = 1;
gears[0] = 0;
gears[1] = 0.7;
gears[2] = 0.7;
gears[3] = 0.7;
gears[4] = 0.7;
gears[5] = 0.8;

local function DeactivateAbilitiy()
--~ 	if("burn_l" == special1)
--~ 	then
--~ 		SetObjectVisible(FindObject(player, special1), false);
--~ 		SetObjectVisible(FindObject(player, special2), false);
--~ 	elseif("force_wall" == special1)
--~ 	then
--~ --		Release(pWall);
--~ 		SetVisible(pWall, false);
--~ 		EraseBonus(pWall);
--~ 		SendCommandByName("main", "update_bonus_list", "");
--~ 		StopSpecialSound("forcewall");
--~ 	elseif("tornado" == special1)
--~ 	then
--~ --		Release(pTornado);
--~ 		SetVisible(pWall, false);
--~ 		EraseBonus(pTornado);
--~ 		SendCommandByName("main", "update_bonus_list", "");
--~ 		StopSpecialSound("voronca_b");
--~ 	elseif("light" == special1)
--~ 	then
--~ 		EraseBonus(FindObject(player, special1));
--~ 		SetObjectVisible(FindObject(player, special1), false);
--~ 	elseif("halo" == special1)
--~ 	then
--~ 		EraseBonus(FindObject(player, special1));
--~ 		SendCommandByName("main", "update_bonus_list", "");
--~ 		SetObjectVisible(FindObject(player, special1), false);
--~ 		SetObjectVisible(FindObject(player, special2), false);
--~ 		StopSpecialSound("avto_razdvig");
--~ 	elseif("lifting" == special1)
--~ 	then
--~ 		pLiftedPlayer = nil;
--~ 		EraseBonus(pLifting);
--~ 		SetVisible(pLifting, false);
--~ --		Release(pLifting);
--~ 		SendCommandByName("main", "update_bonus_list", "");
--~ 		bLifting = false;
--~ 	end
--~ 	
--~ 	bAbilitiy	= false;
end

local function KeyAction()
	local key, pos = GetCurrentParams(script);

	if (killed or bGameOver)
	then
		return;
	end
--~ 	if (key == "jump")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			PlayerApplyImpulse(0, 0, 100);
--~ 		end
--~ 	else

--~ 	if (key == "pleft")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			Pleft();
--~ --			pleft = true;
--~ --		else
--~ --			pleft = false;
--~ 		end
--~ 	elseif (key == "pright")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			Pright();
--~ --			pright = true;
--~ --		else
--~ --			pright = false;
--~ 		end
--~ 	elseif (key == "pup")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			Pup();
--~ 		end
--~ 	elseif (key == "pdown")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			Pdown();
--~ 		end
--~ 	elseif (key == "nitro")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			PlayerNitro(200);
--~ 		end
--~ 	elseif (key == "timep")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			timetemp = timetemp + 0.01;
--~ 			if (timetemp > 1)
--~ 			then
--~ 				timetemp = 1;
--~ 			end
--~ 			SetTemp(timetemp);
--~ 		end
--~ 	elseif (key == "timem")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			timetemp = timetemp - 0.01;
--~ 			if (timetemp < 0)
--~ 			then
--~ 				timetemp = 0;
--~ 			end
--~ 			SetTemp(timetemp);
--~ 		end
--~ 	elseif (key == "esc")
--~ 	then
--~ 		if (pos == "1")
--~ 		then
--~ 			if (timetemp == 1.0)
--~ 			then
--~ 				timetemp = 0;
--~ 				camera = true;
--~ 			else
--~ 				timetemp = 1.0;
--~ 				camera = false;
--~ 			end
--~ 			SetTemp(timetemp);
--~ 			SetCamera(camera);
--~ 		end
	if (key == "camera")
 	then
 		if (pos == "1")
 		then
			cameraPlayer = ChangeGameCamera();
			if (GetCameraPlayer() == 2)
			then
				FOV_INIT = 75;
			elseif (GetCameraPlayer() == 1)
			then
				FOV_INIT = GetFov2();
			elseif (GetCameraPlayer() == 0)
			then
				FOV_INIT = GetFov1();
			end
 		end
--~ 	elseif (key == "player")
--~  	then
--~  		if (pos == "1")
--~  		then
--~  			if (plr == true)
--~  			then
--~ 				plr = true;
--~  			else
--~ 				plr = false;
--~  			end
--~ 			SetCameraPlayer(plr);
--~  		end
	elseif (key == "left")
	then
		if (pos == "0")
		then
--			mBrakes = false;
			mL = false;
	--		timesteer = 0;
			steerspeed = 0;
		else
			if (steer < 0)
			then
				steer = 0;
	--			timesteer = 0;
				steerspeed = 0;
			end
--			mBrakes = true;
			mL = true;
			if (steer > 0)
			then
				steer = 0;
			end
		end
	elseif (key == "right")
	then
		if (pos == "0")
		then
--			mBrakes = false;
			mR = false;
--			timesteer = 0;
			steerspeed = 0;
		else
			if (steer > 0)
			then
				steer = 0;
--				timesteer = 0;
				steerspeed = 0;
			end
--			mBrakes = true;
			mR = true;
			if (steer < 0)
			then
				steer = 0;
			end
		end
	elseif (key == "brake")
	then
		if (pos == "0")
		then
			mBrakes = false;
--			SetBrake(player, false);
		else
			mBrakes = true;
--			SetBrake(player, true);
		end
	elseif (key == "spawn" and game_started and (not IsDead()))
	then
		if (pos == "0")
		then
			Spawn(player, false);
		else
			if (spawn_time > 2)
			then
				speed = 0;
				steer = 0;
				steerspeed = 0;
				Spawn(player);
				spawn_time = 0;
			end
		end
	elseif (key == "up")
	then
		if (pos == "0")
		then
			mBrakes = false;
			mF = false;
		else
			mF = true;
		end
	elseif (key == "down")
	then
		if (pos == "0")
		then
			mBrakes = false;
			mB = false;
		else
			mB = true;
		end
--~ 	elseif (key == "mouse0")
--~ 	then
--~ 		if (GetTemp() == 0.0)
--~ 		then
--~ 			return;
--~ 		end
--~ 		if (pos == "0")
--~ 		then
--~ 			if(bAbilitiy and (nAbilitiy_dt > nAbilitiy_time))
--~ 			then
--~ 				DeactivateAbilitiy();
--~ 			end
--~ 		else
--~ 			if ("burn_l" == special1 and not bAbilitiy)
--~ 			then
--~ 				local nCount = ActivateAbilities();
--~ 				if(nCount > 0)
--~ 				then
--~ 					if (true)--math.abs(GetPlayerSpeed()) * 3.6 < 150)
--~ 					then
--~ 						SetObjectVisible(FindObject(player, special1), true);
--~ 						if("" ~= special2)
--~ 						then
--~ 							SetObjectVisible(FindObject(player, special2), true);
--~ 						end
--~ 						
--~ 						nAbilitiy_dt	= 0.0;
--~ 						bAbilitiy	= true;
--~ 						PlayerNitro(30 * 1.9 * 1.2, nAbilitiy_time);
--~ --						SetTimeBonus(player);
--~ 						SendCommandByName("game_interface", "blink_abilitiy", nAbilitiy_time .. "," .. nCount);
--~ 						SetAbilitiesCount(nCount - 1);
--~ 						local x, y, z = GetPlayerPosition();
--~ 						PlaySpecialSound3D("nitro", x, y, z);
--~ 					end
--~ 				end
--~ 			elseif("force_wall" == special1 and not bAbilitiy)
--~ 			then
--~ 				local nCount = ActivateAbilities();
--~ 				if(nCount > 0)
--~ 				then
--~ 					local x, y, z = GetPlayerPosition();
--~ 					local dx, dy, dz = GetPlayerDirection();
--~ 					SetPosition(pWall, x + dx * 25.0, y + dy * 25.0, -2.5);
--~ 					SetVisible(pWall, true);
--~ 					AddBonus(pWall, -1);
--~ 					SendCommandByName("main", "update_bonus_list", "");
--~ 					
--~ 					nAbilitiy_dt	= 0.0;
--~ 					bAbilitiy	= true;
--~ 					SendCommandByName("game_interface", "blink_abilitiy", nAbilitiy_time .. "," .. nCount);
--~ 					SetAbilitiesCount(nCount - 1);
--~ 					PlaySpecialSound3D("forcewall", x, y, z, true);
--~ 				end
--~ 			elseif("tornado" == special1 and not bAbilitiy)
--~ 			then
--~ 				local nCount = ActivateAbilities();
--~ 				if(nCount > 0)
--~ 				then
--~ 					local x, y, z = GetPlayerPosition();
--~ 					SetPosition(pTornado, x, y, z);
--~ 					SetVisible(pTornado, true);
--~ 					AddBonus(pTornado, -1);
--~ 					SendCommandByName("main", "update_bonus_list", "");
--~ 					
--~ 					nAbilitiy_dt	= 0.0;
--~ 					bAbilitiy	= true;
--~ 					SendCommandByName("game_interface", "blink_abilitiy", nAbilitiy_time .. "," .. nCount);
--~ 					SetAbilitiesCount(nCount - 1);
--~ 					PlaySpecialSound3D("voronca_b", x, y, z, true);
--~ 				end
--~ 			elseif("light" == special1 and not bAbilitiy)
--~ 			then
--~ 				local nCount = ActivateAbilities();
--~ 				if(nCount > 0)
--~ 				then
--~ 					AddBonus(FindObject(player, special1), -1);
--~ 					SendCommandByName("main", "update_bonus_list", "");
--~ 					SetObjectVisible(FindObject(player, special1), true);
--~ 					
--~ 					nAbilitiy_dt	= 0.0;
--~ 					bAbilitiy	= true;
--~ 					SendCommandByName("game_interface", "blink_abilitiy", nAbilitiy_time .. "," .. nCount);
--~ 					SetAbilitiesCount(nCount - 1);
--~ 					local x, y, z = GetPlayerPosition();
--~ 					PlaySpecialSound3D("beer_fara", x, y, z);
--~ 				end
--~ 			elseif("halo" == special1 and not bAbilitiy)
--~ 			then
--~ 				local nCount = ActivateAbilities();
--~ 				if(nCount > 0)
--~ 				then
--~ 					AddBonus(FindObject(player, special1), -1);
--~ 					SendCommandByName("main", "update_bonus_list", "");
--~ 					SetObjectVisible(FindObject(player, special1), true);
--~ 					SetObjectVisible(FindObject(player, special2), true);
--~ 					
--~ 					nAbilitiy_dt	= 0.0;
--~ 					bAbilitiy	= true;
--~ 					SendCommandByName("game_interface", "blink_abilitiy", nAbilitiy_time .. "," .. nCount);
--~ 					SetAbilitiesCount(nCount - 1);
--~ 					local x, y, z = GetPlayerPosition();
--~ 					PlaySpecialSound3D("avto_razdvig", x, y, z, true);
--~ 				end
--~ 			elseif("lifting" == special1 and not bAbilitiy)
--~ 			then
--~ 				local nCount = ActivateAbilities();
--~ 				if(nCount > 0)
--~ 				then
--~ --					pLifting = LoadRenderObject("lifting.rdf", 20);
--~ 					local x, y, z = GetPlayerPosition();
--~ 					local nDist = 0.0;
--~ 					x, y, z, pLiftedPlayer, nDist = GetNearestDayWatchPlayer(x, y, z, true);
--~ 					if(pLiftedPlayer ~= nil and nDist < 20.0)
--~ 					then
--~ 						SetPosition(pLifting, x, y, z);
--~ 						SetAnimation(pLifting, "idle", 1, 1, -1, script);
--~ 						SetVisible(pLifting, true);
--~ 						AddBonus(pLifting, -1);
--~ 						SendCommandByName("main", "update_bonus_list", "");
--~ 						bLifting = true;
--~ 						PlaySpecialSound3D("avto_podnytie", x, y, z);
--~ 						if(pLiftedPlayer ~= nil)
--~ 						then
--~ 							if(GetPlayerName(pLiftedPlayer) == "zil_130_")
--~ 							then
--~ 								ApplyImpulse(pLiftedPlayer, 0.0, 0.0, 500 * GetPlayerMass(pLiftedPlayer)  / 20.0);
--~ 							else
--~ 								ApplyImpulse(pLiftedPlayer, 0.0, 0.0, 500 * GetPlayerMass(pLiftedPlayer) / 4.5);
--~ 							end
--~ 							SetTimeBonus(pLiftedPlayer);
--~ 						end
--~ 					end;
--~ 					
--~ 					nAbilitiy_dt	= 0.0;
--~ 					bAbilitiy	= true;
--~ 					SendCommandByName("game_interface", "blink_abilitiy", nAbilitiy_time .. "," .. nCount);
--~ 					SetAbilitiesCount(nCount - 1);
--~ 				end				
--~ 			end
--~ 			--if (special1 ~= "")
--~ 			--then
--~ 			--	SetObjectVisible(FindObject(player, special1), true);
--~ 			--end
--~ 			--if (special2 ~= "")
--~ 			--then
--~ 			--	SetObjectVisible(FindObject(player, special2), true);
--~ 			--end
--~ 		end
--~ 	elseif (key == "mouse1")
--~ 	then
--~ 		--if (pos == "0")
--~ 		--then
--~ 		--	SetMineShot(player, true);
--~ 		--else
--~ 		--	SetMineShot(player, false);			
--~ 		--end
--~ 		if (GetTemp() == 0.0)
--~ 		then
--~ 			return;
--~ 		end
--~ 		if(pos == "0")
--~ 		then
--~ 			if(GetPlayerMana() >= 100)
--~ 			then
--~ 				SetPlayerMana(0);
--~ 				local acar = GetActiveCar();
--~ 				if((acar == "audi_tt") or (acar == "bmw_i745") or (acar == "volk_t"))
--~ 				then
--~ 					SendCommandByName("zavulon", "start", "0");
--~ 					SendCommandByName("game_interface", "show_message", "zavulon!");
--~ 				else
--~ 					SendCommandByName("geser", "start", "0");
--~ 					SendCommandByName("game_interface", "show_message", "gesser!");
--~ 				end
--~ 			end
--~ 		end
--~ 	elseif (key == "dump")
--~ 	then
--~ 		if (pos == "0")
--~ 		then
--~ 			DumpObjects();
--~ 		else
--~ --			SetMineShot(player, false);			
--~ 		end
--~ 	elseif (key == "super")
--~ 	then
--~ 		if (pos == "0")
--~ 		then
--~ 			SmartBomb();
--~ 		end
--~ 	elseif (key == "next_weapon")
--~ 	then
--~ 		if (pos == "0")
--~ 		then
--~ 			SetNextWeapon(player);
--~ 			SendCommandByName("gamemenu", "update_game_interface", "");
--~ 		else
--~ 		end
--	elseif (key == "jump")
--	then
--		if (pos == "0")
--		then
--			Jump(player, 0, 0, 500);
--		else
----			SetShot(player, true);			
--		end
--~ 	elseif (key == "prev_weapon")
--~ 	then
--~ 		if (pos == "0")
--~ 		then
--~ 			SetPrevWeapon(player);
--~ 			SendCommandByName("gamemenu", "update_game_interface", "");
--~ 		else
--~ 		end
	end
	
end

local function ExecuteCommands()
	while(SetNextCommand(script))
	do
		local command = GetCurrentCommand(script);
		if (commandMap[command])
		then
--			CheckString(command);
			commandMap[command]();
			
		end
	end
end

local function InitSettings()
	bGameOver = false;

	MAX_SPEED = 1;
	MIN_SPEED = -1;

	spawn_time = 0;

	ACCELERATION_front = 1;
	ACCELERATION_back = 1;

	ss = 0.5;
	fov = 5;

	timesteer = 0;
	steerspeed = 0;


	mF = false;
	mB = false;
	mR = false;
	mL = false;
	mBrakes = false;

	speed = 0;
	steer = 0;

	camera = false;
	cameraPlayer = 0;

	nAbilitiy_time = 0;

	bAbilitiy	= false;
	nAbilitiy_dt	= 0;
	alpha 		= 0;
	pWall		= nil;
	pTornado	= nil;
	pLifting	= nil;
	bLifting 	= false;
	pLiftedPlayer = nil;


	active_side = "";
	
	
	ss = 5;
end

local function AddObject()
	player = StringToPointer(GetCurrentParams(script));
--	SetShot(player, false);
	killed = false;
	
	InitSettings();
	
--~ 	local acar = GetActiveCar();
--~ 	if (acar == "volk_t")
--~ 	then
--~ 		active_side = "dark";
--~ 		special1 = "halo";
--~ 		special2 = "halo_blend";
--~ 		nAbilitiy_time = 8.0;
--~ 	elseif (acar == "uaz_469")
--~ 	then
--~ 		active_side = "light";
--~ 		special1 = "light";
--~ 		special2 = "";
--~ 		nAbilitiy_time = 12.0;
--~ 	elseif (acar == "zil_130")
--~ 	then
--~ 		active_side = "light";
--~ 		special1 = "burn_l";
--~ 		special2 = "burn_r";
--~ 		nAbilitiy_time = 1.5;
--~ 	elseif("gaz_z110" == acar)
--~ 	then
--~ 		pWall = LoadRenderObject("fw.rdf", 20);
--~ 		active_side = "light";
--~ 		special1 = "force_wall";
--~ 		special2 = "";
--~ 		nAbilitiy_time = 8.0;
--~ 	elseif("audi_tt" == acar)
--~ 	then
--~ 		pTornado = LoadRenderObject("v_small.rdf", 20);
--~ 		active_side = "dark";
--~ 		special1 = "tornado";
--~ 		special2 = "";
--~ 		nAbilitiy_time = 8.0;
--~ 	elseif("bmw_i745" == acar)
--~ 	then
--~ 		pLifting = LoadRenderObject("lifting.rdf", 20);
--~ 		active_side = "dark";
--~ 		special1 = "lifting";
--~ 		special2 = "";
--~ 		nAbilitiy_time = 6.0;
--~ 	end
--~ 	
--~ 	
--~ 	if (special1 ~= "" and special1 ~= "force_wall" and special1 ~= "tornado" and special1 ~= "lifting")
--~ 	then
--~ 		SetObjectVisible(FindObject(player, special1), false);
--~ 	end
--~ 	if (special2 ~= "")
--~ 	then
--~ 		SetObjectVisible(FindObject(player, special2), false);
--~ 	end
--~ 	
--~ 	SetAbilitiesCount(0);
	
--	pGesser = LoadRenderObject("gesser.rdf", 20);
--	ActivateObject(pGesser, 20);
--	pZavulon = LoadRenderObject("zavulon.rdf", 20);
--	ActivateObject(pZavulon, 20);
	game_started = true;
	FOV_INIT = GetFov1();
	deathdt = 0;
	deathmsg = false;

	acc = 0;
	acc2 = 0;
	mom2 = 0;
	moment = 0;
	current_gear = 0;
end

local function DeleteObject()
--~ 	StopSpecialSound("forcewall");
--~ 	StopSpecialSound("voronca_b");
--~ 	StopSpecialSound("avto_razdvig");
--~ 	if("burn_l" == special1)
--~ 	then
--~ 	elseif("force_wall" == special1)
--~ 	then
--~ 		Release(pWall);
--~ 	elseif("tornado" == special1)
--~ 	then
--~ 		Release(pTornado);
--~ 	elseif("light" == special1)
--~ 	then
--~ 	elseif("halo" == special1)
--~ 	then
--~ 	elseif("lifting" == special1)
--~ 	then
--~ 		Release(pLifting);
--~ 	end
--~ --	Release(pGesser);
--~ 	pGesser = nil;
--~ --	Release(pZavulon);
--~ 	pZavulon = nil;
--~ --	KillPlayer(player);
	Release(player);
	player = nil;
	StopScript(script);
end

local function ReleaseAll()
--	DeactivateInterface(player);
	player = nil;
end

local function Damage()
--~ 	local d = tonumber(GetCurrentParams(script));
--~ 	if (not DamagePlayer(player, d))
--~ 	then
--~ 		killed = true;
--~ 		KillPlayer(player);
--~ 	end
end

local function SetCarParameters()
--	CheckString("SetCarParams - start");
--	local p1, p2, p3 = GetCurrentParams(script);
	local p1, p2, p3, p4 = GetCurrentParams(script);

	ss = tonumber(p1);
	fov = tonumber(p2);
	ACCELERATION_front = tonumber(p3);
	ACCELERATION_back = tonumber(p4);
	
	local srrr = string.format("ss:%f fov:%f accl_front:%f accl_back:%f", p1, p2, p3, p4);
	SaveLog(srrr);
	
--	MAX_SPEED = p5;
--	MIN_SPEED = p6;
	
--	MAX_SPEED = tonumber(p1);
--	CheckString(p1);
--	MIN_SPEED = tonumber(p2);
--	CheckString(p2);
--	ACCELERATION = tonumber(p3);
--	CheckString(p3);
--	CheckString("SetCarParams - finish");
end

local function SetCarParameters2()
--	CheckString("SetCarParams - start");
--	local p1, p2, p3 = GetCurrentParams(script);
	local p1, p2 = GetCurrentParams(script);

	MAX_SPEED = tonumber(p1);
	MIN_SPEED = tonumber(p2);
	local srrr = string.format("max_speed:%f min_speed:%f", p1, p2);
	SaveLog(srrr);
	
--	MAX_SPEED = tonumber(p1);
--	CheckString(p1);
--	MIN_SPEED = tonumber(p2);
--	CheckString(p2);
--	ACCELERATION = tonumber(p3);
--	CheckString(p3);
--	CheckString("SetCarParams - finish");
end

local function GameOver()
	bGameOver = true;
	mF = false;
	mB = false;
	mR = false;
	mL = false;
	mBrakes = false;

	speed = 0;
	steer = 0;
	SetCarParams(player, 0, 0);	
end

local function LeaveTransport()
	if(bAbilitiy and "lifting" == special1 and bLifting)
	then
		local transport = StringToPointer(GetCurrentParams(script));
		if (transport == pLiftedPlayer)
		then
			DeactivateAbilitiy();
		end
	end
end


local function GameStarted()
	game_started = true;
end

commandMap["add_object"] = AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["key_action"] = KeyAction;
commandMap["release_all"] = ReleaseAll;
commandMap["damage"] = Damage;
commandMap["set_car_params"] = SetCarParameters;
commandMap["set_car_params2"] = SetCarParameters2;
commandMap["game_over"] = GameOver;
commandMap["leave_transport"] = LeaveTransport;
commandMap["game_started"] = GameStarted;--commandMap["animation_stopped"] = function () if(pLifting ~= nil) then SetVisible(pLifting, false); end; end;

while(true)
do
--	SaveLog("jeep");
	ExecuteCommands();
	
	local pspeed = GetPlayerSpeed();
	if (pspeed > 0)
	then
		local blur = (pspeed) / 150.0;
--~ 		if (special1 == "burn_l" and pspeed > 50)
--~ 		then
--~ 			SetMotionBlur(blur);
--~ 		else
--~ 			SetMotionBlur(0.0);		
--~ 		end
		SetFOV(FOV_INIT + pspeed / fov);
--~ 		blur = blur / 20.0;
--~ 		if (blur < 0.0)
--~ 		then
--~ 			blur = 0.0;
--~ 		elseif (blur > 1.0)
--~ 		then
--~ 			blur = 1.0;
--~ 		end
--~ 		blur = blur * 10.0;
--		if (blur < 1)
--		then
--			blur = 0.0;
--		end
		if (GetCameraPlayer() == 2)
		then
			SetRadialBlur(blur * 7.0);
--			SaveLog("blur\n");
		else
			SetRadialBlur(0);
		
		end
		
	else
		SetFOV(FOV_INIT);
		SetRadialBlur(0);
	end
	
	local tr;
	local dt = math.min(0.1, GetDeltaTime());
	deltaTime = dt;
	spawn_time = spawn_time + dt;
	
	
	if (game_started)-- and not mBrakes)
	then
--		SetBrake(player, false);
--	SaveLog("jeep2");
		if (mF)
		then
--	SaveLog("jeep3");
			tr = true;
	--		speed = MAX_SPEED;
			if (speed < 0)
			then
				SetBrake(player, true);
				speed = speed + dt * ACCELERATION_back * 15.0;
			else
--				SetBrake(player, false);
				speed = speed + dt * ACCELERATION_front;
				if (speed > MAX_SPEED)
				then
					speed = MAX_SPEED;
				end
			end
		end
		if (mB)
		then
--	SaveLog("jeep4");
			tr = true;
	--		speed = MIN_SPEED;
			if (speed > 0)
			then
				SetBrake(player, true);
				speed = speed - dt * ACCELERATION_front * 15.0;	
			else
	--			SetBrake(player, false);
				speed = speed - dt * ACCELERATION_back;	
				if (speed < MIN_SPEED)
				then
					speed = MIN_SPEED;
				end
			end
		end
--~ 	elseif (mBrakes)
--~ 	then
--~ 		if (speed > 0)
--~ 		then
--~ 			speed = speed - dt * ACCELERATION_front * 35.0;
--~ 			if (speed < 0)
--~ 			then
--~ 				speed = 0;
--~ 			end
--~ 		elseif (speed < 0)
--~ 		then
--~ 			speed = speed + dt * ACCELERATION_back * 35.0;
--~ 			if (speed > 0)
--~ 			then
--~ 				speed = 0;
--~ 			end
--~ 		end
	
	end
	
	if (mBrakes)
	then
--		PlayerNitro(0);
		SetBrake(player, true);
--~ 		if (speed > 0)
--~ 		then
--~ 			speed = speed - dt * ACCELERATION_front;
--~ 			if (speed < 0)
--~ 			then
--~ 				speed = 0;
--~ 			end
--~ 		elseif (speed < 0)
--~ 		then
--~ 			speed = speed + dt * ACCELERATION_back;
--~ 			if (speed > 0)
--~ 			then
--~ 				speed = 0;
--~ 			end
--~ 		end	
	else
				SetBrake(player, false);
--~ 			if (mF)
--~ 			then
--~ 				PlayerNitro(1);
--~ 			else
--~ 				PlayerNitro(0);
--~ 			end
	end
	
	if (not mF and not mB)
	then
		tr = false;
	end
	
	if (mR or mL)
	then
		timesteer = timesteer + dt;
		if (timesteer > 3) then timesteer = 3; end;
	else
		timesteer = 0;
	end

	if (mL)
	then
		steerspeed = steerspeed + ss * dt;
		steer = steer - dt * ss;-- * GetPlayerSlide();
		--steerspeed;	
		if (steer < -MAX_STEER * GetPlayerSlide())
		then
			steer = -MAX_STEER * GetPlayerSlide();
		end
--~ 		if (IsNitro())
--~ 		then
--~ 			mBrakes = true;
--~ 		else
--~ 			mBrakes = false;
--~ 		end
	elseif (steer < 0 and not mR)
	then
		steer = steer + dt * ss * 20;	
		if (steer > 0.0)
		then
			steer = 0.0;
		end
	end
		
	if (mR)
	then
		steerspeed = steerspeed + ss * dt;
		steer = steer + dt * ss;-- * GetPlayerSlide();
		--steerspeed;	
		if (steer > MAX_STEER * GetPlayerSlide())
		then
			steer = MAX_STEER * GetPlayerSlide();
		end
--~ 		if (IsNitro())
--~ 		then
--~ 			mBrakes = true;
--~ 		else
--~ 			mBrakes = false;
--~ 		end
	elseif (steer > 0 and not mL)
	then
		steer = steer - dt * ss * 20;	
		if (steer < 0.0)
		then
			steer = 0.0;
		end
	end

	if (not tr)
	then
		if (speed > 0)
		then
			speed = speed - dt * ACCELERATION_front * 1;
			if (speed < 0)
			then
				speed = 0;
			end
		elseif (speed < 0)
		then
			speed = speed + dt * ACCELERATION_back * 1;
			if (speed > 0)
			then
				speed = 0;
			end
		end
	end
	
--	if (not IsDamageMsg())
--	then
		if (not bGameOver)
		then
			if(1 < 0)--!!!GetCurrentRound() > GetRoundsNumber())-- or  (active_side == "dark" and IsLightLeft() == 0)  or (active_side == "light" and IsDarkLeft() == 0))
			then
				bGameOver = true;
				--SendCommandByName("main", "stop_level", "");
				SendCommandByName("game_interface", "show_message", "finish!");
--				SendCommandByName("main", "player_finish", "");
				Update();
	--			local sss = string.format("FINISH %d %d %d %d", GetCurrentRound(), GetRoundsNumber(), IsLightLeft(), IsDarkLeft());
	--			SaveLog(sss);
--				deathdt = 0;
--				deathmsg = false;
			end
--		else
--			deathdt = deathdt + dt;
--			if (deathdt > 3 and not deathmsg)
--			then
--				deathmsg = true;
--			end
			
		end
--	end
	
--~ 	if(bAbilitiy)
--~ 	then
--~ 		if("halo" == special1)
--~ 		then
--~ 			local x, y, z = GetPlayerPosition();
--~ 			UpdateSoundPosition("avto_razdvig", x, y, z);
--~ 			if (GetCameraPlayer() == 2)
--~ 			then	
--~ 				SetObjectVisible(FindObject(player, special1), false);
--~ 				SetObjectVisible(FindObject(player, special2), false);
--~ 			else
--~ 				SetObjectVisible(FindObject(player, special1), true);
--~ 				SetObjectVisible(FindObject(player, special2), true);
--~ 			end
--~ 		elseif("light" == special1)
--~ 		then
--~ 			local x, y, z = GetPlayerPosition();
--~ 			UpdateSoundPosition("beer_fara", x, y, z);
--~ 			if (GetCameraPlayer() == 2)
--~ 			then	
--~ 				SetObjectVisible(FindObject(player, special1), false);
--~ 			else
--~ 				SetObjectVisible(FindObject(player, special1), true);
--~ 			end
--~ 		elseif("burn_l" == special1)
--~ 		then
--~ 			local x, y, z = GetPlayerPosition();
--~ 			UpdateSoundPosition("nitro", x, y, z);
--~ 		elseif("tornado" == special1)
--~ 		then
--~ 			local x, y, z = GetPlayerPosition();
--~ 			local x = x + 4 * math.cos(alpha);
--~ 			local y = y + 4 * math.sin(alpha);
--~ 			
--~ 			SetPosition(pTornado, x, y, z);
--~ 			UpdateSoundPosition("voronca_b", x, y, z);
--~ 			
--~ 			alpha = alpha + 1.5 * GetDeltaTime();
--~ 			if(alpha >= 6.28)
--~ 			then
--~ 				alpha = 0;
--~ 			end
--~ 		elseif("lifting" == special1 and not bLifting)
--~ 		then
--~ --			pLifting = LoadRenderObject("lifting.rdf", 20);
--~ 			local x, y, z = GetPlayerPosition();
--~ 			local nDist = 0.0;
--~ 			x, y, z, pLiftedPlayer, nDist = GetNearestDayWatchPlayer(x, y, z, true);
--~ 			if(pLiftedPlayer ~= nil and nDist < 20.0)
--~ 			then
--~ 				if (not IsSpecialSoundPlaying("avto_podnytie"))
--~ 				then
--~ 					PlaySpecialSound3D("avto_podnytie", x, y, z);
--~ 				end
--~ 				SetPosition(pLifting, x, y, z);
--~ 				SetAnimation(pLifting, "idle", 1, 1, -1, script);
--~ 				SetVisible(pLifting, true);
--~ 				AddBonus(pLifting, -1);
--~ 				SendCommandByName("main", "update_bonus_list", "");
--~ 				bLifting = true;
--~ 				if(pLiftedPlayer ~= nil)
--~ 				then
--~ 					if(GetPlayerName(pLiftedPlayer) == "zil_130_")
--~ 					then
--~ 						ApplyImpulse(pLiftedPlayer, 0.0, 0.0, 500 * GetPlayerMass(pLiftedPlayer) / 20.0);
--~ 					else
--~ 						ApplyImpulse(pLiftedPlayer, 0.0, 0.0, 500 * GetPlayerMass(pLiftedPlayer) / 4.5);
--~ 					end
--~ 					SetTimeBonus(pLiftedPlayer);
--~ 				end
--~ 			end;
--~ 		elseif("lifting" == special1 and bLifting)
--~ 		then
--~ 			if(pLiftedPlayer ~= nil)
--~ 			then
--~ 				local x, y, z = GetPosition(pLiftedPlayer);
--~ 				SetPosition(pLifting, x, y, z - 1.0);
--~ 			end
--~ 		end
--~ 		
--~ 		nAbilitiy_dt = nAbilitiy_dt + GetDeltaTime();
--~ 		if(nAbilitiy_dt > nAbilitiy_time)
--~ 		then
--~ 			DeactivateAbilitiy();
--~ 		end
--~ 	end
	
--~ 	if (pleft)
--~ 	then
--~ 		Pleft();
--~ 	end
--~ 	if (pright)
--~ 	then
--~ 		Pright();
--~ 	end
	if (game_started)-- and not mBrakes)
	then
		if (mF)
		then
			acc = math.max(0, math.min(8, acc + GetDeltaTime() * 2.0));
			if (current_gear <= 0 )
			then
				current_gear = 1;
			end
		end
		if (mB)
		then
			
			acc = math.min(0, math.max(-1, acc - GetDeltaTime() * 3.0));
			current_gear =  - 1;
		end
		if (not mF and not mB)
		then
			acc = acc - acc * GetDeltaTime();
			if (GetPlayerSpeed() < 6 * current_gear and current_gear > 0)
			then
				current_gear = math.max(0, current_gear - 1);
			end
		end
	end
	
	if (acc >= 1 + current_gear and current_gear < 5)
	then
		if (GetPlayerSpeed() >= 6 * current_gear)
		then
			current_gear = current_gear + 1;
			acc = acc * 0.5;
		end
	elseif (acc < 0)
	then
		current_gear = -1;
	end
	
	SetEngineMoment(math.abs(acc));
	mom2 = mom2 + (acc - mom2) * GetDeltaTime();
	
--~ 	if (current_gear == 1)
--~ 	then
--~ 		moment = mom2;
--~ 		elseif (current_gear == 2)
--~ 	then
--~ 		if (GetPlayerSpeed() > 20)
--~ 		then
--~ 			moment = mom2;
--~ 		else
--~ 			moment = moment + (mom2 - moment) * GetDeltaTime() * (GetPlayerSpeed() / 20.0)
--~ 		end
--~ 	elseif (current_gear == 3)
--~ 	then
--~ 		if (GetPlayerSpeed() > 40)
--~ 		then
--~ 			moment = mom2;
--~ 		else
--~ 			moment = moment + (mom2 - moment) * GetDeltaTime() * (GetPlayerSpeed() / 40.0)
--~ 		end
--~ 	end
	
	moment = mom2;
	
--	SetCarParams(player, speed, steer);	

 local _speed_ = moment * gears[current_gear] / 4.0;
	SetCarParams(player,  _speed_, steer);	
	Update();
end
