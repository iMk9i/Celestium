extends Resource
class_name ETY_Stats

### - VARIABLES - ###

# - CONSTANTS

const HARD_STAT_CAP :int= 90
const SOFT_STAT_CAP :int= 75
const STAT_LVLUP_GAIN :int= 3

const MILESTONE_REQIREMENT :int= 20

const COMBO_BREAKER_DETAILS= {
	"passive-gain":.075,
	"bar-gain":.04,
	"hp-gain":.5,
}
const FORTITUDE_DETAILS= { # SOFT STAT CAP : 750 | HARD STAT CAP : 825
	"lvl-hp-req":90,# level requirement for the next hp gain 
	"lvl-bar-req":15,# level requirement for the next bar gain 
	"lvl-res-req":25,# level requirement for the next resistance gain  
	
	"lvl-hp-gain":1,	# +9 hearts | total 12 hearts
	"lvl-bar-gain":50,	# +2250 bar | total 2400 bar
	"lvl-res-gain":2,	# +66% resistances | total 66% resistances
	
	"bar-regen":10,	# per 50 bar
	
	"bar-hit-cd":.5, # seconds
	"bar-depleted-cd":5, # seconds
}
const ENDURANCE_DETAILS= { # SOFT STAT CAP : 1125 | HARD STAT CAP : 1275
	"lvl-bar-req":15,
	"lvl-eff-req":25, 
	"lvl-slt-req":125,
	
	"lvl-bar-gain":50, # +4250 bar | total 4400 bar
	"lvl-slt-gain":0, # +10 total slots
	"lvl-eff-gain":1, # +51 efficency
	
	"bar-regen":.05, # the % of max bar per second
	"regen-xLow":.5, # Multiplier for low regen
	"regen-xHigh":2, # Multiplier for high regen
	"regen-xBuff":2, # Mutliplier for a regen buff
	"regen-xDebuff":.5, # Mutliplier for a regen debuff
	
	"cast-xBuff":.75, # Multiplier for a casting buff 
	"cast-xDebuff":1.25, # Multiplier for a casting debuff 
}
const DEXTERITY_DETAILS= { # SOFT CAP 750 | HARD CAP 825 
	"lvl-spd-req":75,
	"lvl-tch-req":55, 
	
	"lvl-spd-gain":1, # +11 max speed | total 23 speed
	"lvl-tch-gain":1, # +15 technique points
}
const STRENGTH_DETAILS= { # SOFT CAP 750 | HARD CAP 825
	"lvl-dmg-req":25, 
	"lvl-tch-req":55,
	
	"lvl-dmg-gain":25, # +825 max damage | total 850 damage
	"lvl-tch-gain":1, # +15 technique points
}
const MAJIIK_DETAILS= { # SOFT CAP 750 | HARD CAP 825
	"lvl-dmg-req":15, 
	"lvl-mas-req":33, 
	"lvl-tch-req":55,
	
	"lvl-dmg-gain":10, # +550 max damage | total 575 damage
	"lvl-mas-gain":3, # +75 technique points
	"lvl-tch-gain":1, # +15 technique points
}

const STAT_CURVE :Dictionary= {
	"fortitude-hard":10,
	"endurance-hard":15,
	"dexterity-hard":10,
	"strength-hard":10,
	"majiiks-hard":10,
	
	"fortitude-soft":5,
	"endurance-soft":10,
	"dexterity-soft":5,
	"strength-soft":5,
	"majiiks-soft":5,
}
const LEVEL_BONUS :Dictionary= { # ADDED LEVELS DURING LEVEL UP ASWELL
	"fortitude":0.1, # MAX OF 6
	"endurance":0.1, # MAX OF 6
	"dexterity":0.2, # MAX OF 12
	"strength":0.2, # MAX OF 12
	"majiiks":0.2, # MAX OF 12
}
const BASE_STATS :Dictionary= {
	
	"fortitude-hp":3,
	"fortitude-bar":250,
	"fortitude-res":0,
	
	"endurance-bar":150,
	"endurance-slt":0,
	"endurance-eff":0,
	
	"dexterity-spd":12,
	"dexterity-tch":0,
	
	"strength-dmg":25,
	"strength-tch":0,
	
	"majiiks-dmg":15,
	"majiiks-mas":0,
	"majiiks-tch":0,
}

const MAX_LEVEL :int= 60
const NEXT_LEVEL_EXP :int= 20

# - VARIABLES

@export var level :int= 0
@export var xp :int= 0
@export var points :Dictionary= {
	"fortitude":0,
	"endurance":0,
	"dexterity":0,
	"strength":0,
	"majiiks":0,
}

var ComBreak_bar :float= 0.0

var stats :Dictionary= {
	
	"fortitude-points":0,
	"fortitude-hp":3,
	"fortitude-bar":250,
	"fortitude-res":0,
	
	"endurance-points":0,
	"endurance-bar":150,
	"endurance-slt":0,
	"endurance-eff":0,
	
	"dexterity-points":0,
	"dexterity-spd":12,
	"dexterity-tch":0,
	
	"strength-points":0,
	"strength-dmg":25,
	"strength-tch":0,
	
	"majiiks-points":0,
	"majiiks-dmg":15,
	"majiiks-mas":0,
	"majiiks-tch":0,
}
var milestones :Dictionary= {
	"fortitude":0,
	"endurance":0,
	"dexterity":0,
	"strength":0,
	"majiiks":0,
}

### - FUNCTIONS - ###


func RegisterStats():
	LevelUp("fortitude", points["fortitude"])
	LevelUp("endurance", points["endurance"])
	LevelUp("dexterity", points["dexterity"])
	LevelUp("strength", points["strength"])
	LevelUp("majiiks", points["majiiks"])


func LevelUp(name:String, value:int):
	stats[name+"-points"] += value
	var stat_points
	if (stats[name+"-points"] < SOFT_STAT_CAP):
		stat_points = stats[name+"-points"]*STAT_CURVE[name+"-hard"]
	else: 
		stat_points = (
			(stats[name+"-points"]-SOFT_STAT_CAP)*STAT_CURVE[name+"-soft"]+\
			(SOFT_STAT_CAP*STAT_CURVE[name+"-hard"])
		)
	
	if (stats[name+"-points"] < MAX_LEVEL+(LEVEL_BONUS[name]*level)):
		if (name == "fortitude") and stats[name+"-points"] > 0: 
			var new_hp :int= int(stat_points/FORTITUDE_DETAILS["lvl-hp-req"])
			var new_bar :int= int(stat_points/FORTITUDE_DETAILS["lvl-bar-req"])
			var new_res :int= int(stat_points/FORTITUDE_DETAILS["lvl-res-req"])
			
			stats["fortitude-hp"] = BASE_STATS["fortitude-hp"] + (new_hp*FORTITUDE_DETAILS["lvl-hp-gain"])
			stats["fortitude-bar"] = BASE_STATS["fortitude-bar"] + (new_bar*FORTITUDE_DETAILS["lvl-bar-gain"])
			stats["fortitude-res"] = BASE_STATS["fortitude-res"] + (new_res*FORTITUDE_DETAILS["lvl-res-gain"])
			
		elif (name == "endurance") and stats[name+"-points"] > 0: 
			var new_bar :int= int(stat_points/ENDURANCE_DETAILS["lvl-bar-req"])
			var new_slt :int= int(stat_points/ENDURANCE_DETAILS["lvl-slt-req"])
			var new_eff :int= int(stat_points/ENDURANCE_DETAILS["lvl-eff-req"])
			
			stats["endurance-bar"] = BASE_STATS["endurance-bar"] + (new_bar*ENDURANCE_DETAILS["lvl-bar-gain"])
			stats["endurance-slt"] = BASE_STATS["endurance-slt"] + (new_slt*ENDURANCE_DETAILS["lvl-slt-gain"])
			stats["endurance-eff"] = BASE_STATS["endurance-eff"] + (new_eff*ENDURANCE_DETAILS["lvl-eff-gain"])
			
		elif (name == "dexterity") and stats[name+"-points"] > 0: 
			var new_spd :int= int(stat_points/DEXTERITY_DETAILS["lvl-spd-req"])
			var new_tch :int= int(stat_points/DEXTERITY_DETAILS["lvl-tch-req"])
			
			stats["dexterity-spd"] = BASE_STATS["dexterity-spd"] + (new_spd*DEXTERITY_DETAILS["lvl-spd-gain"])
			stats["dexterity-tch"] = BASE_STATS["dexterity-tch"] + (new_tch*DEXTERITY_DETAILS["lvl-spd-gain"])
			
		elif (name == "strength") and stats[name+"-points"] > 0: 
			var new_dmg :int= int(stat_points/STRENGTH_DETAILS["lvl-dmg-req"])
			var new_tch :int= int(stat_points/STRENGTH_DETAILS["lvl-tch-req"])
			
			stats["strength-dmg"] = BASE_STATS["strength-dmg"] + (new_dmg*STRENGTH_DETAILS["lvl-dmg-gain"])
			stats["strength-tch"] = BASE_STATS["strength-tch"] + (new_tch*STRENGTH_DETAILS["lvl-tch-gain"])
			
		elif (name == "majiiks") and stats[name+"-points"] > 0: 
			var new_dmg :int= int(stat_points/MAJIIK_DETAILS["lvl-dmg-req"])
			var new_mas :int= int(stat_points/MAJIIK_DETAILS["lvl-mas-req"])
			var new_tch :int= int(stat_points/DEXTERITY_DETAILS["lvl-tch-req"])
			
			stats["majiik-dmg"] = BASE_STATS["majiiks-dmg"] + (new_dmg*MAJIIK_DETAILS["lvl-dmg-gain"])
			stats["majiik-mas"] = BASE_STATS["majiiks-mas"] + (new_mas*MAJIIK_DETAILS["lvl-mas-gain"])
			stats["majiik-tch"] = BASE_STATS["majiiks-tch"] + (new_tch*MAJIIK_DETAILS["lvl-tch-req"])
	else: printerr("MAX LEVEL ACHIEVED. TRY A DIFFERENT STAT")
	
	stats[name+"-points"] = min(stats[name+"-points"], MAX_LEVEL+LEVEL_BONUS[name]*level)
	milestones[name] = int(stats[name+"-points"]+LEVEL_BONUS[name]*level / 20)
	


func AddEXP(value:int) -> bool:
	var leveled_up :bool= false
	var next_level :int= 100+(level*NEXT_LEVEL_EXP)
	xp += value
	
	if (next_level < xp):
		xp -= next_level
		leveled_up = true
		level += 1
	
	return leveled_up
