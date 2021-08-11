local _mission = count WAI_MissionData -1;
local _aiType = _this select 0; // "Bandit" or "Hero"
local _position = [30] call WAI_FindPos;
local _name = "Slaughter House";
local _startTime = diag_tickTime;
local _difficulty = "Easy";
local _localized = ["STR_CL_MISSION_BANDIT", "STR_CL_MISSION_HERO"] select (_aiType == "Hero");
local _localName = "STR_CL_SLAUGHTERHOUSE_TITLE";

diag_log format["[WAI]: %1 %2 started at %3.",_aiType,_name,_position];

local _messages = ["STR_CL_SLAUGHTERHOUSE_ANNOUNCE","STR_CL_SLAUGHTERHOUSE_WIN","STR_CL_SLAUGHTERHOUSE_FAIL"];

////////////////////// Do not edit this section ///////////////////////////
local _markers = [1,1,1,1];
//[position,createMarker,setMarkerColor,setMarkerType,setMarkerShape,setMarkerBrush,setMarkerSize,setMarkerText,setMarkerAlpha]
_markers set [0, [_position, "WAI" + str(_mission), "ColorGreen", "", "ELLIPSE", "Solid", [300,300], [], 0]];
_markers set [1, [_position, "WAI" + str(_mission) + "dot", "ColorBlack", "mil_dot", "", "", [], [_localized,_localName], 0]];
if (WAI_AutoClaim) then {_markers set [2, [_position, "WAI" + str(_mission) + "auto", "ColorRed", "", "ELLIPSE", "Border", [WAI_AcAlertDistance,WAI_AcAlertDistance], [], 0]];};
DZE_ServerMarkerArray set [count DZE_ServerMarkerArray, _markers]; // Markers added to global array for JIP player requests.
_markerIndex = count DZE_ServerMarkerArray - 1;
PVDZ_ServerMarkerSend = ["start",_markers];
publicVariable "PVDZ_ServerMarkerSend";

WAI_MarkerReady = true;

// Add the mission's position to the global array so that other missions do not spawn near it.
DZE_MissionPositions set [count DZE_MissionPositions, _position];
local _posIndex = count DZE_MissionPositions - 1;

// Send announcement
[_difficulty,(_messages select 0)] call WAI_Message;

// Wait until a player is within range or timeout is reached.
local _timeout = false;
local _claimPlayer = objNull;

while {WAI_WaitForPlayer && !_timeout && {isNull _claimPlayer}} do {
	_claimPlayer = [_position, WAI_TimeoutDist] call isClosestPlayer;
	
	if (diag_tickTime - _startTime >= (WAI_Timeout * 60)) then {
		_timeout = true;
	};
	uiSleep 1;
};

if (_timeout) exitWith {
	[_mission, _aiType, _markerIndex, _posIndex] call WAI_AbortMission;
	[_difficulty,(_messages select 2)] call WAI_Message;
	diag_log format["WAI: %1 %2 aborted.",_aiType,_name,_position];
};
//////////////////////////////// End //////////////////////////////////////

//Spawn Crates
local _loot = if (_aiType == "Hero") then {Loot_SlaughterHouse select 0;} else {Loot_SlaughterHouse select 1;};
[[
	[_loot,WAI_CrateMd,[2.5,0,.1]]
],_position,_mission] call WAI_SpawnCrate;

// Spawn Objects
[[
	["Land_aif_tovarna1",[-0.01,-0.01,-0.02]],
	["Land_stand_meat_EP1",[-4,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[-2,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[0.001,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[-1,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[2,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[4,2,-0.02],0.3693],
	["Mass_grave",[-3,20,-0.02]],
	["Mass_grave",[4,18,-0.02]],
	["Mass_grave",[0,-15,-0.02]],
	["Axe_woodblock",[-4,-14,-0.02],-25],
	["Land_Table_EP1",[2,-2,-0.02]],
	["MAP_icebox",[-2,-0.01,-0.02]]
],_position,_mission] call WAI_SpawnObjects;

//Troops
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,_difficulty,"Random","AT","Random",_aiType,"Random",_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 13, (_position select 1) + 15, 0],(ceil random 3),_difficulty,"Random","AA","Random",_aiType,"Random",_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 13, (_position select 1) + 15, 0],(ceil random 3),_difficulty,"Random","","Random",_aiType,"Random",_aiType,_mission] call WAI_SpawnGroup;

[
	_mission, // Mission number
	_position, // Position of mission
	_difficulty, // Difficulty
	_name, // Name of Mission
	_localName, // localized marker text
	_aiType, // "Bandit" or "Hero"
	_markerIndex,
	_posIndex,
	_claimPlayer,
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;