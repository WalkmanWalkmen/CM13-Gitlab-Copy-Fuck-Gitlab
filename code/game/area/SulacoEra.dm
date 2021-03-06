//SULACO AREAS--------------------------------------//
/area/sulaco
	icon_state = "sulaco"
	ceiling = CEILING_METAL
	powernet_name = "almayer"
	sound_environment = 2
	soundscape_interval = 30
	//soundscape_playlist = list('sound/effects/xylophone1.ogg', 'sound/effects/xylophone2.ogg', 'sound/effects/xylophone3.ogg')
	ambience_exterior = AMBIENCE_SULACO
	ceiling_muffle = FALSE

/area/sulaco/bridge
	name = "\improper Sulaco Bridge"
	icon_state = "bridge"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/bridge/quarters
	name = "\improper Sulaco Officer's Quarters"
	icon_state = "bridge"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/bridge/office
	name = "\improper Sulaco Executive's Office"
	icon_state = "head_quarters"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/cap_office
	name = "\improper Sulaco Captain's Office"
	icon_state = "captain"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/bridge/maint
	name = "\improper Sulaco Bridge Maintenance"
	icon_state = "maintcentral"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/medbay
	name = "\improper Sulaco Medbay"
	icon_state = "medbay"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/medbay/storage
	name = "\improper Sulaco Medbay Storage"
	icon_state = "medbay2"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/medbay/storage2
	name = "\improper Sulaco Medbay Storage"
	icon_state = "medbay3"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/medbay/west
	name = "\improper Sulaco Medbay West"
	icon_state = "medbay3"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/medbay/hangar
	name = "\improper Sulaco Medbay Hangar"
	icon_state = "medbay3"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/medbay/surgery_one
	name = "\improper Sulaco Operating Theatre I"
	icon_state = "surgery"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/medbay/surgery_two
	name = "\improper Sulaco Operating Theatre II"
	icon_state = "surgery"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/medbay/chemistry
	name = "\improper Sulaco Chemistry"
	icon_state = "chem"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/disposal
	name = "\improper Sulaco Disposal"
	icon_state = "disposal"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/brig
	name = "\improper Sulaco Brig"
	icon_state = "brig"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/solar
	name = "Sulaco Solar Array"
	requires_power = 1
	always_unpowered = 1
	luminosity = 1
	lighting_use_dynamic = 0

/area/sulaco/solar/south
	icon_state = "panelsA"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/solar/north
	icon_state = "panelsP"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/hallway
	name = "\improper Sulaco Hallway"
	icon_state = "hallC1"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/hallway/central_hall
	name = "\improper Sulaco Central Hallway"
	icon_state = "hallC1"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/hallway/central_hall2
	name = "\improper Sulaco Central Hallway"
	icon_state = "hallC2"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/hallway/central_hall3
	name = "\improper Sulaco Central Hallway"
	icon_state = "hallC3"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/hallway/lower_main_hall
	name = "\improper Sulaco Main Hallway"
	icon_state = "hallF"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/briefing
	name = "\improper Sulaco Briefing Room"
	icon_state = "law"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/cryosleep
	name = "\improper Sulaco Cryogenic Storage"
	icon_state = "Sleep"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/showers
	name = "\improper Sulaco Showers"
	icon_state = "toilet"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/cafeteria
	name = "\improper Sulaco Cafeteria"
	icon_state = "cafeteria"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/cargo
	name = "\improper Sulaco Main Cargo Bay"
	icon_state = "quartstorage"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/ob_aa_cannon
	name = "\improper Sulaco OB and AA Cannon"
	icon_state = "red"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/cargo/office
	name = "\improper Sulaco Cargo Office"
	icon_state = "quartoffice"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/maintenance
	name = "\improper Sulaco Maintenance"
	icon_state = "fmaint"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/engineering
	name = "\improper Sulaco Engineering"
	icon_state = "engine"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/engineering/storage
	name = "\improper Sulaco Engineering Storage"
	icon_state = "engine_storage"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/engineering/ce
	name = "\improper Sulaco Chief's Office"
	icon_state = "head_quarters"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/engineering/atmos
	name = "\improper Sulaco Atmospherics"
	icon_state = "atmos"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/engineering/engine
	name = "\improper Sulaco Engine Chamber"
	icon_state = "yellow"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/engineering/smes
	name = "\improper Sulaco Engineering SMES"
	icon_state = "engine_smes"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/marine
	name = "\improper Sulaco Marine Prep"
	icon_state = "storage"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/marine/alpha
	name = "\improper Sulaco Alpha Marine Prep"
	icon_state = "red"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/marine/bravo
	name = "\improper Sulaco Bravo Marine Prep"
	icon_state = "yellow"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/marine/charlie
	name = "\improper Sulaco Charlie Marine Prep"
	icon_state = "purple"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/marine/delta
	name = "\improper Sulaco Delta Marine Prep"
	icon_state = "bluenew"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/command/armory
	name = "\improper Sulaco Secure Armory"
	icon_state = "red"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/research
	name = "\improper Sulaco Research Division"
	icon_state = "research"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/telecomms
	name = "\improper Sulaco Telecomms Central"
	icon_state = "tcomsatcham"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/telecomms/office
	name = "\improper Sulaco Telecomms Monitoring"
	icon_state = "tcomsatstore"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/command/ai
	name = "\improper Sulaco AI Chamber"
	icon_state = "ai_chamber"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/liaison
	name = "\improper Sulaco Liaison's Office"
	icon_state = "blue2"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/liaison/quarters
	name = "\improper Sulaco Liaison's Quarters"
	icon_state = "red"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/recroom
	name = "\improper Sulaco Rec Room"
	icon_state = "red"

/area/sulaco/maintenance/lower_maint
	name = "\improper Sulaco Maintenance"
	icon_state = "maintcentral"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/morgue
	name = "\improper Sulaco Morgue"
	icon_state = "morgue"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/hangar
	name = "\improper Sulaco Dropship Hangar"
	icon_state = "mining"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/hangar/one
	name = "\improper Sulaco Firing Range"
	icon_state = "red2"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/hangar/two
	name = "\improper Sulaco Atmospherics"
	icon_state = "blue-red2"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/command/eva
	name = "\improper Sulaco EVA Storage"
	icon_state = "storage"
	fake_zlevel = 1 //lowerdeck

/area/sulaco/maintenance/rear_maintenance
	name = "\improper Sulaco Lower Maintenance Deck"
	icon_state = "hallP"

/area/sulaco/maintenance/north_solar_maint
	name = "\improper Sulaco Solar Maintenance Deck"
	icon_state = "maintcentral"

/area/sulaco/maintenance/south_solar_maint
	name = "\improper Sulaco Solar Maintenance Deck"
	icon_state = "maintcentral"

/area/sulaco/maintenance/lower_maint2
	name = "\improper Sulaco Maintenance"
	icon_state = "maintcentral"
	fake_zlevel = 2 //lowerdeck

/area/sulaco/hub/top
	name = "\improper Sulaco Maintenance Hub"
	icon_state = "yellow"

/area/sulaco/hub/bottom
	name = "\improper Sulaco Maintenance Hub"
	icon_state = "yellow"

//Drop Pods
/area/shuttle/drop1

/area/shuttle/drop1/sulaco
	name = "\improper Sulaco Dropship 1"
	icon_state = "shuttlered"

/area/shuttle/drop1/LV624
	name = "\improper Sulaco Dropship 1"
	icon_state = "shuttle"

/area/shuttle/drop1/Haunted
	name = "\improper Sulaco Dropship 1"
	icon_state = "shuttle"

/area/shuttle/drop1/prison
	name = "\improper Sulaco Dropship 1"
	icon_state = "shuttle"

/area/shuttle/drop1/BigRed
	name = "\improper Sulaco Dropship 1"
	icon_state = "shuttle"

/area/shuttle/drop1/ice_colony
	name = "\improper Sulaco Dropship 1"
	icon_state = "shuttle"

/area/shuttle/drop1/transit
	name = "\improper Sulaco Dropship 1"
	icon_state = "shuttle2"

/area/shuttle/drop1/lz1
	name = "\improper Landing Zone 1"
	icon_state = "away1"

/area/shuttle/drop2/sulaco
	name = "\improper Sulaco Dropship 2"
	icon_state = "shuttle"

/area/shuttle/drop2/LV624
	name = "\improper Sulaco Dropship 2"
	icon_state = "shuttle2"

/area/shuttle/drop2/Haunted
	name = "\improper Sulaco Dropship 2"
	icon_state = "shuttle2"

/area/shuttle/drop2/prison
	name = "\improper Sulaco Dropship 2"
	icon_state = "shuttle2"

/area/shuttle/drop2/BigRed
	name = "\improper Sulaco Dropship 2"
	icon_state = "shuttle2"

/area/shuttle/drop2/ice_colony
	name = "\improper Sulaco Dropship 2"
	icon_state = "shuttle2"

/area/shuttle/drop2/transit
	name = "\improper Sulaco Dropship 2"
	icon_state = "shuttlered"

/area/shuttle/drop2/lz2
	name = "\improper Landing Zone 2"
	icon_state = "away2"

//Distress
/area/shuttle/distress_start
	name = "\improper Distress Shuttle"
	icon_state = "away1"

/area/shuttle/distress_transit
	name = "\improper Distress Shuttle"
	icon_state = "away2"

/area/shuttle/distress_arrive_1
	name = "\improper Distress Shuttle"
	icon_state = "away3"

/area/shuttle/distress_arrive_2
	name = "\improper Distress Shuttle"
	icon_state = "away4"

/area/shuttle/distress_arrive_3
	name = "\improper Distress Shuttle"
	icon_state = "away"
