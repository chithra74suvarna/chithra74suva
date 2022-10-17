local script = globalObject;

local delay = 0; 
local delay2 = 0; 
local menu_item = 1;

local strNext = "load_choice";

local menu_wnd = {};
menu_wnd[1] = "blend1";
menu_wnd[2] = "blend2";
menu_wnd[3] = "blend3";
menu_wnd[4] = "blend4";
menu_wnd[5] = "blend5";
menu_wnd[6] = "blend6";
menu_wnd[7] = "blend7";
menu_wnd[8] = "blend8";
menu_wnd[9] = "blend9";
menu_wnd[10] = "blend10";
menu_wnd[11] = "blend11";
menu_wnd[12] = "blend12";
menu_wnd[13] = "blend13";
menu_wnd[14] = "blend14";
menu_wnd[15] = "blend15";
menu_wnd[16] = "blend16";

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

local function UpdateRank()
	SetWindowVisible(interface, "rank_a", false);
	SetWindowVisible(interface, "rank_b", false);
	SetWindowVisible(interface, "rank_c", false);
	
	local nn = GetLevelMedal(menu_item);
	if (nn == 0)
	then
		SetWindowVisible(interface, "rank_a", true);
		
	elseif (nn == 1)
	then
		SetWindowVisible(interface, "rank_b", true);
	elseif (nn == 2)
	then
		SetWindowVisible(interface, "rank_c", true);
	end
	UpdateInterfaceBuffers(interface);
end

local function UpdateVisible()
		if (menu_item == 1)
		then
					SetWindowVisible(interface, "less", false);
					SetWindowVisible(interface, "more", true);
					SetWindowVisible(interface, "noless", true);
					SetWindowVisible(interface, "nomore", false);
					UpdateInterfaceBuffers(interface);
		elseif (menu_item == 16)
		then
					SetWindowVisible(interface, "less", true);
					SetWindowVisible(interface, "noless", false);
					SetWindowVisible(interface, "more", false);
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
	PlaySpecialSound("button_click");
	local name = GetCurrentParams(script);
	if (name == "back")
	then
		LockButton(interface, "back"); 
		LockButton(interface, "select"); 
		SendCommandByName("main", "mainmenu", "");
	elseif (name == "select")
	then 
		LockButton(interface, "select"); 
		LockButton(interface, "back"); 
		--SendCommandByName("main", "level", ""); 
		--SendCommandByName("main", "load_level", "");
		SendCommandByName("main", "char", "day"); 
--		SendCommandByName("main", strNext, "");
--		SendCommandByName("main", "mission", "mission"..menu_item); 
	elseif (name == "less")
	then
		if (delay2 > 0.1)
		then
			delay2 = 0;
			menu_item = menu_item - 1;
			if(menu_item < 1) then
				menu_item = 1;
			end
			UpdateVisible();
			
			SendCommandByName("road", "window", menu_wnd[menu_item]);
		end
	elseif (name == "more")
	then
		if (delay2 > 0.1)
		then
			delay2 = 0;
			menu_item = menu_item + 1;
			if(menu_item > 16) then
				menu_item = 16;
			end
			UpdateVisible();
			
			SendCommandByName("road", "window", menu_wnd[menu_item]);
		end
	end
end


local function ClearAllStrings()
--	SetTextString(interface, "road1", ""); 
	SetTextString(interface, "road1_red", ""); 
--	SetTextString(interface, "road2", ""); 
	SetTextString(interface, "road2_red", "");  
--	SetTextString(interface, "road3", ""); 
	SetTextString(interface, "road3_red", "");  
--	SetTextString(interface, "road4", ""); 
	SetTextString(interface, "road4_red", "");  
--	SetTextString(interface, "road5", ""); 
	SetTextString(interface, "road5_red", ""); 
--	SetTextString(interface, "road6", ""); 
	SetTextString(interface, "road6_red", ""); 
	SetTextString(interface, "road7_red", ""); 
	SetTextString(interface, "road8_red", ""); 
	SetTextString(interface, "road9_red", ""); 
	SetTextString(interface, "road10_red", ""); 
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
local flag12 = false;
local flag13 = false;
local flag14 = false;
local flag15 = false;
local flag16 = false;

local function Locking(num)
	if (num == 0)
	then
		UnlockButton(interface, "select");
		SendCommandByName("main", "lock3", "false");
					SetWindowVisible(interface, "noselect", false);
	
	local num_ = menu_item;
	local num2 = 1;
		if (num_ == 1)
	then
		num2 = 3;
	elseif (num_ == 2)
	then
		num2 = 3;
	elseif (num_ == 3)
	then
		num2 = 3;
	elseif (num_ == 4)
	then
		num2 = 2;
		elseif (num_ == 5)
	then
		num2 = 2;
	elseif (num_ == 6)
	then
		num2 = 2;
	elseif (num_ == 7)
	then
		num2 = 1;
		elseif (num_ == 8)
	then
		num2 = 1;
	elseif (num_ == 9)
	then
		num2 = 1;
	elseif (num_ == 10)
	then
		num2 = 1;
	end

	num2 = num_;

	SetTextString(interface, "text", "win"..num2);
	UpdateInterfaceBuffers(interface);
		
		
	elseif (num == 1)
	then
		LockButton(interface, "select");
					SetWindowVisible(interface, "noselect", true);
					
					
--			if (menu_item == 5 or menu_item == 9 or menu_item == 13)
--			then
----			  SendCommandByName("main", "lock3_"..menu_item, "true");
--			else
			  SendCommandByName("main", "lock3", menu_item);
--		end
		SetText(interface, "text", "");
	end
end


local function WindowSub(name)
	if (name == "blend1")
	then
	Locking(0);
		ClearAllStrings();  
--		SetTextString(interface, "road1_red", "road1"); 
		SetTextString(interface, "road1_red", "road3"); 
		if (GetNumRacesPassed() > 1)
		then
		end
		if (GetNumRacesPassed() > 2)
		then
		end
		if (GetNumRacesPassed() > 3)
		then
		end
		if (GetNumRacesPassed() > 4)
		then
		end
		if (GetNumRacesPassed() > 5)
		then
		end
		menu_item = 1;
		if (not flag1) 
		then 
--			SendCommandByName("main", "mission", "mission1");
--			SendCommandByName("main", "road_picture", "market");
		SendCommandByName("main", "mission", "mission1");
			SendCommandByName("main", "road_picture", "market");
			flag1 = true; 
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
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif (name == "blend2")-- and GetNumRacesPassed() > 1)
	then 
			menu_item = 2;
		if (GetNumRacesPassed() < 2)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
--		SetTextString(interface, "road2_red", "road2"); 
		SetTextString(interface, "road2_red", "road5"); 
		if (GetNumRacesPassed() > 3)
		then
		end
		if (GetNumRacesPassed() > 4)
		then
		end
		if (GetNumRacesPassed() > 5)
		then
			end
		if (not flag2) 
		then 
--			SendCommandByName("main", "road_picture", "airplane");
--			SendCommandByName("main", "mission", "mission2");
			SendCommandByName("main", "road_picture", "airplane");
			SendCommandByName("main", "mission", "mission2");
			flag1 = false; 
			flag2 = true; 
			flag3 = false;
			flag4 = false;
			flag5 = false;
			flag6 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag10 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif (name == "blend3")-- and GetNumRacesPassed() > 2)
	then 
		menu_item = 3;
		if (GetNumRacesPassed() < 3)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
	--	SetTextString(interface, "road3_red", "road3"); 
		SetTextString(interface, "road3_red", "road4"); 
			if (GetNumRacesPassed() > 3)
		then
		end
		if (GetNumRacesPassed() > 4)
		then
		end
		if (GetNumRacesPassed() > 5)
		then
		end
		if (not flag3) 
		then 
	--		SendCommandByName("main", "road_picture", "electro");
	--		SendCommandByName("main", "mission", "mission3"); 
			SendCommandByName("main", "road_picture", "electro");
			SendCommandByName("main", "mission", "mission3"); 
			flag1 = false; 
			flag2 = false;
			flag3 = true; 
			flag4 = false; 
			flag5 = false;
			flag6 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag10 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend4")-- and GetNumRacesPassed() > 3)
	then
		menu_item = 4;
		if (GetNumRacesPassed() < 4)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
--		SetTextString(interface, "road4_red", "road4"); 
		SetTextString(interface, "road4_red", "road6"); 
			if (GetNumRacesPassed() > 4)
		then
		end
		if (GetNumRacesPassed() > 5)
		then
		end
		if (not flag4) 
		then 
	--		SendCommandByName("main", "road_picture", "olga");
--			SendCommandByName("main", "mission", "mission4"); 
			SendCommandByName("main", "road_picture", "olga");
			SendCommandByName("main", "mission", "mission4"); 
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = true; 
			flag5 = false;
			flag6 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag10 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend5")-- and GetNumRacesPassed() > 4)
	then
		menu_item = 5;
		if (GetNumRacesPassed() < 5)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
--		SetTextString(interface, "road5_red", "road5"); 
		SetTextString(interface, "road7_red", "road7");
		if (GetNumRacesPassed() > 5)
		then
		end
		if (not flag5) 
		then 
--			SendCommandByName("main", "road_picture", "vampires");
--			SendCommandByName("main", "mission", "mission5"); 
			SendCommandByName("main", "mission", "mission5");
			SendCommandByName("main", "road_picture", "vampires");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = true;
			flag6 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag10 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend6")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 6;
		if (GetNumRacesPassed() < 6)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
--		SetTextString(interface, "road6_red", "road6");
		SetTextString(interface, "road6_red", "road8");
			if (not flag6) 
		then 
--			SendCommandByName("main", "mission", "mission6");
--			SendCommandByName("main", "road_picture", "funnel");
			SendCommandByName("main", "mission", "mission6");
			SendCommandByName("main", "road_picture", "funnel");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag6 = true;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag10 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend7")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 7;
		if (GetNumRacesPassed() < 7)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
--		SetTextString(interface, "road7_red", "road7");
		SetTextString(interface, "road7_red", "road2");
			if (not flag7) 
		then 
--			SendCommandByName("main", "mission", "mission7");
--			SendCommandByName("main", "road_picture", "funnel2");
			SendCommandByName("main", "mission", "mission7");
			SendCommandByName("main", "road_picture", "funnel2");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag7 = true;
			flag6 = false;
			flag8 = false;
			flag9 = false;
			flag10 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend8")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 8;
		if (GetNumRacesPassed() < 8)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
--		SetTextString(interface, "road8_red", "road8");
		SetTextString(interface, "road8_red", "road9");
			if (not flag8) 
		then 
--			SendCommandByName("main", "mission", "mission8");
--			SendCommandByName("main", "road_picture", "funnel3");
			SendCommandByName("main", "mission", "mission8");
			SendCommandByName("main", "road_picture", "funnel3");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag8 = true;
			flag7 = false;
			flag6 = false;
			flag9 = false;
			flag10 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend9")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 9;
		if (GetNumRacesPassed() < 9)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
--		SetTextString(interface, "road9_red", "road9");
		SetTextString(interface, "road9_red", "road1");
			if (not flag9) 
		then 
	--		SendCommandByName("main", "mission", "mission9");
	--		SendCommandByName("main", "road_picture", "funnel4");
			SendCommandByName("main", "mission", "mission9");
			SendCommandByName("main", "road_picture", "funnel4");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag9 = true;
			flag7 = false;
			flag8 = false;
			flag6 = false;
			flag10 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend10")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 10;
		if (GetNumRacesPassed() < 10)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
		SetTextString(interface, "road10_red", "road10");
			if (not flag10) 
		then 
			SendCommandByName("main", "mission", "mission10");
			SendCommandByName("main", "road_picture", "funnel5");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag10 = true;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag6 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend11")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 11;
		if (GetNumRacesPassed() < 11)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
		SetTextString(interface, "road11_red", "road11");
			if (not flag11) 
		then 
			SendCommandByName("main", "mission", "mission11");
			SendCommandByName("main", "road_picture", "funnel6");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag10 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag6 = false;
			flag11 = true;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend12")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 12;
		if (GetNumRacesPassed() < 12)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
		SetTextString(interface, "road12_red", "road12");
			if (not flag12) 
		then 
			SendCommandByName("main", "mission", "mission12");
			SendCommandByName("main", "road_picture", "funnel7");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag10 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag6 = false;
			flag11 = false;
			flag12 = true;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend13")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 13;
		if (GetNumRacesPassed() < 13)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
		SetTextString(interface, "road13_red", "road13");
			if (not flag13) 
		then 
			SendCommandByName("main", "mission", "mission13");
			SendCommandByName("main", "road_picture", "funnel8");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag10 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag6 = false;
			flag11 = false;
			flag12 = false;
			flag13 = true;
			flag14 = false;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend14")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 14;
		if (GetNumRacesPassed() < 14)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
		SetTextString(interface, "road14_red", "road14");
			if (not flag14) 
		then 
			SendCommandByName("main", "mission", "mission14");
			SendCommandByName("main", "road_picture", "funnel9");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag10 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag6 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = true;
			flag15 = false;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend15")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 15;
		if (GetNumRacesPassed() < 15)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
		SetTextString(interface, "road15_red", "road15");
			if (not flag15) 
		then 
			SendCommandByName("main", "mission", "mission15");
			SendCommandByName("main", "road_picture", "funnel10");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag10 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag6 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = true;
			flag16 = false;
		end
		UpdateInterfaceBuffers(interface);
	elseif(name == "blend16")-- and GetNumRacesPassed() > 5)
	then
		menu_item = 16;
		if (GetNumRacesPassed() < 16)
		then
					Locking(1);
		else
					Locking(0);
		end
		ClearAllStrings(); 
		SetTextString(interface, "road16_red", "road16");
			if (not flag16) 
		then 
			SendCommandByName("main", "mission", "mission16");
			SendCommandByName("main", "road_picture", "funnel11");
			flag1 = false; 
			flag2 = false;
			flag3 = false; 
			flag4 = false; 
			flag5 = false;
			flag10 = false;
			flag7 = false;
			flag8 = false;
			flag9 = false;
			flag6 = false;
			flag11 = false;
			flag12 = false;
			flag13 = false;
			flag14 = false;
			flag15 = false;
			flag16 = true;
		end
		UpdateInterfaceBuffers(interface);
	end
	UpdateRank();
end 

local function Window()
	local name = GetCurrentParams(script);
	WindowSub(name);
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

local function MenuUp()
	if (delay2 > 0.1)
	then
		delay2 = 0;
		menu_item = menu_item + 1;
		if(menu_item > 16) then
			menu_item = 16;
		end
			UpdateVisible();
		
		SendCommandByName("road", "window", menu_wnd[menu_item]);
	end
end

local function MenuDown()
	if (delay2 > 0.1)
	then
		delay2 = 0;
		menu_item = menu_item - 1;
		if(menu_item < 1) then
			menu_item = 1;
		end
			UpdateVisible();
		
		SendCommandByName("road", "window", menu_wnd[menu_item]);
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
	
	SetWindowVisible(interface, "select_square", false); 
	SetWindowVisible(interface, "back_square", false);
	
	ClearAllStrings();
	

--	SetTextString(interface, "road1_red", "road1"); 
	if (GetNumRacesPassed() > 1)
	then
	end
	if (GetNumRacesPassed() > 2)
	then
	end
	if (GetNumRacesPassed() > 3)
	then
	end
	if (GetNumRacesPassed() > 4)
	then
	end
	if (GetNumRacesPassed() > 5)
	then
	end

	UnlockButton(interface, "back");
	UnlockButton(interface, "select");
					SetWindowVisible(interface, "noselect", false);
	
--	SendCommandByName("main", "mission", "mission1");
--		SendCommandByName("main", "road_picture", "market");
	menu_item = GetCurrentMission();
		SendCommandByName("main", "mission", "mission"..menu_item);
	strNext = "load_choice";
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
	SetText(interface, "name", GetProfileName());
	local 	str2 = string.format("%0.3d points", GetPoints());
	SetText(interface, "race_rank_points", str2);
--	SetText(interface, "races", (GetNumRacesPassed()-1).."/16 missions");
	SetText(interface, "text", "");
	IMenuRight();
	
	UpdateRank();
	UpdateVisible();
--	WindowSub(menu_wnd[menu_item]);		
	UpdateInterfaceBuffers(interface);
end

local function Reset()
--	menu_item = 1;
--	SendCommandByName("main", "mission", "mission1");
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

commandMap["release_all"] 	= ReleaseAll;
commandMap["add_object"] 	= AddObject;
commandMap["delete_object"] = DeleteObject;
commandMap["mouse_button_over"] = MouseOver; 
commandMap["mouse_button_out"] = MouseOut; 
commandMap["button"] 	= Button;
commandMap["window"] 	= Window; 
commandMap["menu_up"] 	= MenuUp;
commandMap["menu_down"] 	= MenuDown;
commandMap["menu_left"] 	= MenuLeft;
commandMap["menu_right"] 	= MenuRight;
commandMap["reset"] 		= Reset;
commandMap["next"]		= function () strNext = GetCurrentParams(script); end

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
