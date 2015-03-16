

--
-- File to define all the races in the game and some
-- associated data (folder name and localization data)
--

-- Note: indices start at 1

-- Parameters:
--  Name:
--  Localized Display Name:
--  Name of the hyperspace effect
--  Name of the hyperspace sound effect, relative to data/sound/sfx
--  Hyperspace effect time
-- Is this race playable in skirmish/MP games
-- The prefix for ships of this type

-- NOTES:
-- when adding races, only add them to the end of this list, please do not add races before these since these are needed for hw2 in the given order.
-- Also, do NOT delete the invalid race, (first slot)
-- If you change the order or naming of races, please also change the definitions in PlayerRacePrefixes{} in KASUtil.lua

NotPlayable = 0
Playable = 1

races =
{
    --HW2 races
  	{"Invalid",  "Invalid", "", "", 0, NotPlayable, 1, "" },
	{"Hiigaran", "$1100", "hyperspace_gate", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 9.5, Playable, 1, "HGN_"},
	{"Vaygr",    "$1101", "hyperspace_gate_vgr", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 9.5, Playable, 1, "VGR_"},
	{"Keeper",  "$1102", "hyperspace_gate_kpr", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 12.5, NotPlayable, 1, "KPR_"},
	{"Bentusi",  "$1103", "hyperspace_gate_bentusi", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 18.5, NotPlayable, 1, "BEN_"},

    --HW1 races
	{"Kushan", "$1104", "hyperspace_gate", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 9.5, NotPlayable, 0, "KUS_"},
	{"Taiidan", "$1105", "hyperspace_gate", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 9.5, NotPlayable, 0, "TAI_"},
	{"Turanic Raiders", "$1106", "hyperspace_gate", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 9.5, NotPlayable, 0, "TUR_"},
	{"Kadeshi", "$1107", "hyperspace_gate", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 9.5, NotPlayable, 0, "KAD_"},
	{"P3", "P3", "hyperspace_gate", "etg/special/SPECIAL_ABILITIES_HYPERSPACE_IN", 9.5, NotPlayable, 0, "BEN_"},
    --pirate races to go here...

	{"Random",  "$3226", "", "", 0, Playable,1,""},

}
