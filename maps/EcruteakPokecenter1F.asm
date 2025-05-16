	object_const_def
	const ECRUTEAKPOKECENTER1F_NURSE
	const ECRUTEAKPOKECENTER1F_POKEFAN_M
	const ECRUTEAKPOKECENTER1F_COOLTRAINER_F
	const ECRUTEAKPOKECENTER1F_GYM_GUIDE
	const ECRUTEAKPOKECENTER1F_BILL
	const ECRUTEAKPOKECENTER1F_PSYCHIC

EcruteakPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script EcruteakPokecenter1FMeetBillScene, SCENE_ECRUTEAKPOKECENTER1F_MEET_BILL
	scene_script EcruteakPokecenter1FNoopScene,     SCENE_ECRUTEAKPOKECENTER1F_NOOP

	def_callbacks

EcruteakPokecenter1FMeetBillScene:
	sdefer EcruteakPokcenter1FBillActivatesTimeCapsuleScript
	end

EcruteakPokecenter1FNoopScene:
	end

EcruteakPokcenter1FBillActivatesTimeCapsuleScript:
	pause 30
	playsound SFX_EXIT_BUILDING
	appear ECRUTEAKPOKECENTER1F_BILL
	waitsfx
	applymovement ECRUTEAKPOKECENTER1F_BILL, EcruteakPokecenter1FBillMovement1
	applymovement PLAYER, EcruteakPokecenter1FPlayerMovement1
	turnobject ECRUTEAKPOKECENTER1F_NURSE, UP
	pause 10
	turnobject ECRUTEAKPOKECENTER1F_NURSE, DOWN
	pause 30
	turnobject ECRUTEAKPOKECENTER1F_NURSE, UP
	pause 10
	turnobject ECRUTEAKPOKECENTER1F_NURSE, DOWN
	pause 20
	turnobject ECRUTEAKPOKECENTER1F_BILL, DOWN
	pause 10
	opentext
	writetext EcruteakPokecenter1F_BillText1
	promptbutton
	sjump .PointlessJump

.PointlessJump:
	writetext EcruteakPokecenter1F_BillText2
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement ECRUTEAKPOKECENTER1F_BILL, EcruteakPokecenter1FBillMovement2
	playsound SFX_EXIT_BUILDING
	disappear ECRUTEAKPOKECENTER1F_BILL
	clearevent EVENT_MET_BILL
	setflag ENGINE_TIME_CAPSULE
	setscene SCENE_ECRUTEAKPOKECENTER1F_NOOP
	waitsfx
	end

EcruteakPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

EcruteakPokecenter1FPokefanMScript:
	special CheckMobileAdapterStatusSpecial
	iftrue .mobile
	jumptextfaceplayer EcruteakPokecenter1FPokefanMText

.mobile
	jumptextfaceplayer EcruteakPokecenter1FPokefanMTextMobile

EcruteakPokecenter1FCooltrainerFScript:
	jumptextfaceplayer EcruteakPokecenter1FCooltrainerFText

EcruteakPokecenter1FGymGuideScript:
	jumptextfaceplayer EcruteakPokecenter1FGymGuideText
	
RareCandyGuy_Ecruteak:
	faceplayer
	opentext
	farwritetext RareCandyGuy_IntroText
	yesorno
	iffalse .End
	farwritetext ObtainedRareCandiesText
	waitbutton
	readmem wRareCandiesObtained
	ifequal 10, .AllObtained
.Reroll
	random 9
	ifequal 0, .CinnabarIsland
	ifequal 1, .OlivineLighthouse
	ifequal 2, .LakeOfRage
	ifequal 2, .SilverCave
	ifequal 4, .VermilionCityChairman
	ifequal 5, .Route34
	ifequal 6, .VioletCity
	ifequal 7, .MtMortar
	ifequal 8, .Route27
	ifequal 9, .WhirlIslands	
.Fallback	
	farwritetext RareCandyGuy_FallbackText
	sjump .End
.CinnabarIsland
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .Reroll
	checkevent EVENT_CINNABAR_ISLAND_HIDDEN_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandyGuy_CinnabarIsland
	sjump .End
.OlivineLighthouse
	checkevent EVENT_BEAT_WHITNEY
	iffalse .Reroll
	checkevent EVENT_OLIVINE_LIGHTHOUSE_5F_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandyGuy_OlivineLighthouse
	sjump .End
.LakeOfRage
	checkevent EVENT_BEAT_WHITNEY
	iffalse .Reroll
	checkevent EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandyGuy_LakeOfRage
	sjump .End	
.SilverCave
	checkevent EVENT_BEAT_BLUE
	iffalse .Reroll
	checkevent EVENT_ROUTE_28_HIDDEN_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandyGuy_SilverCave
	sjump .End
.VermilionCityChairman
	checkevent EVENT_BEAT_SAILOR_STANLY
	iffalse .Reroll
	checkevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT
	iftrue .Reroll
	farwritetext RareCandyGuy_VermilionCityChairman
	sjump .End
.Route34
	checkevent EVENT_BEAT_MORTY
	iffalse .Reroll
	checkevent EVENT_ROUTE_34_HIDDEN_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandy_Route34
	sjump .End
.VioletCity
	checkevent EVENT_BEAT_MORTY
	iffalse .Reroll
	checkevent EVENT_VIOLET_CITY_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandy_VioletCity
	sjump .End
.MtMortar
	checkevent EVENT_BEAT_PRYCE
	iffalse .Reroll
	checkevent EVENT_VIOLET_CITY_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandy_MtMortar
	sjump .End
.Route27
	checkevent EVENT_BEAT_MORTY
	iffalse .Reroll
	checkevent EVENT_ROUTE_27_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandy_Route27
	sjump .End
.WhirlIslands	
	checkflag ENGINE_RISINGBADGE
	iffalse .Reroll
	checkevent EVENT_WHIRL_ISLAND_B1F_HIDDEN_RARE_CANDY
	iftrue .Reroll
	farwritetext RareCandy_WhirlIslands
	sjump .End
.AllObtained
	farwritetext RareCandy_AllObtained	
	promptbutton
	closetext
	end
.End
	promptbutton
	farwritetext RareCandy_End
	waitbutton
	closetext
	end


EcruteakPokecenter1FBillMovement1:
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

EcruteakPokecenter1FBillMovement2:
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

EcruteakPokecenter1FPlayerMovement1:
	step UP
	step UP
	step UP
	step_end

EcruteakPokecenter1F_BillText1:
	text "Hi, I'm BILL. And"
	line "who are you?"

	para "Hmm, <PLAYER>, huh?"
	line "You've come at the"
	cont "right time."
	done

EcruteakPokecenter1F_BillText2:
	text "I just finished"
	line "adjustments on my"
	cont "TIME CAPSULE."

	para "You know that"
	line "#MON can be"
	cont "traded, right?"

	para "My TIME CAPSULE"
	line "was developed to"

	para "enable trades with"
	line "the past."

	para "But you can't send"
	line "anything that"

	para "didn't exist in"
	line "the past."

	para "If you did, the PC"
	line "in the past would"
	cont "have a breakdown."

	para "So you have to"
	line "remove anything"

	para "that wasn't around"
	line "in the past."

	para "Put simply, no"
	line "sending new moves"

	para "or new #MON in"
	line "the TIME CAPSULE."

	para "Don't you worry."
	line "I'm done with the"
	cont "adjustments."

	para "Tomorrow, TIME"
	line "CAPSULES will be"

	para "running at all"
	line "#MON CENTERS."

	para "I have to hurry on"
	line "back to GOLDENROD"
	cont "and see my folks."

	para "Buh-bye!"
	done

EcruteakPokecenter1FPokefanMText:
	text "The way the KIMONO"
	line "GIRLS dance is"

	para "marvelous. Just"
	line "like the way they"
	cont "use their #MON."
	done

EcruteakPokecenter1FPokefanMTextMobile:
	text "You must be hoping"
	line "to battle more"

	para "people, right?"
	line "There's apparently"

	para "some place where"
	line "trainers gather."

	para "Where, you ask?"

	para "It's a little past"
	line "OLIVINE CITY."
	done

EcruteakPokecenter1FCooltrainerFText:
	text "MORTY, the GYM"
	line "LEADER, is soooo"
	cont "cool."

	para "His #MON are"
	line "really tough too."
	done

EcruteakPokecenter1FGymGuideText:
	text "LAKE OF RAGE…"

	para "The appearance of"
	line "a GYARADOS swarm…"

	para "I smell a conspir-"
	line "acy. I know it!"
	done

EcruteakPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 6
	warp_event  4,  7, ECRUTEAK_CITY, 6
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FNurseScript, -1
	object_event  7,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FPokefanMScript, -1
	object_event  1,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FCooltrainerFScript, -1
	object_event  7,  1, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FGymGuideScript, -1
	object_event  0,  7, SPRITE_BILL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ECRUTEAK_POKE_CENTER_BILL
	object_event  6,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 3, RareCandyGuy_Ecruteak, EVENT_HELPFUL_NPCS_DISABLED
