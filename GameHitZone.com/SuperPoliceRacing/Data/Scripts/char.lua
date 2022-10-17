local script = globalObject;

local delay = 0; 
local delay2 = 0;

local race_type = 0;

local menu_item = 1;

local menu_wnd = {};
menu_wnd[1] = "blend1";
menu_wnd[2] = "blend2";
menu_wnd[3] = "blend3";
menu_wnd[4] = "blend4";
menu_wnd[5] = "blend5";

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

local function UpdateVisible()
		if (menu_item == 1)
			then
						SetWindowVisible(interface, "less", false);
						SetWindowVisible(interface, "more", true);
						SetWindowVisible(interface, "noless", true);
						SetWindowVisible(interface, "nomore", false);
						UpdateInterfaceBuffers(interface);
			elseif (menu_item == 5)
			then
						SetWindowVisible(interface, "less", true);
						SetWindowVisible(interface, "more", false);
						SetWindowVisible(interface, "noless", false);
						SetWindowVisible(interface, "nomore", true);
						UpdateInterfaceBuffers(interface);
		else
							SetWindowVisible(interface, "less", true);
						SetWindowVisible(interface, "more", true);
						SetWindowVisible(interface, "noless", false);
						SetWindowVisible(interface, "nomore", false);
						UpdateInterfaceBuffers(interface);
	
			end

end

local function Button()
	local name = GetCurrentParams(script);
	if (name == "back")
	then
		PlaySpecialSound("button_click");
		LockButton(interface, "back"); 
		LockButton(interface, "select"); 
		SendCommandByName("main", "road", "");
		--SendCommandByName("main", "team", ""); 	
	elseif (name == "select")
	then 
		PlaySpecialSound("button_click2");
		LockButton(interface, "select"); 
		LockButton(interface, "back"); 
--		SendCommandByName("main", "mission", "mission" .. GetNumRacesPassed());
		SendCommandByName("main", "load_choice", "");
	elseif (name == "less")
	then
		PlaySpecialSound("button_click");
		if (delay2 > 0.1)
		then
			delay2 = 0;
			menu_item = menu_item - 1;
			if(menu_item < 1) then
				menu_item = 1;
			end
			UpdateVisible();
		
			SendCommandByName("char", "window", menu_wnd[menu_item]);
		end
	elseif (name == "more")
	then
		PlaySpecialSound("button_click");
		if (delay2 > 0.1)
		then
			delay2 = 0;
			menu_item = menu_item + 1;
				if(menu_item > 5) then
				menu_item = 5;
			end
			UpdateVisible();
		
			SendCommandByName("char", "window", menu_wnd[menu_item]);
		end
	end
end


local flag = true; 

local function MouseOver()
	flag = false; 
	delay = 0; 
	local name = GetCurrentParams(script);
	SetWindowVisible(interface, name .. "_square", true); 
--	SetWindowVisible(interface, "square", false); 
	UpdateInterfaceBuffers(interface);
end

local function MouseOut()
	flag = true;
	delay = 0.3;
	SetWindowVisible(interface, "select_square", false);
	SetWindowVisible(interface, "back_square", false);
	UpdateInterfaceBuffers(interface);
end 

local cur_team; 

local function ClearAllStrings()
	SetTextString(interface, "alice_red", ""); 
	SetTextString(interface, "denis_red", ""); 
	SetTextString(interface, "kostya_red", ""); 
	SetTextString(interface, "kostya2_red", ""); 
	SetTextString(interface, "kostya3_red", ""); 
end

local flag1 = false; 
local flag2 = false; 
local flag3 = false; 
local flag4 = false; 
local flag5 = false; 
local flag6 = false; 
local flag7 = false; 
local flag8 = false; 
local flag9 = false; 
local flag10 = false; 
local flag11 = false; 

local function Locking(num)
	if (num == 0)
	then
		UnlockButton(interface, "select");
		SetWindowVisible(interface, "noselect", false);
			SendCommandByName("main", "lock", "false");
		SendCommandByName("main", "lock2", "false");
		SendCommandByName("main", "lock4", "false");
		SendCommandByName("main", "lock5", "false");
		
	elseif (num == 1)
	then
		LockButton(interface, "select");
		SetWindowVisible(interface, "noselect", true);
		SendCommandByName("main", "lock", "true");
		SendCommandByName("main", "lock2", "false");
		SendCommandByName("main", "lock4", "false");
		SendCommandByName("main", "lock5", "false");
	elseif (num == 2)
	then
		LockButton(interface, "select");
		SetWindowVisible(interface, "noselect", true);
		SendCommandByName("main", "lock", "false");
		SendCommandByName("main", "lock2", "true");
		SendCommandByName("main", "lock4", "false");
		SendCommandByName("main", "lock5", "false");
	elseif (num == 3)
	then
		LockButton(interface, "select");
		SetWindowVisible(interface, "noselect", true);
		SendCommandByName("main", "lock", "false");
		SendCommandByName("main", "lock4", "true");
		SendCommandByName("main", "lock2", "false");
		SendCommandByName("main", "lock5", "false");
	elseif (num == 4)
	then
		LockButton(interface, "select");
		SetWindowVisible(interface, "noselect", true);
		SendCommandByName("main", "lock", "false");
		SendCommandByName("main", "lock5", "true");
		SendCommandByName("main", "lock4", "false");
		SendCommandByName("main", "lock2", "false");
	end
end

local function Window()
	local name = GetCurrentParams(script);
--	if (cur_team == "day_dozor")
--	then 
		if (name == "blend1")
		then
			menu_item = 1;
			Locking(0);
			ClearAllStrings(); 
--			SetTextString(interface, "alice_red", "alice"); 
			if (not flag4) 
			then 
				--SendCommandByName("main", "movie_team", "alice_movie"); 
				if (race_type == 0)
				then
					SetPlayerName("lambo"); 
					SendCommandByName("main", "char_picture", "alice"); 
				else
					SetPlayerName("lambo_a"); 
					SendCommandByName("main", "char_picture", "denis"); 
				end
				SetPlayerType(true);
				flag4 = true; 
				flag5 = false; 
				flag6 = false; 
				flag7 = false; 
				flag8 = false; 
			end
			UpdateInterfaceBuffers(interface);
		elseif (name == "blend2")--and GetNumRacesPassed() > 4)
		then 
			Locking(0);
			menu_item = 2;
				--SendCommandByName("main", "lock2", "true");
			ClearAllStrings(); 
	--		SetPlayerName("viper"); 
	--		SetTextString(interface, "kostya2_red", "kostya2");
				if (not flag8) 
			then 
				--SendCommandByName("main", "movie_team", "kostya_movie"); 
					if (race_type == 0)
				then
					SetPlayerName("new"); 
					SendCommandByName("main", "char_picture", "kostya7");
				else
					SetPlayerName("new_a"); 
					SendCommandByName("main", "char_picture", "kostya8");
				end
			SetPlayerType(true);
				flag8 = true; 
				flag5 = false; 
				flag4 = false; 
				flag6 = false; 
				flag7 = false; 
			end 
			UpdateInterfaceBuffers(interface);
		elseif (name == "blend3")-- and GetNumRacesPassed() > 2)
		then 
		if (GetNumRacesPassed() >= 5 )--GetNumRacesPassed() > 2)
		then
			Locking(0);
		else
			Locking(1);
		end
			menu_item = 3;
				--SendCommandByName("main", "lock", "true");
	--			SendCommandByName("lock", "text", "alice"); 
			ClearAllStrings(); 
--				SetTextString(interface, "denis_red", "denis"); 
			if (not flag5) 
			then 
				--SendCommandByName("main", "movie_team", "denis_movie");
				if (race_type == 0)
				then
					SetPlayerName("chrysler"); 
					SendCommandByName("main", "char_picture", "kostya");
				else
					SetPlayerName("chrysler_a"); 
					SendCommandByName("main", "char_picture", "kostya2");
				end
				SetPlayerType(true);
				flag5 = true; 
				flag4 = false; 
				flag6 = false; 
				flag7 = false; 
				flag8 = false; 
			end
			UpdateInterfaceBuffers(interface);
		elseif (name == "blend4")--and GetNumRacesPassed() > 4)
		then 
		if (GetNumRacesPassed() >= 9)--GetNumRacesPassed() > 4)
		then
			Locking(0);
		else
			Locking(2);
		end
			menu_item = 4;
				--SendCommandByName("main", "lock2", "true");
			ClearAllStrings(); 
--			SetPlayerName("lister"); 
--			SetTextString(interface, "kostya_red", "kostya");
				if (not flag6) 
			then 
				--SendCommandByName("main", "movie_team", "kostya_movie"); 
				if (race_type == 0)
				then
					SetPlayerName("veyron"); 
					SendCommandByName("main", "char_picture", "kostya3");
				else
					SetPlayerName("veyron_a"); 
					SendCommandByName("main", "char_picture", "kostya4");
				end
				SetPlayerType(true);
				flag6 = true; 
				flag5 = false; 
				flag4 = false; 
				flag7 = false; 
				flag8 = false; 
			end 
			UpdateInterfaceBuffers(interface);
		elseif (name == "blend5")--and GetNumRacesPassed() > 4)
		then 
		if (GetNumRacesPassed() >= 13 )--GetNumRacesPassed() > 6)
		then
			Locking(0);
		else
			Locking(3);
		end
			menu_item = 5;
				--SendCommandByName("main", "lock2", "true");
			ClearAllStrings(); 
	--		SetPlayerName("viper"); 
	--		SetTextString(interface, "kostya2_red", "kostya2");
				if (not flag7) 
			then 
				--SendCommandByName("main", "movie_team", "kostya_movie"); 
					if (race_type == 0)
				then
					SetPlayerName("lemans"); 
					SendCommandByName("main", "char_picture", "kostya5");
				else
					SetPlayerName("lemans_a"); 
					SendCommandByName("main", "char_picture", "kostya6");
				end
			SetPlayerType(true);
				flag7 = true; 
				flag5 = false; 
				flag4 = false; 
				flag6 = false; 
				flag8 = false; 
			end 
			UpdateInterfaceBuffers(interface);
		end
--	end
end 

local function Dozor()
	local name = GetCurrentParams(script);
	if((name ~= "day_dozor") and (name ~= "night_dozor"))
	then
		name = "night_dozor";
	end
	
	cur_team = name; 
	if (name == "day_dozor")
	then 
		current_team = "day_dozor";  
		ClearAllStrings();
		if (race_type == 0)
		then
			SetPlayerName("lambo"); 
			SendCommandByName("main", "char_picture", "alice");
		else
			SetPlayerName("lambo_a"); 
			SendCommandByName("main", "char_picture", "denis");
		end
		SetPlayerType(true);
--			SetTextString(interface, "alice_red", "alice");
		
	elseif (name == "night_dozor")
	then
		current_team = "night_dozor"; 
		ClearAllStrings(); 
		SetPlayerName("zil_130_"); 
		SetPlayerType(false);
		SetWindowVisible(interface, "blank1", true);  
		SetWindowVisible(interface, "blank2", false); 
		SetWindowVisible(interface, "blank3", false); 
		SetTextString(interface, "simon_red", "simon"); 
		if (GetNumRacesPassed() > 2)
		then
			SetTextString(interface, "ilya", "ilya"); 
		else
			SetText(interface, "ilya", ""); 
		end
		
		if (GetNumRacesPassed() > 4)
		then
			SetTextString(interface, "lena", "lena"); 
		else
			SetText(interface, "lena", ""); 
		end
	end
	UpdateInterfaceBuffers(interface);
end

local function MenuUp()
	if (delay2 > 0.1)
	then
		delay2 = 0;
--~ 		local mmm = 1;
--~ 		if (GetNumRacesPassed() > 2)
--~ 		then
--~ 			mmm = 2;
--~ 		end
--~ 		if (GetNumRacesPassed() > 4)
--~ 		then
--~ 			mmm = 3;
--~ 		end
		menu_item = menu_item + 1;
		if(menu_item > 5) then
			menu_item = 5;
		end
			UpdateVisible();
		
		SendCommandByName("char", "window", "blend" .. menu_item);
	end
end


local function MenuDown()
	if (delay2 > 0.1)
	then
		delay2 = 0;
--~ 		local mmm = 1;
--~ 		if (GetNumRacesPassed() > 2)
--~ 		then
--~ 			mmm = 2;
--~ 		end
--~ 		if (GetNumRacesPassed() > 4)
--~ 		then
--~ 			mmm = 3;
--~ 		end
		menu_item = menu_item - 1;
			if(menu_item < 1) then
			menu_item = 1;
		end
			UpdateVisible();
		SendCommandByName("char", "window", "blend" .. menu_item);
	end
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
	
	ClearAllStrings();
	
	
--~ 	if (current_team == "night_dozor")
--~ 	then
--~ 		SetPlayerType(false);
--~ 		SetPlayerName("zil_130_"); 
--~ 		SetTextString(interface, "simon_red", "simon"); 
--~ 		SetTextString(interface, "ilya", "ilya"); 
--~ 		SetTextString(interface, "lena", "lena"); 
--~ 	elseif (current_team == "day_dozor")
--~ 	then 
--~ 		SetPlayerType(true);
--~ 		if (race_type == 0)
--~ 		then
--~ 			SetPlayerName("lambo"); 
--~ 			SendCommandByName("main", "char_picture", "alice");
--~ 		else
--~ 			SetPlayerName("lambo_a"); 
--~ 			SendCommandByName("main", "char_picture", "denis");
--~ 		end
--~ 	end 
	

	UnlockButton(interface, "back");
	UnlockButton(interface, "select");
		SetWindowVisible(interface, "noselect", false);
	
--	menu_item = 1;
	SetWindowVisible(interface, "square", false); 
flag1 = false; 
flag2 = false; 
flag3 = false; 
flag4 = false;
flag5 = false;
flag6 = false;	
flag7 = false;
flag8 = false;	
flag9 = false;	
flag10 = false;	
flag11 = false;	
						SetWindowVisible(interface, "less", false);
						SetWindowVisible(interface, "more", true);
						SetWindowVisible(interface, "noless", true);
						SetWindowVisible(interface, "nomore", false);
						UpdateInterfaceBuffers(interface);
						
	local num = GetCurrentRace();
	if (num >= 1 and num <= 4)
	then
		menu_item = 1;
	elseif (num >= 5 and num <= 8)
	then
		menu_item = 3;
	elseif (num >= 9 and num <= 12)
	then
		menu_item = 4;
	elseif (num >= 13 and num <= 16)
	then
		menu_item = 5;
	end	
	
	if (num == 1 or num == 3 or num == 5 or num == 7 or num == 9 or num == 11 or num == 13 or num == 15)
	then
		race_type = 0;
	else
		race_type = 1;
	end	
	
			UpdateVisible();
	
	IMenuRight();
	SetText(interface, "name", GetProfileName());
	local 	str2 = string.format("%0.5d", GetPoints());
	SetText(interface, "points", str2);
	SetText(interface, "races", (GetNumRacesPassed()-1).."/10");
	SetText(interface, "text", "");
	UpdateInterfaceBuffers(interface);
	SendCommandByName("char", "window", "blend" .. menu_item);
	ExecuteCommands();
	Update();
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
commandMap["dozor"] = Dozor; 
commandMap["window"] = Window;
commandMap["menu_up"] = MenuUp;
commandMap["menu_down"] = MenuDown;
commandMap["menu_left"] = MenuLeft;
commandMap["menu_right"] = MenuRight;

while(true)
do
	deltaTime = GetDeltaTime();
	delay2 = delay2 + deltaTime; 
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
