--main.lua of Dozor

local script = globalObject;
local ple = false;
local plf = false;

--Lap time
local fRace1Time = 300.0;
local fRace2Time = 300.0;
local fRace3Time = 240.0;
local fRace4Time = 240.0;
local fRace5Time = 240.0;
local fRace6Time = 240.0;

--max ability count
local nRace1AbCount = 3;
local nRace2AbCount = 4;
local nRace3AbCount = 5;
local nRace4AbCount = 6;
local nRace5AbCount = 7;
local nRace6AbCount = 8;

--
local current_mission = 1;
local gameovertime = 0;

local isVideoPlaying;
local isInGame = false;
local bsplash1, bsplash2 = false, false;

local gamefailed = false;

local playerdead = false;

local timeBetween;
local lastVideo = "intro";
local inMainMenu = false;

local money_count;

local camera = false;
local plr = false;
local timetemp = 1.0;

local game_finish = false;

local bNewGame 		= false;
local bGameLoaded	= false;
local bSingle		= false;
local bDefeat		= false;
local strTeam 		= "";

local missions = {};
missions[1]   = "loading_simon_1";
missions[2]   = "loading_simon_2";
missions[3]   = "loading_simon_3";
missions[4]   = "loading_simon_4";
missions[5]   = "loading_simon_5";
missions[6]   = "loading_simon_6";

missions[7]   = "loading_ilya_1";
missions[8]   = "loading_ilya_2";
missions[9]   = "loading_ilya_3";
missions[10] = "loading_ilya_4";
missions[11] = "loading_ilya_5";
missions[12] = "loading_ilya_6";

missions[13] = "loading_lena_1";
missions[14] = "loading_lena_2";
missions[15] = "loading_lena_3";
missions[16] = "loading_lena_4";
missions[17] = "loading_lena_5";
missions[18] = "loading_lena_6";

missions[19] = "loading_alice_1";
missions[20] = "loading_alice_2";
missions[21] = "loading_alice_3";
missions[22] = "loading_alice_4";
missions[23] = "loading_alice_5";
missions[24] = "loading_alice_6";

missions[25] = "loading_denis_1";
missions[26] = "loading_denis_2";
missions[27] = "loading_denis_3";
missions[28] = "loading_denis_4";
missions[29] = "loading_denis_5";
missions[30] = "loading_denis_6";

missions[31] = "loading_kostya_1";
missions[32] = "loading_kostya_2";
missions[33] = "loading_kostya_3";
missions[34] = "loading_kostya_4";
missions[35] = "loading_kostya_5";
missions[36] = "loading_kostya_6";

local mission_video = {}
mission_video[1] = "market.avi";
mission_video[2] = "plane.avi";
mission_video[3] = "station.avi";
mission_video[4] = "olga.avi";
mission_video[5] = "vampyres.avi";
mission_video[6] = "voroka.avi";

local loading = {};
--for i = 1,36
--do
--	loading[i] = CreateInterface(missions[i], 0);
--end
local splash1, splash2 = nil,nil;

if (IsFileExists("fsdata/splash1.jpg"))
then
	bsplash1 = true;
	splash1 		= CreateInterface("splash1", 0);
end
--if (IsFileExists("fsdata/splash2.jpg"))
--then
	bsplash2 = true;
	splash2 		= CreateInterface("splash2", 0);
--end
local logoa, logona = nil,nil;
local bLogo = false;
if (IsFileExists("fsdata/logo_a.png") and IsFileExists("fsdata/logo_na.png"))
then
		bLogo = true;
		logoa 		= CreateInterface("logoa", 1);
		logona 		= CreateInterface("logona", 1);
end

local gameInterface 	= CreateInterface("game", 1);
local mainMenu 		= CreateInterface("mainmenu", 1);
--local video			= CreateInterface("video", 0);
local menuName		= CreateInterface("new", 3);
local enterName 		= CreateInterface("enter_name", 2);
local continue 		= CreateInterface("continue", 2);
local options 		= CreateInterface("options", 1);
--local team 			= CreateInterface("team", 2);
--local select 		= CreateInterface("select", 2);
--local select_picture	= CreateInterface("select_picture", 2);
--local testing 		= CreateInterface("testing", 1);
--local loadText 		= CreateInterface("zagruzka", 1);
--local loadChoice 		= CreateInterface("dalee", 1);
local loadChamp		= CreateInterface("championat", 2);
--local loadSingle		= CreateInterface("single_race", 1);
local char		 	= CreateInterface("char", 2);
local road 			= CreateInterface("road", 2);
--local backface 		= CreateInterface("backface", 0);
local publ 		= CreateInterface("publ", 1);

local story1 		= CreateInterface("story1", 1);
local story2 		= CreateInterface("story2", 1);
local story3 		= CreateInterface("story3", 1);
local story4 		= CreateInterface("story4", 1);
local story5 		= CreateInterface("story5", 1);

local back 		= CreateInterface("back", 0);
local back2 		= CreateInterface("back2", 0);
local gray 		= CreateInterface("gray", 4);
--local movie 		= CreateInterface("movie", 2);
--local movie_team 	= CreateInterface("movie_team", 2);
--local continue_picture	= CreateInterface("continue_picture", 1);
--local team_picture	= CreateInterface("team_picture", 1);
local char_alice_picture = CreateInterface("char_alice_picture", 1);
local char_kostya_picture	= CreateInterface("char_kostya_picture", 1);
local char_kostya_picture2	= CreateInterface("char_kostya_picture2", 1);
local char_kostya_picture3	= CreateInterface("char_kostya_picture3", 1);
local char_kostya_picture4	= CreateInterface("char_kostya_picture4", 1);
local char_kostya_picture5	= CreateInterface("char_kostya_picture5", 1);
local char_kostya_picture6	= CreateInterface("char_kostya_picture6", 1);
local char_kostya_picture7	= CreateInterface("char_kostya_picture7", 1);
local char_kostya_picture8	= CreateInterface("char_kostya_picture8", 1);
local char_denis_picture	= CreateInterface("char_denis_picture", 1);
--local char_simon_picture	= CreateInterface("char_simon_picture", 1);
local lock	= CreateInterface("lock", 4);
local lock2	= CreateInterface("lock2", 4);
local lock3	= CreateInterface("lock3", 4);
local lock3_5	= CreateInterface("lock3_5", 4);
local lock3_9	= CreateInterface("lock3_9", 4);
local lock3_13	= CreateInterface("lock3_13", 4);
local lock4	= CreateInterface("lock4", 4);
local lock5	= CreateInterface("lock5", 4);
local help	= CreateInterface("help", 1);
--local left	= CreateInterface("left", 4);
--local right	= CreateInterface("right", 4);
--local char_ilya_picture	= CreateInterface("char_ilya_picture", 1);
--local char_lena_picture	= CreateInterface("char_lena_picture", 1);
--local gameMode		= CreateInterface("game_mode", 2);
--local single			= CreateInterface("single", 2);
--local records		= CreateInterface("records", 2);
--local single_champ_picture 	= CreateInterface("single_champ_picture", 1);
local road_market_picture 	= CreateInterface("road_market_picture", 1);
local road_airplane_picture 	= CreateInterface("road_airplane_picture", 1);
local road_electro_picture	= CreateInterface("road_electro_picture", 1);
local road_olga_picture		= CreateInterface("road_olga_picture", 1);
local road_vampires_picture	= CreateInterface("road_vampires_picture", 1);
local road_funnel_picture	= CreateInterface("road_funnel_picture", 1);
local road_funnel_picture2	= CreateInterface("road_funnel_picture2", 1);
local road_funnel_picture3	= CreateInterface("road_funnel_picture3", 1);
local road_funnel_picture4	= CreateInterface("road_funnel_picture4", 1);
local road_funnel_picture5	= CreateInterface("road_funnel_picture5", 1);
local road_funnel_picture6	= CreateInterface("road_funnel_picture6", 1);
local road_funnel_picture7	= CreateInterface("road_funnel_picture7", 1);
local road_funnel_picture8	= CreateInterface("road_funnel_picture8", 1);
local road_funnel_picture9	= CreateInterface("road_funnel_picture9", 1);
local road_funnel_picture10	= CreateInterface("road_funnel_picture10", 1);
local road_funnel_picture11	= CreateInterface("road_funnel_picture11", 1);
--local player_defeat		= CreateInterface("loose", 2);
--local player_win			= CreateInterface("win", 2);
--local loose_dw_picture		= CreateInterface("loose_daywatch_picture", 1);
--local loose_nw_picture		= CreateInterface("loose_nightwatch_picture", 1);
local exit_int			= CreateInterface("exit", 5);
--local credits			= CreateInterface("credits", 0);

local gameExitShow = false;



--Update();

local stopTimer;
stopTimer = false;
local commandMap = {};

local function DeactivateInterfaces2()
--	DeactivateInterface(single);
--	DeactivateInterface(gameMode);
	DeactivateInterface(back2);
	--DeactivateInterface(records);
	DeactivateInterface(road_market_picture);
	DeactivateInterface(road_airplane_picture);
	--DeactivateInterface(single_champ_picture);
	DeactivateInterface(road_electro_picture);
	DeactivateInterface(road_olga_picture);
	DeactivateInterface(road_vampires_picture);
	DeactivateInterface(road_funnel_picture);
	DeactivateInterface(road_funnel_picture2);
	DeactivateInterface(road_funnel_picture3);
	DeactivateInterface(road_funnel_picture4);
	DeactivateInterface(road_funnel_picture5);
	DeactivateInterface(road_funnel_picture6);
	DeactivateInterface(road_funnel_picture7);
	DeactivateInterface(road_funnel_picture8);
	DeactivateInterface(road_funnel_picture9);
	DeactivateInterface(road_funnel_picture10);
	DeactivateInterface(road_funnel_picture11);
	--DeactivateInterface(player_defeat);
	--DeactivateInterface(loose_dw_picture);
	--DeactivateInterface(loose_nw_picture);
	--DeactivateInterface(player_win);
	DeactivateInterface(exit_int);
	--DeactivateInterface(credits);
	DeactivateInterface(lock);
	DeactivateInterface(lock2);
	DeactivateInterface(lock3);
	DeactivateInterface(lock3_5);
	DeactivateInterface(lock3_9);
	DeactivateInterface(lock3_13);
	DeactivateInterface(lock4);
	DeactivateInterface(lock5);
	--DeactivateInterface(left);
	--DeactivateInterface(right);
	DeactivateInterface(help);
end

local function DeactivateInterfaces1()
	for i =1, 36
	do
		DeactivateInterface(loading[i]);
	end
	DeactivateInterface(mainMenu); 
--	DeactivateInterface(menuName);
--	DeactivateInterface(video);
	DeactivateInterface(gameInterface);
--	DeactivateInterface(loading);
--	DeactivateInterface(team); 
--	DeactivateInterface(select);
--	DeactivateInterface(select_picture);
--	DeactivateInterface(testing);
--	DeactivateInterface(loadText); 
--	DeactivateInterface(loadChoice); 
	DeactivateInterface(loadChamp);
--	DeactivateInterface(loadSingle);
	DeactivateInterface(enterName);
	DeactivateInterface(continue);
	DeactivateInterface(options);
	DeactivateInterface(char); 
--	DeactivateInterface(movie); 
--	DeactivateInterface(movie_team); 
	DeactivateInterface(road); 
--	DeactivateInterface(continue_picture);
--	DeactivateInterface(team_picture);
	DeactivateInterface(char_alice_picture);
	DeactivateInterface(char_kostya_picture);
	DeactivateInterface(char_kostya_picture2);
	DeactivateInterface(char_kostya_picture3);
	DeactivateInterface(char_kostya_picture4);
	DeactivateInterface(char_kostya_picture5);
	DeactivateInterface(char_kostya_picture6);
	DeactivateInterface(char_kostya_picture7);
	DeactivateInterface(char_kostya_picture8);
	DeactivateInterface(char_denis_picture);
--	DeactivateInterface(char_simon_picture);
--	DeactivateInterface(char_ilya_picture);
--	DeactivateInterface(char_lena_picture);
	inMainMenu = false;
end

local function DeactivateInterfaces()
	DeactivateInterfaces1();
	DeactivateInterfaces2();
	DeactivateInterface(story1); 
	DeactivateInterface(story2); 
	DeactivateInterface(story3); 
	DeactivateInterface(story4); 
	DeactivateInterface(story5); 
	DeactivateInterface(publ);
	if (bLogo)
	then
		DeactivateInterface(logoa);
		DeactivateInterface(logona);
	end
	Update();
	Update();
end

local function FadeIn(time)
	local tm = 0;
	while(tm < time)
	do
		tm = tm + GetDeltaTime();
		SetFade((time - tm) / time);
		if (stopTimer)
		then
			ClearGlobalTimer();
		end
		Update();
	end
	SetFade(0.0);
end


local function FadeOut(time)
	local tm = 0;
	while(tm < time)
	do
		tm = tm + GetDeltaTime();
		SetFade(tm / time);
		if (stopTimer)
		then
			ClearGlobalTimer();
		end
		Update();
	end
	SetFade(1);
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

local function ReleaseAll1()
--	Release(loadText);
--	loadText = nil;
	Release(loadChamp);
	loadChamp = nil;
--	Release(loadSingle);
--	loadSingle = nil;
--	Release(menuName);
--	menuName = nil;
--	Release(loadChoice);
--	loadChoice = nil;
	Release(gameInterface);
	gameInterface = nil;	
	Release(enterName);
	enterName =nil;
	Release(continue);
	continue = nil;
	Release(options);
	options  = nil;
	Release(mainMenu); 
	mainMenu = nil; 
--	Release(team); 
--	team = nil; 
--	Release(select);
--	select = nil;
--	Release(testing);
--	testing = nil;
	Release(char); 
	char = nil; 
--	Release(backface); 
--	backface = nil; 
--	Release(movie); 
--	movie = nil;
--	Release(movie_team); 
--	movie_team = nil;
--	Release(video)
--	video = nil;
--	Release(player_defeat);
--	player_defeat = nil;
--	Release(loose_dw_picture)
--	loose_dw_picture = nil;
--	Release(loose_nw_picture)
--	loose_nw_picture = nil;
--	Release(player_win);
--	player_win = nil;
	Release(exit_int);
	exit_int = nil;
end

local function ReleaseAll()
	DeactivateInterfaces1();
--	for i = 1, 36
--	do
--		Release(loading[i]);
--		loading[i] = nil;
--	end
	ReleaseAll1();
--	loading = nil;
	Release(road);
	road = nil;
--	Release(continue_picture);
--	continue_picture = nil;
--	Release(team_picture);
--	team_picture = nil;
	Release(char_alice_picture);
		char_alice_picture = nil;
	Release(char_kostya_picture);
	char_kostya_picture = nil;
	Release(char_kostya_picture2);
	char_kostya_picture2 = nil;
	Release(char_kostya_picture3);
	char_kostya_picture3 = nil;
	Release(char_denis_picture);
	char_denis_picture = nil;
--	Release(char_simon_picture);
--	char_simon_picture = nil;
--	Release(char_ilya_picture);
--	char_ilya_picture = nil;
--	Release(char_lena_picture);
--	char_lena_picture = nil;
--	Release(select_picture);
--	select_picture = nil;
--	Release(gameMode);
--	gameMode = nil;
--	Release(single);
--	single = nil;
--	Release(records);
--	records = nil;
	Release(road_market_picture);
	road_market_picture = nil;
	Release(road_airplane_picture);
	road_airplane_picture = nil;
	Release(road_electro_picture);
	road_electro_picture = nil;
	Release(road_olga_picture);
	road_olga_picture = nil;
	Release(road_vampires_picture);
	road_vampires_picture = nil;
	Release(road_funnel_picture);
	road_funnel_picture = nil;
	Release(road_funnel_picture2);
	road_funnel_picture2 = nil;
	Release(road_funnel_picture3);
	road_funnel_picture3 = nil;
	Release(road_funnel_picture4);
	road_funnel_picture4 = nil;
	Release(road_funnel_picture5);
	road_funnel_picture5 = nil;
--	Release(single_champ_picture);
--	single_champ_picture = nil;
--	Release(credits);
--	credits = nil;
end

local function Mission()
	ple = false;
	plf = false;
	name = GetCurrentParams(script);
	if (name == "mission1")
	then 
		SetCurrentRace(1);
		current_mission = 1; 
		SetRoundTime(fRace1Time);
		SetMaxAbilityCount(nRace1AbCount);
	elseif (name == "mission2")
	then
		SetCurrentRace(2);
		current_mission = 2; 
		SetRoundTime(fRace2Time);
		SetMaxAbilityCount(nRace2AbCount);
	elseif (name == "mission3")
	then
		SetCurrentRace(3);
		current_mission = 3; 
		SetRoundTime(fRace3Time);
		SetMaxAbilityCount(nRace3AbCount);
	elseif(name == "mission4")
	then
		SetCurrentRace(4);
		current_mission = 4;
		SetRoundTime(fRace4Time);
		SetMaxAbilityCount(nRace4AbCount);
	elseif(name == "mission5")
	then
		SetCurrentRace(5);
		current_mission = 5;
		SetRoundTime(fRace5Time);
		SetMaxAbilityCount(nRace5AbCount);
	elseif(name == "mission6")
	then
		SetCurrentRace(6);
		current_mission = 6;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission7")
	then
		SetCurrentRace(7);
		current_mission = 7;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission8")
	then
		SetCurrentRace(8);
		current_mission = 8;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission9")
	then
		SetCurrentRace(9);
		current_mission = 9;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission10")
	then
		SetCurrentRace(10);
		current_mission = 10;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission11")
	then
		SetCurrentRace(11);
		current_mission = 11;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission12")
	then
		SetCurrentRace(12);
		current_mission = 12;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission13")
	then
		SetCurrentRace(13);
		current_mission = 13;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission14")
	then
		SetCurrentRace(14);
		current_mission = 14;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission15")
	then
		SetCurrentRace(15);
		current_mission = 15;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	elseif(name == "mission16")
	then
		SetCurrentRace(16);
		current_mission = 16;
		SetRoundTime(fRace6Time);
		SetMaxAbilityCount(nRace6AbCount);
	end
end

local function StartLuaLevel()
--	FadeIn(0.1);
--	StopVideo();
--	StopVideo1(); 
--	PlayMissionMovie();
	--DeactivateInterfaces();
	ple = false;
	plf = false;
	gameExitShow = false;
	bDefeat = false;
	DeactivateInterface(loadChoice);
--	DeactivateInterface(back);
	local car = GetPlayerName();
	local loadScreen = 0;
	if("zil_130_" == car) then
		loadScreen = current_mission;
	elseif("uaz" == car) then
		loadScreen = 6 + current_mission;
	elseif("gaz_3110_main" == car) then
		loadScreen = 12 + current_mission;
	elseif("audi_tt" == car) then
		loadScreen = 18 + current_mission;
	elseif("bmw" == car) then
		loadScreen = 24 + current_mission;
	elseif("volswagen_toureg" == car) then
		loadScreen = 30 + current_mission;
	end
	--ActivateInterface(loading[loadScreen]);
--	ActivateInterface(loadText);
	ClearGlobalTimer();
	Update();
	--FadeOut(0.1);
	ClearGlobalTimer();
	Update();
	local lvl = "level"..current_mission;
	ClearGameData();
	InitLevel(lvl, bSingle);
	if (current_mission == 2 or current_mission == 3 or current_mission == 5 or current_mission == 6 or current_mission == 7 or current_mission == 9 or current_mission == 14)
	then
		SetReversed(true);

	end
	LockPlayers(true);
--	DeactivateInterfaces();
	--ActivateInterface(loading[loadScreen]);
	ClearGlobalTimer();
	Update();
	ClearGlobalTimer();
	Update();
--	StopVideo();
--	StopVideo1();
	if(bNewGame)
	then
		SaveGame();
		bNewGame = false;
	end
	StartLevel();
	
	local num = GetCurrentMission();
	local num2 = 1;
		if (num == 3)
	then
		num2 = 3;
		SetPlaceToFinish(1);
	elseif (num == 5)
	then
		num2 = 5;
		SetPlaceToFinish(2);
	elseif (num == 4)
	then
		num2 = 4;
		SetPlaceToFinish(2);
	elseif (num == 6)
	then
		num2 = 6;
		SetPlaceToFinish(1);
	elseif (num == 7)
	then
		num2 = 7;
		SetPlaceToFinish(1);
	elseif (num == 8)
	then
		num2 = 8;
		SetPlaceToFinish(1);
	elseif (num == 2)
	then
		num2 = 2;
		SetPlaceToFinish(0);
	elseif (num == 9)
	then
		num2 = 9;
		SetPlaceToFinish(0);
	elseif (num == 1)
	then
		SetPlaceToFinish(0);
		num2 = 1;
	elseif (num == 10)
	then
		SetPlaceToFinish(0);
		num2 = 10;
	end
	
--	SaveLog("startlevel");
--	Update();
--	SaveLog("sendcommand");
--	SaveActions("Actions.cfg");
	isInGame = true;
	stopTimer = false;
	FadeIn(0.1);
	Update();
	DeactivateInterfaces();
	DeactivateInterface(back);
	ActivateInterface(gameInterface);
	FadeOut(0.5);
	SendCommandByName("gamemenu", "update_game_interface", "");
	SendCommandByName("level"..current_mission, "start_signals", "");
	game_finish = false;
--	SaveLog("startlualevel");
end

local function StartGame()
	--Mission(); 
	SetCurrentMission(current_mission);
	gamefailed = false;
	playerdead = false;
	isInGame = true; 
	--FadeIn(0.1);
	ClearGlobalTimer();
	Update();
	stopTimer = true;
	--DeactivateInterfaces();
--	FadeOut(0.1);
end

--local function StartOptions()
--	gamefailed = false;
--	playerdead = false;
--	FadeIn(1);
--	ClearGlobalTimer();
--	Update();
--	stopTimer = true;
--	DeactivateInterfaces();
--	ActivateInterface(main_back);
--	ActivateInterface(options);
--	if (GetMusicName() ~= "GoodWater.mp3")
--	then
--		PlayMusic("GoodWater.mp3");
--	end
--	FadeOut(0.1);
--end

--local function StartSave()
--	gamefailed = false;
--	playerdead = false;
--	FadeIn(1);
--	ClearGlobalTimer();
--	Update();
--	stopTimer = true;
--	DeactivateInterfaces();
--	ActivateInterface(backs[current_mission]);
--	ActivateInterface(save);
--	if (GetMusicName() ~= "GoodWater.mp3")
--	then
--		PlayMusic("GoodWater.mp3");
--	end
--	FadeOut(0.1);
--end

local function PlayMissionMovie()

--~ 	FadeIn(0.1);
--~ 	StopVideo();
--~ --	StopVideo1();
--~ 	
--~ 	DeactivateInterfaces();
--~ 	ActivateInterface(video);
--~ 	ExecuteCommands();

--~ 	PlayVideo(mission_video[current_mission], false);
--~ 	FadeOut(0.1);
--~ 	
--~ 	Update();
--~ 	isVideoPlaying = true;
--~ 	Update();

--~ 	while(isVideoPlaying)
--~ 	do
--~ 		ExecuteCommands();
--~ 		Update();
--~ 	end
--~ 	
--~ 	--FadeIn(0.1);
--~ 	StopVideo();
--~ 	FadeIn(0.1);
--~ 	--FadeOut(0.1);
--~ 	
--~ 	isVideoPlaying = true;
end

local function PlayBackface()
 	SilentActivateInterface(back);
--~ 	ExecuteCommands();
--~ 	--PlayVideo("spline_.avi", true);	
--~ 	StopVideo();
--~ 	Update();
--~ 	PlayVideo("spline"..GetCurrentResolution()..".avi", true);
--~ 	Update();
end

local function PlayBackface2()
 	SilentActivateInterface(back);
--~ 	ExecuteCommands();
--~ 	StopVideo();
--~ 	Update();
--~ 	PlayVideo("spline_only.avi", true);
--~ 	Update();
end

local function PlayMovie()
	--SilentActivateInterface(movie);
	--ExecuteCommands();
	--PlayVideo1("intro.avi");	
	--Update();
end

local cur_movie = "MSU_cycle.avi"; 

local function PlayMovieTeam()
--	name = GetCurrentParams(script);
--	if (name == "simon_movie")
--	then
--		cur_movie = "zil_cycle.avi"; 
--	elseif (name == "ilya_movie")
--	then	
--		cur_movie = "uaz_cycle.avi"; 
--	elseif (name == "lena_movie")
--	then
--		cur_movie = "volga_cycle.avi"; 
--	elseif (name == "alice_movie")
--	then
--		cur_movie = "audi_cycle.avi"; 
--	elseif (name == "denis_movie")
--	then
--		cur_movie = "bmw_cycle.avi"; 
--	elseif (name == "kostya_movie")
--	then	
--		cur_movie = "toureg_cycle.avi"; 
--	elseif (name == "road1_movie")
--	then 
--		cur_movie = "CB_cycle.avi"; 
--		
--	elseif (name == "road2_movie")
--	then 
--		cur_movie = "MSU_cycle.avi"; 
--	end 
--	ActivateInterface(movie_team);
--	ExecuteCommands();
--	PlayVideo1(cur_movie);	
--	Update();
end

local function StartTeam()
	cur_movie = "MSU_cycle.avi"; 
	FadeIn(0.1);
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	ActivateInterface(team);
--	SilentActivateInterface(menuName);
--	SilentActivateInterface(team_picture);
	SendCommandByName("menuname", "select_team", "");
	--PlayMovieTeam(); 
	FadeOut(0.1);
end

local function StartSelect()
	FadeIn(0.1);
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	ActivateInterface(select);
--	SilentActivateInterface(menuName);
--	SilentActivateInterface(select_picture);
	SendCommandByName("menuname", "select", "");
	FadeOut(0.1);
end

local function StartTesting()
	FadeIn(0.1);
	PlayBackface2();
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	ActivateInterface(testing);
--	SilentActivateInterface(menuName);
	SendCommandByName("menuname", "who", "");
	FadeOut(0.1);
end

local function StartName()
	FadeIn(0.1);
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	DeactivateInterface(back);
	ActivateInterface(back2);
	ActivateInterface(enterName);
--	SilentActivateInterface(menuName);
--	SilentActivateInterface(continue_picture);
	SendCommandByName("menuname", "newgame", "");
	SetCurrentRace(1);
	FadeOut(0.1);
end

local function StartMainMenu()
	--if (isInGame)
	--then
	FadeIn(0.1);
	DeactivateInterface(back2); 
		PlayBackface(); 
	--end
	isInGame = false; 
	DeactivateInterface(gameInterface); 
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	ActivateInterface(mainMenu);
	if (bLogo)
	then
		ActivateInterface(logoa);
		ActivateInterface(logona);
	end
	if(bNewGame)
	then
		SendCommandByName("mainmenu", "set_new_game", "true");
	else
		SendCommandByName("mainmenu", "set_new_game", "false");
	end
	--PlayMovie(); 
	FadeOut(0.1);
end

local function StartChar()
	local name = GetCurrentParams(script);
	FadeIn(0.1);
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	DeactivateInterface(back);
--	ActivateInterface(back2);
	ActivateInterface(char);
	Update();
	ExecuteCommands();
	Update();
	
--~ 	if (name == "day")
--~ 	then 
--~ 		strTeam = name;
--~ 		SilentActivateInterface(char_alice_picture);
--~ 		SendCommandByName("char", "dozor", "day_dozor"); 
--~ 		--SendCommandByName("main", "movie_team", "alice_movie"); 
--~ 	elseif (name == "night") 
--~ 	then
--~ 		strTeam = name;
--~ 		SilentActivateInterface(char_simon_picture);
--~ 		SendCommandByName("char", "dozor", "night_dozor"); 
--~ 		--SendCommandByName("main", "movie_team", "simon_movie");
--~ 	else
--~ 		if("day" == strTeam)
--~ 		then
--~ 			SilentActivateInterface(char_alice_picture);
--~ 			SendCommandByName("char", "dozor", "day_dozor"); 
--~ 		elseif("night" == strTeam) 
--~ 		then
--~ 			SilentActivateInterface(char_simon_picture);
--~ 			SendCommandByName("char", "dozor", "night_dozor"); 
--~ 		else
--~ 			SilentActivateInterface(char_simon_picture);
--~ 			SendCommandByName("char", "dozor", "night_dozor"); 			
--~ 		end
--~ 	end
--	SilentActivateInterface(menuName);
	SendCommandByName("menuname", "select_char", "");
	FadeOut(0.1);
end

local function StartContinue()
	local name = GetCurrentParams(script);
	FadeIn(0.1);
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	DeactivateInterface(back);
	ActivateInterface(back2);
	ActivateInterface(continue);
--	SilentActivateInterface(menuName);
--	SilentActivateInterface(continue_picture);
	SendCommandByName("menuname", "continue", "");
	FadeOut(0.1);
end

local function StartOptions()
	FadeIn(0.1);
	PlayBackface2();
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	DeactivateInterface(back);
	ActivateInterface(back2);
	ActivateInterface(options);
--	SilentActivateInterface(menuName);
	SendCommandByName("menuname", "options", "");
	FadeOut(0.1);
end



local function Help()
	FadeIn(0.1);
	PlayBackface();
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	DeactivateInterface(back);
	ActivateInterface(back2);
	ActivateInterface(help);
--	ActivateInterface(menuName);
--	ActivateInterface(road_market_picture);
	--SendCommandByName("menuname", "road",  "");
	FadeOut(0.1);
end 

local function StopLuaLevel()
	FadeIn(0.5);
	
	isInGame = false;
	bDefeat = false;
	StopLevel();
	Update();
	--FadeOut(0.1);
	--StartRoad();
	ClearGlobalTimer();
	--Update();
	DeactivateInterfaces();
	
	SilentActivateInterface(back);
	--ExecuteCommands();
	--PlayVideo("spline_.avi", true);	
	DeleteLevel();
--	StopVideo();
--	Update();
--	PlayVideo("spline"..GetCurrentResolution()..".avi", true);
	PlayBackface();
 
	
	ActivateInterface(road);
--	ActivateInterface(menuName);
	ActivateInterface(road_market_picture);
	SendCommandByName("menuname", "road",  "");
	if(bSingle)
	then
		SendCommandByName("road", "next", "single");
	end
	FadeOut(0.5);
	Update();
end

local function StartGameMode()
	local name = GetCurrentParams(script);
	FadeIn(0.1);
	PlayBackface();
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
--	ActivateInterface(gameMode);
--	SilentActivateInterface(single_champ_picture);
--	SilentActivateInterface(menuName);
	if(bGameLoaded and not bNewGame)
	then
		SendCommandByName("gamemode", "back", "continue");
	end
	SendCommandByName("menuname", "game_mode", "");
	FadeOut(0.1);
end

local function StartSingle()
	FadeIn(0.1);
	ClearGlobalTimer();
	PlayBackface();
	Update();
	DeactivateInterfaces();
	ActivateInterface(single);
--	SilentActivateInterface(single_champ_picture);
--	SilentActivateInterface(menuName);
	SendCommandByName("menuname", "single", "");
	FadeOut(0.1);
end

local function StartRecords()
	local mode = GetCurrentParams(script);
	FadeIn(0.1);
--	StopVideo();
	PlayBackface2();
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	ActivateInterface(records);
	SendCommandByName("records", "game_mode", mode);
--	SilentActivateInterface(menuName);
	SendCommandByName("menuname", "records", "");
	FadeOut(0.1);
end

local function GetRealRacesPassed()
	local num = 1;
	if (GetNumRacesPassed() == 1)
	then
		num = 3;
	elseif (GetNumRacesPassed() == 2)
	then
		num = 5;
	elseif (GetNumRacesPassed() == 3)
	then
		num = 4;
	elseif (GetNumRacesPassed() == 4)
	then
		num = 6;
	elseif (GetNumRacesPassed() == 5)
	then
		num = 7;
	elseif (GetNumRacesPassed() == 6)
	then
		num = 8;
	elseif (GetNumRacesPassed() == 7)
	then
		num = 2;
	elseif (GetNumRacesPassed() == 8)
	then
		num = 9;
	elseif (GetNumRacesPassed() == 9)
	then
		num = 1;
	elseif (GetNumRacesPassed() == 10)
	then
		num = 10;
	end

	return num;
end



--local function LoadLevel()
--	StartGame();

--	StopVideo1(); 
--	DeactivateInterfaces();
--	DeactivateInterface(backface); 
--	local car = GetPlayerName();
--	local loadScreen = 0;
--	if("zil_130_" == car) then
--		loadScreen = current_mission;
--	elseif("uaz" == car) then
--		loadScreen = 6 + current_mission;
--	elseif("gaz_3110_main" == car) then
--		loadScreen = 12 + current_mission;
--	elseif("audi_tt" == car) then
--		loadScreen = 18 + current_mission;
--	elseif("bmw" == car) then
--		loadScreen = 24 + current_mission;
--	elseif("volswagen_toureg" == car) then
--		loadScreen = 30 + current_mission;
--	end
--	ActivateInterface(loading[loadScreen]);
--	ActivateInterface(loadText);
--	ClearGlobalTimer();
--	Update();
--	FadeOut(0.1);
--	ClearGlobalTimer();
--	Update();
--	local lvl = "level"..current_mission;
--	InitLevel(lvl);
--	--DeactivateInterfaces();
--	DeactivateInterface(loadText);
--	--ActivateInterface(loading[loadScreen]);
--	ActivateInterface(loadPlay);
--end

--local function PlayerDead()
--	SaveLog("playerdead");
--	if (not playerdead)	
--	then
--		playerdead = true;
--		gameovertime = 0;
--	end
--end

--local function LevelFailed()
--	SaveLog("levelfailed");
--	if (not gamefailed)
--	then
--		SetMoney(money_count);
--		isInGame = false;
--		FadeIn(1);
--		ClearGlobalTimer();
--		Update();
--		DeactivateInterfaces();
--		ActivateInterface(crashes[current_mission]);
--		StopLevel();
--		StopSounds();
--		Update();
--		stopTimer = false;
--		FadeOut(0.1);
--		Update();
--		gamefailed = true;
--		gameovertime = 0;
--		PlayMusicNoLoop("gameover.mp3");
--		Update();
--		SetCurrentMission(1);
--		current_mission = GetCurrentMission();
--		--SetMoney(30000);
--		InitPlayer();
--	end
--end

--local function PlayFinal()
--	FadeIn(0.1);
--	PlayMusic("");
--	DeactivateInterfaces();
--	ActivateInterface(video);
--	ExecuteCommands();
--	PlayVideo("final.avi");	
--	Update();
--	FadeOut(0.1);
--	isVideoPlaying = true;
--	Update();
--	
--	while(isVideoPlaying)
--	do
--		ExecuteCommands();
--		Update();
--	end
--	
--	isVideoPlaying = true;
--	FadeIn(0.1);
--	StopVideo();
--	DeactivateInterfaces();
--	ActivateInterface(main_back);
--	ActivateInterface(main_menu);
--	if (GetMusicName() ~= "GoodWater.mp3")
--	then
--		PlayMusic("GoodWater.mp3");
--	end
--	FadeOut(0.1);
--	inMainMenu = true;
--	SetCurrentMission(1);
--	current_mission = GetCurrentMission();
--	SetMoney(0);
--	InitPlayer();
--end

--local function LevelCompleted()
--	if (not gamefailed)
--	then
--		isInGame = false;
--		StopSounds();
--		
--		SetCurrentMission(GetCurrentMission() + 1);
--		
---		local mn = GetCurrentMission();
--		
--		current_mission = GetCurrentMission();
--		gamefailed = false;
--		playerdead = false;
--		FadeIn(1);
--		ClearGlobalTimer();
--		Update();
--		stopTimer = true;
--		DeactivateInterfaces();
--		StopLevel();
--		DeleteLevel();
		
--		if (mn ~= 16)
--		then
--			ActivateInterface(backs[current_mission - 1]);
--			ActivateInterface(mission_result);
--			FadeOut(0.1);
--		else
--			PlayFinal();
--		end
--		if  (current_mission < 14)
--		then
--			SaveGame("save13.sav");
--		end
--	end
--end

--local function StartNextLevel()
--	isInGame = false;
--	FadeIn(1);
--	DeactivateInterface(mission_result);
---	ClearGlobalTimer();
--	Update();
--	stopTimer = true;
--	DeactivateInterfaces();
--	ActivateInterface(backs[GetCurrentMission()]);
--	ActivateInterface(inter_mission);
--	FadeOut(0.1);
--	SaveGame("save13.sav");
--end

local function VideoEnd()
	isVideoPlaying = false;
	timeBetween = 0;
end

local function AnyKey()
--	local key, pos = GetCurrentParams(script);
--	if (pos == "0")
--	then
		isVideoPlaying = false;
		timeBetween = 0;
--	end
end

local function ExitInterface()
--	timetemp = 1.0;
--	camera = false;
	DeactivateInterface(exit_int);
--	SetTemp(timetemp);
--	SetCamera(camera);
	gameExitShow = false;
end


local function KeyAction()
	local key, pos = GetCurrentParams(script);
--~ 	if (isInGame and key == "esc")
--~ 	then
--~ 		StopLevel();
--~ 		StopSounds();
--~ 		StartMainMenu(); 
--~ 	end
--~ 	if(isInGame and key == "dump" and pos == "0")
--~ 	then
--~ 		DumpAIInfo();
--~ 	end
	if (not isInGame)
	then
		return;
	end
	if (key == "jump")
	then
		if (pos == "1")
		then
			PlayerApplyImpulse(0, 0, 100);
		end
	elseif (key == "nitro")
	then
		if (pos == "1")
		then
			PlayerNitro(1);
		elseif (pos == "0")
		then
			PlayerNitro(0);
		end
	elseif (key == "timep")
	then
		if (pos == "1")
		then
			timetemp = timetemp + 0.01;
			if (timetemp > 1)
			then
				timetemp = 1;
			end
			SetTemp(timetemp);
		end
	elseif (key == "timem")
	then
		if (pos == "1")
		then
			timetemp = timetemp - 0.01;
			if (timetemp < 0)
			then
				timetemp = 0;
			end
			SetTemp(timetemp);
		end
	elseif (key == "esc")
	then
		if (pos == "0")
		then
		
			if (gameExitShow)
			then
				timetemp = 1;
				camera = false;
				DeactivateInterface(exit_int);
--				DeactivateInterface(gray);
				gameExitShow = false;
				SetTemp(timetemp);
				SetCamera(camera);
			else
				timetemp = 0.0;
				camera = true;
				ActivateInterface(exit_int);
--				SilentActivateInterface(gray);
				gameExitShow = true;
				SetTemp(timetemp);
				SetCamera(camera);
			end
		
--~ 			if (not camera)
--~ 			then
--~ 				
--~ 				ActivateInterface(exit_int);
--~ 			else
--~ 				
--~ 				DeactivateInterface(exit_int);
--~ 			end
			
		end
--~ 	elseif (key == "camera")
--~  	then
--~  		if (pos == "1")
--~  		then
--~  			if (camera == true)
--~  			then
--~ 				camera = false;
--~ 				SetTemp(1);
--~  			else
--~ 				camera = true;
--~ 				SetTemp(0);
--~  			end
--~ 			SetCamera(camera);
--~  		end
	elseif (key == "player")
 	then
 		if (pos == "1")
 		then
 			if (plr == true)
 			then
				plr = false;
 			else
				plr = true;
 			end
			SetCameraPlayer(plr);
 		end
	end
end

local function LPlayVideo(file)
--~ 	ActivateInterface(video);
--~ 	ExecuteCommands();
--~ 	FadeOut(0.1);
--~ 	isVideoPlaying = true;
--~ 	Update();
--~ 	
--~ 	PlayVideo(file);
--~ 	
--~ 	while(isVideoPlaying)
--~ 	do
--~ 		ExecuteCommands();
--~ 		Update();
--~ 	end
--~ 	
--~ 	isVideoPlaying = true;
--~ 	FadeIn(0.1);
--~ 	StopVideo();
end

--local function PlayCredits()
--	FadeIn(0.1);
--	PlayMusic("");
--	DeactivateInterfaces();
--	ActivateInterface(video);
--	ExecuteCommands();
--	PlayVideo("credits.avi");	
--	Update();
--	FadeOut(0.1);
--	isVideoPlaying = true;
--	Update();
--	
--	while(isVideoPlaying)
--	do
--		ExecuteCommands();
--		Update();
--	end
	
--	isVideoPlaying = true;
--	FadeIn(0.1);
--	StopVideo();
--	DeactivateInterfaces();
--	ActivateInterface(main_back);
--	ActivateInterface(main_menu);
--	if (GetMusicName() ~= "GoodWater.mp3")
--	then
--		PlayMusic("GoodWater.mp3");
--	end
--	FadeOut(0.1);
--end

--local function PlayIntro()
--	FadeIn(0.1);
--	PlayMusic("");
--	DeactivateInterfaces();
--	ActivateInterface(video);
--	ExecuteCommands();
--	PlayVideo("intro_eng.avi");	
--	Update();
--	FadeOut(0.1);
--	isVideoPlaying = true;
--	Update();
	
--	while(isVideoPlaying)
--	do
--		ExecuteCommands();
--		Update();
--	end
	
--	isVideoPlaying = true;
--	FadeIn(0.1);
--	StopVideo();
--	DeactivateInterfaces();
--	ActivateInterface(main_back);
--	ActivateInterface(main_menu);
--	if (GetMusicName() ~= "GoodWater.mp3")
--	then
--		PlayMusic("GoodWater.mp3");
--	end
--	FadeOut(0.1);
--	inMainMenu = true;
--end

local function Level()
--	DeactivateInterfaces(); 
	--ActivateInterface(gameInterface);
	StartGame();
--	PlayMusicNoLoop("level"..current_mission..".mp3");
	if (current_mission == 1 or current_mission == 5 or current_mission == 9 or current_mission == 13)
	then
		PlayMusic("level1.mp3");
	elseif (current_mission == 2 or current_mission == 6 or current_mission == 10 or current_mission == 14)
	then
		PlayMusic("level2.mp3");
	elseif (current_mission == 3 or current_mission == 7 or current_mission == 11 or current_mission == 15)
	then
		PlayMusic("level3.mp3");
	elseif (current_mission == 4 or current_mission == 8 or current_mission == 12 or current_mission == 16)
	then
		PlayMusic("level4.mp3");
	end
	StartLuaLevel();
end

local function StopMusic()
	local name = GetCurrentParams(script);
--~ 	if (name == "level1.mp3")
--~ 	then
--~ 		PlayMusicNoLoop("level2.mp3");
--~ 	elseif (name == "level2.mp3")
--~ 	then
--~ 		PlayMusicNoLoop("level3.mp3");
--~ 	elseif (name == "level3.mp3")
--~ 	then
--~ 		PlayMusicNoLoop("level4.mp3");
--~ 	elseif (name == "level4.mp3")
--~ 	then
--~ 		PlayMusicNoLoop("level5.mp3");
--~ 	elseif (name == "level5.mp3")
--~ 	then
--~ 		PlayMusicNoLoop("level6.mp3");
--~ 	elseif (name == "level6.mp3")
--~ 	then
--~ 		PlayMusicNoLoop("level1.mp3");
--~ 	end
end


local function PlayerDefeat()
	if (not game_finish)
	then
		FadeIn(0.5);
--		PlayMusic("menu.mp3");
		if(bSingle)
		then
			if(not bDefeat)
			then
				
				bDefeat = true;
				
				ClearGameData();
				
				isInGame = false;
				StopLevel();
				
				ClearGlobalTimer();
				StopVideo();
				StopVideo1();
				Update();
				DeactivateInterfaces();
				
				local acar = GetActiveCar();
				if("audi_tt" == acar or "bmw_i745" == acar or "volk_t" == acar)
				then
					ActivateInterface(loose_dw_picture);
				elseif("gaz_z110" == acar or "uaz_469" == acar or "zil_130" == acar)
				then
					ActivateInterface(loose_nw_picture);
				end
				
				DeleteLevel();
				ActivateInterface(player_defeat);
				
				SendCommandByName("defeat", "set_single", tostring(current_mission));
				
			end
		else
			if(not bDefeat)
			then
				
				bDefeat = true;
				
				ClearGameData();
				
				isInGame = false;
				StopLevel();
				
				ClearGlobalTimer();
				--StopVideo();
				StopVideo();
				StopVideo1();
				Update();
				DeactivateInterfaces();
				
				local acar = GetActiveCar();
				if("audi_tt" == acar or "bmw_i745" == acar or "volk_t" == acar)
				then
					ActivateInterface(loose_dw_picture);
				elseif("gaz_z110" == acar or "uaz_469" == acar or "zil_130" == acar)
				then
					ActivateInterface(loose_nw_picture);
				end
				
				DeleteLevel();
				ActivateInterface(player_defeat);
				
			end
		end
		FadeOut(0.5);
		Update();
	end
end

local function StartCredits()
 	FadeIn(0.1);
--~ 	StopPlayingMusic();
--~ 	DeactivateInterfaces();
--~ 	ActivateInterface(video);
--~ 	ExecuteCommands();
--~ 	StopVideo();
--~ 	Update();
--~ 	PlayVideo("credits.avi");	
--~ 	Update();
--~ 	FadeOut(0.1);
--~ 	isVideoPlaying = true;
--~ 	Update();
--~ 	
--~ 	while(isVideoPlaying)
--~ 	do
--~ 		ExecuteCommands();
--~ 		Update();
--~ 	end
--~ 	
--~ 	isVideoPlaying = true;
--~ 	FadeIn(0.1);
--~ 	StopVideo();
--~ 	Update();
--~ 	DeactivateInterfaces();
--~ 	PlayBackface();
--~ 	ActivateInterface(mainMenu);
--~ --	PlayMusic("menu.mp3");
--~ 	FadeOut(0.1);
end







local function Left()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(left);
	else
		DeactivateInterface(left);
	end
end

local function Right()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(right);
	else
		DeactivateInterface(right);
	end
end
	
	
local function Lock()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(lock);
	else
		DeactivateInterface(lock);
	end
end
local function Lock2()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(lock2);
	else
		DeactivateInterface(lock2);
	end
end
local function Lock3()
	local show = GetCurrentParams(script);
	if (show == "false")
	then
		DeactivateInterface(lock3);
	else
		SilentActivateInterface(lock3);
		SendCommandByName("lock3", "set_text", show);
	end
end
local function Lock3_5()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(lock3_5);
	else
		DeactivateInterface(lock3_5);
	end
end
local function Lock3_9()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(lock3_9);
	else
		DeactivateInterface(lock3_9);
	end
end
local function Lock3_13()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(lock3_13);
	else
		DeactivateInterface(lock3_13);
	end
end
local function Lock4()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(lock4);
	else
		DeactivateInterface(lock4);
	end
end

local function Lock5()
	local show = GetCurrentParams(script);
	if (show == "true")
	then
		SilentActivateInterface(lock5);
	else
		DeactivateInterface(lock5);
	end
end

local function CharPictureSub(char)
	if("alice" == char)
	then
		DeactivateInterface(char_kostya_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture3);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture7);
		DeactivateInterface(char_kostya_picture8);
		
		DeactivateInterface(char_denis_picture);
		
		SilentActivateInterface(char_alice_picture);
	elseif("denis" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_kostya_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture3);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture7);
		DeactivateInterface(char_kostya_picture8);
		
		
		SilentActivateInterface(char_denis_picture);
	elseif("kostya" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_denis_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture3);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture7);
		DeactivateInterface(char_kostya_picture8);
		
		
		SilentActivateInterface(char_kostya_picture);
	elseif("kostya2" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_denis_picture);
		DeactivateInterface(char_kostya_picture);
		DeactivateInterface(char_kostya_picture3);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture7);
		DeactivateInterface(char_kostya_picture8);
		
		
		SilentActivateInterface(char_kostya_picture2);
	elseif("kostya3" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_denis_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture7);
		DeactivateInterface(char_kostya_picture8);
		
		
		SilentActivateInterface(char_kostya_picture3);
	elseif("kostya4" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_denis_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture);
		
		DeactivateInterface(char_kostya_picture3);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture7);
		DeactivateInterface(char_kostya_picture8);
		
		
		SilentActivateInterface(char_kostya_picture4);
	elseif("kostya5" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_denis_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture3);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture7);
		DeactivateInterface(char_kostya_picture8);
		
		
		SilentActivateInterface(char_kostya_picture5);
	elseif("kostya6" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_denis_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture3);
		DeactivateInterface(char_kostya_picture7);
		DeactivateInterface(char_kostya_picture8);
		
		
		SilentActivateInterface(char_kostya_picture6);
	elseif("kostya7" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_denis_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture3);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture8);
		
		
		SilentActivateInterface(char_kostya_picture7);
	elseif("kostya8" == char)
	then
		DeactivateInterface(char_alice_picture);
		DeactivateInterface(char_denis_picture);
		DeactivateInterface(char_kostya_picture2);
		DeactivateInterface(char_kostya_picture);
		
		DeactivateInterface(char_kostya_picture4);
		DeactivateInterface(char_kostya_picture5);
		DeactivateInterface(char_kostya_picture3);
		DeactivateInterface(char_kostya_picture6);
		DeactivateInterface(char_kostya_picture7);
		
		
		SilentActivateInterface(char_kostya_picture8);
	end
end

local function CharPicture()
	local char = GetCurrentParams(script);
	CharPictureSub(char);
end

local function RoadPictureSub(road)
	if("market" == road)
	then
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_market_picture);
	elseif("airplane" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_airplane_picture);
	elseif("electro" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_electro_picture);
	elseif("olga" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_olga_picture);
	elseif("vampires" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_vampires_picture);
	elseif("funnel" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture);
	elseif("funnel2" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture2);
	elseif("funnel3" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture3);
	elseif("funnel4" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture4);
	elseif("funnel5" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture5);
	elseif("funnel6" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture6);
	elseif("funnel7" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture7);
	elseif("funnel8" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture8);
	elseif("funnel9" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture10);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture9);
	elseif("funnel10" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture11);
		
		SilentActivateInterface(road_funnel_picture10);
	elseif("funnel11" == road)
	then
		DeactivateInterface(road_market_picture);
		DeactivateInterface(road_airplane_picture);
		DeactivateInterface(road_electro_picture);
		DeactivateInterface(road_olga_picture);
		DeactivateInterface(road_vampires_picture);
		DeactivateInterface(road_funnel_picture2);
		DeactivateInterface(road_funnel_picture3);
		DeactivateInterface(road_funnel_picture4);
		DeactivateInterface(road_funnel_picture);
		DeactivateInterface(road_funnel_picture6);
		DeactivateInterface(road_funnel_picture7);
		DeactivateInterface(road_funnel_picture8);
		DeactivateInterface(road_funnel_picture9);
		DeactivateInterface(road_funnel_picture5);
		DeactivateInterface(road_funnel_picture10);
		
		SilentActivateInterface(road_funnel_picture11);
	end

end

local function RoadPicture()
	local road = GetCurrentParams(script);
	
	RoadPictureSub(road);
end

local function GameFinish()
	game_finish = true;
end




local function SetRoadPicture()
	local num = GetCurrentRace();
	if (num == 1)
	then
		RoadPictureSub( "market");
	elseif (num == 2)
	then
		RoadPictureSub( "airplane");
	elseif (num == 3)
	then
		RoadPictureSub(  "electro");
	elseif (num == 4)
	then
		RoadPictureSub(  "olga");
	elseif (num == 5)
	then
		RoadPictureSub(  "vampires");
	elseif (num == 6)
	then
		RoadPictureSub( "funnel");
	elseif (num == 7)
	then
		RoadPictureSub(  "funnel2");
	elseif (num == 8)
	then
		RoadPictureSub( "funnel3");
	elseif (num == 9)
	then
		RoadPictureSub( "funnel4");
	elseif (num == 10)
	then
		RoadPictureSub( "funnel5");
	elseif (num == 11)
	then
		RoadPictureSub( "funnel6");
	elseif (num == 12)
	then
		RoadPictureSub( "funnel7");
	elseif (num == 13)
	then
		RoadPictureSub( "funnel8");
	elseif (num == 14)
	then
		RoadPictureSub( "funnel9");
	elseif (num == 15)
	then
		RoadPictureSub( "funnel10");
	elseif (num == 16)
	then
		RoadPictureSub( "funnel11");
	end

end

local function PlayerExit()
	if (not ple)
	then
	ple = true;
	FadeIn(0.5);
	PlayMusic("menu.mp3");
	Update();
	
	isInGame = false;
	
	StopLevel();
	ClearGameData();
--	StopVideo();
--	StopVideo1();
	
	Update();
	ClearGlobalTimer();
	DeactivateInterfaces();
	
	SilentActivateInterface(back);
	--StopVideo();
--	PlayVideo("spline_only.avi", true);
	PlayBackface();
	DeleteLevel();
	DeactivateInterfaces();
	ActivateInterface(road);
	SetRoadPicture();
	
--	SilentActivateInterface(single_champ_picture);
--	SilentActivateInterface(menuName);
--~ 	if(bGameLoaded and not bNewGame)
--~ 	then
--~ 		SendCommandByName("gamemode", "back", "continue");
--~ 	end
--	SendCommandByName("menuname", "game_mode", "");
	
	FadeOut(0.1);
--	Update();
	end
end

local function LoadChoice()
	--FadeIn(1);
	
	--StopVideo1();
	
	if(not bSingle)
	then
	--	PlayMissionMovie();
	end
	
	--FadeIn(1);
	
	--FadeOut(0.1);
		
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	local car = GetPlayerName();
	local loadScreen = 0;
	if("zil_130_" == car) then
		loadScreen = current_mission;
	elseif("uaz" == car) then
		loadScreen = 6 + current_mission;
	elseif("gaz_3110_main" == car) then
		loadScreen = 12 + current_mission;
	elseif("audi_tt" == car) then
		loadScreen = 18 + current_mission;
	elseif("bmw" == car) then
		loadScreen = 24 + current_mission;
	elseif("volswagen_toureg" == car) then
		loadScreen = 30 + current_mission;
	end
--	ActivateInterface(loading[loadScreen]);
--	ActivateInterface(loadChoice);
	if(bSingle)
	then
	SilentActivateInterface(back);
		ActivateInterface(loadChamp);
		SetRoadPicture();
			SetLevelTransportCount(3);
			SetNumRounds(3);
	else
--	SendCommandByName("main", "mission", "mission" .. GetRealRacesPassed());
			SetLevelTransportCount(3);
			SetNumRounds(3);
	Update();
	SilentActivateInterface(back);
		ActivateInterface(loadChamp);
		SetRoadPicture();
	
--		if (GetNumRacesPassed() == 1)
--		then
--			SetLevelTransportCount(3);
--			SetNumRounds(3);
--		elseif (GetNumRacesPassed() == 2)
--		then
--			SetLevelTransportCount(3);
--			SetNumRounds(3);
--		elseif (GetNumRacesPassed() == 3)
--		then
--			SetLevelTransportCount(3);
--			SetNumRounds(3);
--		elseif (GetNumRacesPassed() == 4)
--		then
--			SetLevelTransportCount(3);
--			SetNumRounds(3);
--		elseif (GetNumRacesPassed() == 5)
--		then
--			SetLevelTransportCount(3);
--			SetNumRounds(3);
--		elseif (GetNumRacesPassed() == 6)
--		then
--			SetLevelTransportCount(3);
--			SetNumRounds(3);
--		end
	end
	SetLevelTransportCount(0);
		SendCommandByName("main", "level", "");
	FadeOut(0.1);
end


local function StartRoad()
	local name = GetCurrentParams(script);
	FadeIn(0.1);
	PlayBackface();
	ClearGlobalTimer();
	Update();
	DeactivateInterfaces();
	DeactivateInterface(back);
--	ActivateInterface(back2);
	if (GetCurrentMission() > GetNumRacesPassed())
 	then
		SetCurrentMission(1);
		SetCurrentRace(1);
		current_mission = 1;
 	end
	ActivateInterface(road);
	SetRoadPicture();
--	ActivateInterface(menuName);
--	ActivateInterface(road_market_picture);
	--SendCommandByName("menuname", "road",  "");
	if(bSingle)
	then
		SendCommandByName("road", "next", "load_choice");
	end
	FadeOut(0.1);
end 


local function PlayerFinish()
	if (not plf)
	then
		plf = true;
		ClearGlobalTimer();
		FadeIn(0.5);
		PlayMusic("menu.mp3");
		Update();
		isInGame = false;
		StopLevel();
	--	StopVideo();
	--	StopVideo1();
		SetFade(0);
		Update();
		ClearGlobalTimer();
		DeactivateInterfaces();
		SilentActivateInterface(back);
	
--	StopVideo();
--	SilentActivateInterface(backface);
	
--	PlayVideo("spline_only.avi", true);
	
--~ 	if(bSingle)
--~ 	then
--~ 		ClearGlobalTimer();
--~ 		Update();
--~ 		
--~ 		if(not bDefeat)
--~ 		then
--~ 			if(CheckPlayerRecords(GetCurrentRace()))
--~ 			then
--~ 				SaveScore();
--~ 				PlayBackface2();
--~ 				ActivateInterface(records);
--~ 				SendCommandByName("records", "game_mode", "single");
--~ 				SilentActivateInterface(menuName);
--~ 				SendCommandByName("menuname", "records", "single");
--~ 			else
--~ 				ActivateInterface(mainMenu);
--~ 			end
--~ 		end
--~ 	else


--~ 	if (bSingle)
--~ 	then
--~ 	SaveLog("SINGLE PASSED");
--~ 		PlayBackface();
--~ 		DeleteLevel();
--~ 		DeactivateInterfaces();
--~ 		ClearGameData();
--~ 		ActivateInterface(road);
--~ 	else
--~ 		local nRaces = GetNumRacesPassed() + 1;
--~ 	SaveLog("RACES PASSED "..nRaces);

--~ 		if (nRaces >= 11)
--~ 		then
--~ 			SetNumRacesPassed(11);
--~ 			SaveGame();
--~ 			ClearGameData();
--~ 			PlayBackface();
--~ 			DeleteLevel();
--~ 			ActivateInterface(gameMode);

--~ 		else
--~ 			SetNumRacesPassed(nRaces);
			SaveGame();
			ClearGameData();
			PlayBackface();
			DeleteLevel();
			DeactivateInterfaces();
			ActivateInterface(road);

			SetRoadPicture();
--~ 			if (GetNumRacesPassed() > 2)
--~ 			then
--~ 				SendCommandByName("main", "mission", "mission"..GetRealRacesPassed());
--~ 				SendCommandByName("main", "char", "day"); 
--~ 			else
--~ 				SendCommandByName("main", "mission", "mission"..GetRealRacesPassed());
--~ 				SendCommandByName("main", "load_choice", "");
--~ 			end
		--SetPlayerName("audi_tt");

		--~ 			local acar = GetActiveCar();
		--~ 			if("audi_tt" == acar or "bmw_i745" == acar or "volk_t" == acar)
		--~ 			then
		--~ 				ActivateInterface(loose_nw_picture);
		--~ 			elseif("gaz_z110" == acar or "uaz_469" == acar or "zil_130" == acar)
		--~ 			then
		--~ 				ActivateInterface(loose_dw_picture);
		--~ 			end
		--~ 			
		--~ 			ActivateInterface(player_win);
		--~end
	--~end
	
	
	FadeOut(0.5);
	end
end

commandMap["release_all"] = ReleaseAll;
commandMap["start_game"] = StartGame;
commandMap["start_lua_level"] = StartLuaLevel;
--commandMap["load_level"] = LoadLevel;
commandMap["load_choice"] = LoadChoice;
--commandMap["start_shop"] = StartShop;
--commandMap["start_mainmenu"] = StartMainMenu;
--commandMap["start_options"] = StartOptions;
--commandMap["start_save"] = StartSave;
--commandMap["start_load"] = StartLoad;
--commandMap["level_failed"] = LevelFailed;
--commandMap["player_dead"] = PlayerDead;
--commandMap["level_completed"] = LevelCompleted;
--commandMap["start_next_level"] = StartNextLevel;
commandMap["any_key"] 	= AnyKey;
commandMap["key_action"] 	= KeyAction;
commandMap["video_end"] 	= VideoEnd;
commandMap["team"] 		= StartTeam; 
commandMap["select"] 		= StartSelect;
commandMap["testing"] 	= StartTesting;
commandMap["mainmenu"] 	= StartMainMenu; 
commandMap["continue"] 	= StartContinue;
commandMap["options"] 	= StartOptions;
commandMap["char"] 		= StartChar; 
commandMap["road"] 		= StartRoad; 
commandMap["enter_name"] 	= StartName;
commandMap["game_mode"]	= StartGameMode;
commandMap["single"]		= StartSingle;
commandMap["movie_team"] 	= PlayMovieTeam; 
commandMap["level"] 		= Level; 
commandMap["mission"] 	= Mission; 
commandMap["char_picture"]	= CharPicture;
commandMap["lock"]	= Lock;
commandMap["lock2"]	= Lock2;
commandMap["lock3"]	= Lock3;
commandMap["lock3_5"]	= Lock3_5;
commandMap["lock3_9"]	= Lock3_9;
commandMap["lock3_13"]	= Lock3_13;
commandMap["lock4"]	= Lock4;
commandMap["lock5"]	= Lock5;
commandMap["left"]	= Left;
commandMap["right"]	= Right;
commandMap["help"]	= Help;
commandMap["road_picture"] =  RoadPicture;
commandMap["records"]	= StartRecords;
commandMap["game_loaded"]	= function () if("true" == GetCurrentParams(script)) then bGameLoaded = true; bNewGame = false; else bGameLoaded = false; end end
commandMap["set_single"]	= function () if("true" == GetCurrentParams(script)) then bSingle = true else bSingle = false; end end
commandMap["set_new_game"]	= function () if("true" == GetCurrentParams(script)) then bNewGame = true; bGameLoaded = false; SetNumRacesPassed(1); else bNewGame = false; end end
commandMap["update_bonus_list"] 	= function () local name = GetCurrentParams(script); if(name == nil) then name = ""; end SendCommandByName("level" .. current_mission, "update_bonus_list", name); end;
commandMap["stop_level"]	= StopLuaLevel;
commandMap["defeat"]		= PlayerDefeat;
commandMap["player_finish"]	= PlayerFinish;
commandMap["game_finish"]	= GameFinish;
commandMap["player_exit"]	= PlayerExit;
commandMap["exit_interface"] = ExitInterface;
commandMap["authors"]	= StartCredits;
commandMap["stop_music"]	= StopMusic;
 
--commandMap["credits"] = PlayCredits;

--commandMap["add_test_object"] = AddTestObject;

--PlayMusic("main.mp3");
--PlayIntro();
--DeactivateInterfaces();
--ActivateInterface(mainMenu);
--PlayBackface(); 
--PlayMovie(); 


--~ ActivateInterface(video);
--~ ExecuteCommands();
--~ isVideoPlaying = true;
--~ Update();

--~ PlayVideo("pub.avi", false);

--~ while(isVideoPlaying)
--~ do
--~ 	ExecuteCommands();
--~ 	Update();
--~ end

--~ isVideoPlaying = true;
--~ FadeIn(0.5);
--~ StopVideo();

--~ Update();

--~ PlayVideo("psycho.avi", false);
--~ FadeOut(0.5);
--~ Update();

--~ while(isVideoPlaying)
--~ do
--~ 	ExecuteCommands();
--~ 	Update();
--~ end

--~ isVideoPlaying = true;
--~ FadeIn(0.5);


--~ --ActivateInterface(video);
--~ --ExecuteCommands();
--~ --isVideoPlaying = true;
--~ --Update();

--~ --FadeIn(0.1);
--~ StopVideo();
--~ Update();
--~ PlayVideo("intro.avi", false);
--~ FadeOut(1);

--~ while(isVideoPlaying)
--~ do
--~ 	ExecuteCommands();
--~ 	Update();
--~ end

--~ Update();

--~ StopVideo();
--~ FadeIn(0.5);

ClearGlobalTimer();
local ttime = 0;

 SetFade(0);
--~ SaveLog("DEACTIVATE 1");
--~ DeactivateInterfaces();
--~ ActivateInterface(publ);
--~ ClearGlobalTimer();
--~ FadeOut(0.25);
--~ ExecuteCommands();
--~ isVideoPlaying = true;
--~ ttime = 0;
--~ while(isVideoPlaying and ttime < 2)
--~ do
--~ 	ttime = ttime + GetDeltaTime();
--~ 	ExecuteCommands();
--~ 	Update();
--~ end

--~ FadeIn(0.25);

if (bsplash2)
then
	ActivateInterface(splash2);
	FadeOut(1);
	local ttime = 2;
	while (ttime > 0)
	do
		ttime = ttime - GetDeltaTime();
		Update();
	end
	FadeIn(1);
	DeactivateInterface(splash2);
end
if (bsplash1)
then
	ActivateInterface(splash1);
	FadeOut(1);
	local ttime = 2;
	while (ttime > 0)
	do
		ttime = ttime - GetDeltaTime();
		Update();
	end
	FadeIn(1);
	DeactivateInterface(splash1);
end

PlayMusic("menu.mp3");


SetFade(0);
DeactivateInterfaces();
ActivateInterface(story1);
ClearGlobalTimer();
FadeOut(1);
ExecuteCommands();
isVideoPlaying = true;
ttime = 0;
while(isVideoPlaying and ttime < 3)
do
	ttime = ttime + GetDeltaTime();
	ExecuteCommands();
	Update();
end

FadeIn(1);

if (isVideoPlaying)
then
	SetFade(0);
	DeactivateInterfaces();
	ActivateInterface(story2);
	ClearGlobalTimer();
	FadeOut(1);
	ExecuteCommands();
	isVideoPlaying = true;
	ttime = 0;
	while(isVideoPlaying and ttime < 3)
	do
		ttime = ttime + GetDeltaTime();
		ExecuteCommands();
		Update();
	end

	FadeIn(1);
end

if (isVideoPlaying)
then
	SetFade(0);
	DeactivateInterfaces();
	ActivateInterface(story3);
	ClearGlobalTimer();
	FadeOut(1);
	ExecuteCommands();
	isVideoPlaying = true;
	ttime = 0;
	while(isVideoPlaying and ttime < 3)
	do
		ttime = ttime + GetDeltaTime();
		ExecuteCommands();
		Update();
	end

	FadeIn(1);
end


if (isVideoPlaying)
then
	SetFade(0);
	DeactivateInterfaces();
	ActivateInterface(story4);
	ClearGlobalTimer();
	FadeOut(1);
	ExecuteCommands();
	isVideoPlaying = true;
	ttime = 0;
	while(isVideoPlaying and ttime < 4)
	do
		ttime = ttime + GetDeltaTime();
		ExecuteCommands();
		Update();
	end

	FadeIn(1);
end


if (isVideoPlaying)
then
	SetFade(0);
	DeactivateInterfaces();
	ActivateInterface(story5);
	ClearGlobalTimer();
	FadeOut(1);
	ExecuteCommands();
	isVideoPlaying = true;
	ttime = 0;
	while(isVideoPlaying and ttime < 4)
	do
		ttime = ttime + GetDeltaTime();
		ExecuteCommands();
		Update();
	end

	FadeIn(1);
end



DeactivateInterfaces();
ActivateInterface(mainMenu);
if (bLogo)
then
	ActivateInterface(logoa);
	ActivateInterface(logona);
end
PlayBackface();
FadeOut(0.1);



while(true)
do

	ExecuteCommands();
	Update();
	

	
	
--	if (gamefailed)
--	then
--		gameovertime = gameovertime + GetDeltaTime();
--		if (gameovertime > 8)
--		then
--			DeleteLevel();
--			Update();
--			StopSounds();
--			Update();
--			StartMainMenu();
--			SaveLog("gamefailed_loop");
--		end
--	end
	
--	if (playerdead)
--	then
--		gameovertime = gameovertime + GetDeltaTime();
--		if (gameovertime > 5)
--		then
--			LevelFailed();
--			SaveLog("playerdead_loop");
--		end
--	end
	
--	if (inMainMenu)
--	then
--		timeBetween = timeBetween + GetDeltaTime();
--		if (timeBetween > 20)
--		then
--			if (lastVideo == "intro")
--			then
--				lastVideo = "trailer";
--				PlayTrailer();
--			elseif (lastVideo == "trailer")
--			then
--				lastVideo = "intro";
--				PlayIntro();
--			end
--		end
--	end
end
