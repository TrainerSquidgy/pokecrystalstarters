	object_const_def
	const SAFFRONPOKECENTER1F_NURSE
	const SAFFRONPOKECENTER1F_TEACHER
	const SAFFRONPOKECENTER1F_FISHER
	const SAFFRONPOKECENTER1F_YOUNGSTER
;	const SAFFRONPOKECENTER1F_YOUNGSTER2

SaffronPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

SaffronPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

SaffronPokecenter1FTeacherScript:
	special CheckMobileAdapterStatusSpecial
	iftrue .mobile
	jumptextfaceplayer SaffronPokecenter1FTeacherText

.mobile
	jumptextfaceplayer SaffronPokecenter1FTeacherMobileText

RareCandyGuy_Saffron:
	faceplayer
	opentext
	farwritetext RareCandyGuy_IntroText
	yesorno
	iffalse .End
.Reroll
	callasm RareCandyRNGEcruteak
	readmem wRareCandyRNG
	ifequal 9, .WhirlIslands	
	ifequal 8, .Route27
	ifequal 7, .MtMortar
	ifequal 6, .VioletCity
	ifequal 5, .Route34
	ifequal 4, .VermilionCityChairman
	ifequal 3, .SilverCave
	ifequal 2, .LakeOfRage
	ifequal 1, .OlivineLighthouse
	ifequal 0, .CinnabarIsland
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

SaffronPokecenter1FFisherScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .SolvedKantoPowerCrisis
	writetext SaffronPokecenter1FFisherText
	waitbutton
	closetext
	end

.SolvedKantoPowerCrisis:
	writetext SaffronPokecenter1FFisherReturnedMachinePartText
	waitbutton
	closetext
	end

SaffronPokecenter1FYoungsterScript:
	jumptextfaceplayer SaffronPokecenter1FYoungsterText

SaffronPokecenter1FTeacherText:
	text "What are JOHTO's"
	line "#MON CENTERS"
	cont "like?"

	para "…Oh, I see. So"
	line "they're not much"

	para "different from the"
	line "ones in KANTO."

	para "I can go to JOHTO"
	line "without worrying,"
	cont "then!"
	done

SaffronPokecenter1FTeacherMobileText:
	text "What are JOHTO's"
	line "#MON CENTERS"
	cont "like?"

	para "…Oh, I see."
	line "So they let you"

	para "link with people"
	line "far away?"

	para "Then I'll get my"
	line "friend in JOHTO to"

	para "catch a MARILL and"
	line "trade it to me!"
	done

SaffronPokecenter1FFisherText:
	text "I just happened to"
	line "come through ROCK"

	para "TUNNEL. There was"
	line "some commotion at"
	cont "the POWER PLANT."
	done

SaffronPokecenter1FFisherReturnedMachinePartText:
	text "Caves collapse"
	line "easily."

	para "Several caves have"
	line "disappeared in the"

	para "past few years,"
	line "like the one out-"
	cont "side CERULEAN."

	para "As a pro HIKER,"
	line "that's common"
	cont "knowledge."
	done

RareCandyRNGSaffron:
	ld a, 9
	call RandomRange
	ld [wRareCandyRNG], a
	ret


SaffronPokecenter1FYoungsterText:
	text "SILPH CO.'s HEAD"
	line "OFFICE and the"

	para "MAGNET TRAIN STA-"
	line "TION--they're the"

	para "places to see in"
	line "SAFFRON."
	done

SaffronPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, SAFFRON_CITY, 4
	warp_event  4,  7, SAFFRON_CITY, 4
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronPokecenter1FNurseScript, -1
	object_event  7,  2, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronPokecenter1FTeacherScript, -1
	object_event  8,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SaffronPokecenter1FFisherScript, -1
	object_event  1,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SaffronPokecenter1FYoungsterScript, -1
;	object_event  2,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RareCandyGuy_Saffron, EVENT_HELPFUL_NPCS_DISABLED
