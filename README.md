WICKED AI 2.3
==============

### Release 2.3 (worldwidesorrow)
- Extensive reworking of configs and missions
- Client side marker manager
- AI caching - disables FSM, targeting, movement and hides/unhides AI with hideObject command.
- Loop added to each mission file that prevents AI and objects from spawning until a player is near.
- Universal NPC deletion in sched_corpses function
- Bandit and Hero dog tags.
- All new DZE armed vehicles added to load ammo function
- Multi-position missions Castle Grayskull and Wuhan Lab added.
- Expanded AI gear selection
- Expanded skin selection
- Extensive rework of the static mission system including AI counter, custom mission markers, AI group respawning,
  support for setVectorDirAndUp command for object spawning, AI caching, auto-claim, etc. Custom Skalisty Island
  mission used for testing included.

### Release 2.2.7 (worldwidesorrow)
- Minor updates for DayZ Epoch 1.0.7 compatibility.

### Release 2.2.6 (worldwidesorrow)
- Mission objects and crates use compact arrays and functions. Missions can spawn multiple crates.
- Optional godmode mission objects for servers with overpowered military vehicles. Also disables simulation.
- New mission C130/MV-22 Armed Vehicle Air Drop added.
- New multi-crate mission Firestation added.
- AI multiplier added so overall AI level can be adjusted easily with variables in config.sqf
- AI Killfeed added to "on kill" function - enabled in config.sqf with variable ai_killfeed.
- effectiveCommander option added so vehicle gunners can get kill and humanity rewards. @Twist
- Map independent patrol missions. Reworked so they use map locations as waypoints and they only spawn one thread instead of three.
- Improved use of the mission data variable for modularity.
- Avoid traders replaced with avoid safezones that uses the built in DZE_SafeZonePosArray in init.sqf. @Twist
- Some functions that were not being used and are not necessary like isSlope and inDebug removed.
- Additional parameter for the load ammo function added so armed vehicles can have magazines placed in their gear.
- Mission vehicles remained locked until the mission is cleared to prevent ninjas.
- Since Arma has a bad habit of not kicking dead AI out of vehicles, keys will not spawn on AI static gunners or vehicle crew.
- Killzone Kid's shuffle plus function added for mission array randomization. @oiad
- BigEgg's localization solution turned into a function that localizes and formats messages submitted as arrays.
- The dynamic text option has color-coded mission announcements based on marker color.
- Additional code auditing and optimization.
- "mission" variable includes server key for security @BigEgg17
- missions combined into one folder for ease of update
- configurable minimum loot level in config.sqf

### Version history
- 15-11-2018 : Release 2.2.6
- 28-05-2018 : Release 2.2.5
- 16-02-2018 : Release 2.2.4
- 04-01-2018 : Release 2.2.3
- 04-12-2017 : Release 2.2.2
- 11-07-2017 : Release 2.2.1
- 06-06-2015 : Release 2.2.0
- 11-11-2014 : BETA release v3 (2.2.0)
- 11-11-2014 : BETA release v2 (2.2.0)
- 16-10-2014 : BETA release (2.2.0)
- 03-09-2014 : Minor bugfixes (2.1.4)
- 03-09-2014 : Minor bugfixes (2.1.3)
- 02-09-2014 : Minor bugfixes and improvements (2.1.2)
- 01-09-2014 : Minor bugfixes (2.1.1)
- 31-08-2014 : Release (2.1.0)
- 26-08-2014 : BETA release (2.1.0)
- 24-08-2014 : Minor bugfixes (2.0.5)
- 20-08-2014 : Minor bugfixes (2.0.4)
- 20-08-2014 : Minor bugfixes (2.0.3)
- 19-08-2014 : Minor bugfixes (2.0.2)
- 17-08-2014 : Minor bugfixes (2.0.1)
- 17-08-2014 : Major update to (2.0.0)
- 13-08-2014 : Added anti abuse options (1.9.3)
- 12-08-2014 : Normalization update (1.9.2)
- 12-08-2014 : Bugfix medi camp (1.9.1)
- 09-08-2014 : Major dynamic update (1.9.0)
- 03-08-2014 : Bugfix MV22 mission (1.8.2)
- 02-08-2014 : Restructured and code cleaned (1.8.1)

### Installation Instructions

1. Click ***[Clone or Download](https://github.com/f3cuk/WICKED-AI/archive/master.zip)*** the green button on the right side of the Github page.

2. This mod is dependent on the Client Side Marker Manager. Download it ***[here](https://github.com/worldwidesorrow/Client-Side-Marker-Manager/)*** and install it according to the instructions.

3. Extract the downloaded folder to your desktop and open it
4. Go to your server pbo and unpack it.
5. Copy the WAI folder into the ***dayz_server*** folder.
6. Navigate to directory ***dayz_server\system\scheduler*** and replace ***sched_corpses.sqf*** with the one from the download.
7. Copy over file ***sched_wai.sqf*** to the same folder.
8. Open file ***sched_init.sqf***.

	Find this line:
	
	```sqf
	call compile preprocessFileLineNumbers (PATH+"sched_safetyVehicle.sqf");
	```
	
	Place this line directly below it:
	
	```sqf
	call compile preprocessFileLineNumbers (PATH+"sched_wai.sqf");
	```
	
	Find this line:
	
	```sqf
	[ 300,	 	336,	sched_lootpiles_5m,         sched_lootpiles_5m_init ],
	```
	
	Place this line directly below it:
	
	```sqf
	[ 90,		60,		sched_wai,					sched_wai_init ],
	```
	
6. Navigate to the ***init*** folder and open ***server_functions.sqf***

	Place this line at the very bottom of the file.
	
	```sqf
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\init.sqf";
	```

7. Repack your server PBO.

### Mission Folder

1. Go to your mission pbo and unpack it.
2. Open mission.sqm

	Find:
	
	```sqf
	"chernarus",
	```
	
	And add the following line ***below*** it:
	
	```sqf
	"aif_arma1buildings",
	```

3. This mod is dependent on the Epoch community stringtable. Download the stringtable ***[here](https://github.com/oiad/communityLocalizations/)*** and place file stringTable.xml in the root of your mission folder.

Note: The announcements used in this mod are localized strings contained in the mod's dayz_code PBO. If you want to adjust the announcements, you need to create your own string table and overwrite the existing strings in the "WickedAI" section of stringtable.xml.

4. Repack your mission PBO.

### Battleye
If you are going to use the AI caching feature, then you need to add this exception to the end of line 46 or the one that starts with <code>5 hideObject</code>

 ```sqf
 !="this hideObject true"
 ```
 
Some of the missions use the MBG buildings and need to have an exception for opening the doors or else the log file will get spammed.  Add this to the end of line 40 or the one that starts with <code>1 execVM</code>

 ```sqf
 !"execvm 'MBG_Killhouses\\s\\MPSoundV2.sqf';"
 ```

Note: In order for players to receive radio announcements, they must have ItemRadio in a toolbelt inventory slot, so you might want to adjust your default loadout in init.sqf if you have this feature enabled.

### Configuration

Open file ***config.sqf*** in the WAI folder and review the configuration options. Generally, there are comments that explain the options.

### Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, bootstrap is maintained under [the Semantic Versioning guidelines](http://semver.org/). Sometimes we screw up, but we'll adhere to those rules whenever possible.

### Dev team
- worldwidesorrow

