	object_const_def
	const ELMSLAB_ELM
	const ELMSLAB_ELMS_AIDE
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_OFFICER
	const ELMSLAB_SCIENTIST

ElmsLab_MapScripts:
	def_scene_scripts
	scene_script ElmsLabMeetElmScene, SCENE_ELMSLAB_MEET_ELM
	scene_script ElmsLabNoop1Scene,   SCENE_ELMSLAB_CANT_LEAVE
	scene_script ElmsLabNoop2Scene,   SCENE_ELMSLAB_NOOP
	scene_script ElmsLabNoop3Scene,   SCENE_ELMSLAB_MEET_OFFICER
	scene_script ElmsLabNoop4Scene,   SCENE_ELMSLAB_UNUSED
	scene_script ElmsLabNoop5Scene,   SCENE_ELMSLAB_AIDE_GIVES_POTION
	scene_const SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS

	def_callbacks
	callback MAPCALLBACK_OBJECTS, ElmsLabMoveElmCallback

ElmsLabMeetElmScene:
	sdefer ElmsLabWalkUpToElmScript
	end

ElmsLabNoop1Scene:
	end

ElmsLabNoop2Scene:
	end

ElmsLabNoop3Scene:
	end

ElmsLabNoop4Scene:
	end

ElmsLabNoop5Scene:
	end

ElmsLabMoveElmCallback:
	checkscene
	iftrue .Skip ; not SCENE_ELMSLAB_MEET_ELM
	moveobject ELMSLAB_ELM, 3, 4
.Skip:
	endcallback


ElmsLabStarterChoice:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .End
	opentext
; Ask PLAYER if they want to set STARTERS
	writetext ElmsLabChooseStartersAskText
	yesorno
	iffalse .NoStarter
	writetext ElmsLabText_AskCyndaquil
	yesorno
	iffalse .NoCyndaquil
	special SetStarter1
	sjump .AskTotodile
.NoCyndaquil
	loadmem wElmPokemon1, 154
.AskTotodile
	writetext ElmsLabText_AskTotodile
	yesorno
	iffalse .NoTotodile
	special SetStarter2
	sjump .AskChikorita
.NoTotodile
	loadmem wElmPokemon2, 157
.AskChikorita
	writetext ElmsLabText_AskChikorita
	yesorno
	iffalse .NoChikorita
	special SetStarter3
	sjump .DoneStarters
.NoChikorita
	loadmem wElmPokemon3, 151
.DoneStarters
	special HandleStarterOffset
; Check to set Hidden Power
	writetext ElmsLabText_AskAboutHiddenPower
	yesorno
	iffalse .NoHiddenPower
	special SetHiddenPower
	writetext ElmsLabText_HiddenPowerUpdated
	waitbutton
	sjump .HandledHiddenPower
.NoHiddenPower
	loadmem wIsAStarter, 0
.HandledHiddenPower
; Check to see if MON should Evolve
	writetext ElmsLabChooseStartersYesText
	waitbutton
	sjump .Merge
.NoStarter
	writetext ElmsLabChooseStartersNoText
.Merge
	waitbutton
	writetext ElmsLabText_AskAboutHMFriends
	yesorno
	iffalse .NoHMFriends
	loadmem wIlexForestEncounters, 0
	loadmem wRoute34Encounters, 0
	loadmem wRoute33Encounters, 0
	loadmem wGuaranteedHMFriendCatch, 1
	writetext ElmsLabText_AskAboutHMFriendsYes
	sjump .DoneHMFriends
.NoHMFriends
	writetext ElmsLabText_AskAboutHMFriendsNo
	loadmem wIlexForestEncounters, 3
	loadmem wRoute34Encounters, 3
	loadmem wRoute33Encounters, 3
	loadmem wGuaranteedHMFriendCatch, 0
.DoneHMFriends
	waitbutton
	writetext ElmsLabText_AskStream
	yesorno
	iffalse .nostream
	loadmem wIsAStream, 1
	writetext ElmsLabText_StreamYes
	sjump .streamdone
.nostream
	loadmem wIsAStream, 0
	writetext ElmsLabText_StreamNo
.streamdone
	promptbutton
	closetext
	turnobject PLAYER, DOWN
.End
	end
	
ElmsLabText_AskStream:
	text "Is this a"
	line "STREAMED run?"
	done
	
ElmsLabText_StreamYes:
	text "Streaming"
	line "flag set."
	done

ElmsLabText_StreamNo:
	text "Streaming"
	line "flag unset."
	done
	
ElmsLabText_InverseNo:
	text "All type matchups"
	line "remain normal."
	done

ElmsLabText_InverseAsk:
	text "Do you want to"
	line "use INVERSE"
	cont "type matchups?"
	done

ElmsLabtext_InverseYes:
	text "All matchups"
	line "are INVERTED."
	done

ElmsLabExtraOptions:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .EndNoOptions
	opentext
	writetext ElmsLabText_ExtraOptionsGlobalAsk
	yesorno
	iffalse .EndOptions
	writetext ElmsLabText_AskExtraOptionsForYourMon
	yesorno
	iffalse .ExtraMonOptionsDone
.ExtraOptionsMon ; Extra Options for your Pokémon 
	writetext ElmsLabText_PLAHiddenPowerAsk
	yesorno
	iffalse .NoPLA
	loadmem wWhichHiddenPower, 1
	writetext ElmsLabText_PLAHiddenPowerYes
	waitbutton
	writetext ElmsLabText_PLAHiddenPowerWarning
	promptbutton
.NoPLA
	writetext ElmsLabText_AlterHiddenPower
	yesorno
	iffalse .NoAltering
	special SetHiddenPower
	special AlteredHiddenPower
	writetext ElmsLabText_AlteredHiddenPower
	sjump .Merge
.NoAltering
	writetext ElmsLabText_NoAlteredHiddenPower
.Merge
	promptbutton
	writetext ElmsLabText_AbilitiesAsk
	yesorno
	iftrue .AbilitiesYes
	loadmem wAbilitiesActivated, 0
	writetext ElmsLabText_AbilitiesNo
	sjump .NoAbilities
.AbilitiesYes
	loadmem wAbilitiesActivated, 1
	writetext ElmsLabText_AbilitiesYes
.NoAbilities
	promptbutton
	writetext ElmsLabText_EvolutionsAsk
	yesorno
	iftrue .KeepEvolutions
	loadmem wEvolutionsDisabled, 1
	writetext ElmsLabText_EvolutionsNo
	waitbutton
	sjump .HandledEvolutions
.KeepEvolutions
	loadmem wEvolutionsDisabled, 0
	writetext ElmsLabText_EvolutionsYes
	waitbutton
.HandledEvolutions
	writetext ElmsLabText_AskMegas
	yesorno
	iftrue .YesMegas
	loadmem wMegaEvolutionEnabled, 0
	writetext ElmsLabText_MegasNo
	sjump .HandledMegas
.YesMegas
	loadmem wMegaEvolutionEnabled, 1
	writetext ElmsLabText_MegasYes
.HandledMegas
.ExtraMonOptionsDone
	promptbutton
; GamePlay Changes for your Pokémon	
	writetext ElmsLabText_AskGamePlayChanges
	yesorno
	iffalse .GameplayDone
	writetext ElmsLabtext_LevelCapAsk
	yesorno
	iffalse .NoLevelCap
	loadmem wLevelCap, 9
	writetext ElmsLabText_LevelCapYes
.NoLevelCap
	writetext ElmsLabtext_LevelCapNo
.LevelCapDone
	promptbutton
	writetext ElmsLabText_AskRival
	yesorno
	iffalse .NoRival
	loadmem wRivalCarriesStarter, 1
	writetext ElmsLabText_RivalChanges
	waitbutton
	sjump .StartersDone
.NoRival
	loadmem wRivalCarriesStarter, 0
	writetext ElmsLabText_RivalStillSame
	waitbutton
.StartersDone
	writetext ElmsLabText_InverseAsk
	yesorno
	iftrue .YesInverse
	loadmem wInverseActivated, 0
	writetext ElmsLabText_InverseNo
	sjump .InverseDone
.YesInverse
	loadmem wInverseActivated, 1
	writetext ElmsLabtext_InverseYes
.InverseDone
	waitbutton	
	writetext ElmsLabText_MetronomeOnlyAsk
	yesorno
	iftrue .YesMetronome
	loadmem wMetronomeOnly, 0
	writetext ElmsLabText_MetronomeOnlyNo
	sjump .MetronomeDone
.YesMetronome
	loadmem wMetronomeOnly, 1
	writetext ElmsLabText_MetronomeOnlyYes 
.MetronomeDone
	waitbutton
.GameplayDone
	; Overworld and NPC Changes
	writetext ElmsLabText_AskAboutHelpfulNPCs
	yesorno
	iftrue .AskTutorLimit
	setevent EVENT_HELPFUL_NPCS_DISABLED
	sjump .NoTutors
.AskTutorLimit
	writetext ElmsLabText_AskLimitTutors
	yesorno
	iffalse .NoLimit
	loadmem wTutorsLimited, 0
	writetext ElmsLabText_LimitTutorsYes
	sjump .NoTutors
.NoLimit
	loadmem wTutorsLimited, 1
	writetext ElmsLabText_LimitTutorsNo
	waitbutton
.NoTutors
	writetext ElmsLabText_AskHelpfulItems
	yesorno
	iffalse .Spinners

.AskHelpfulItems
	waitbutton
	writetext ElmsLabText_HMItemsAsk
	yesorno
	iffalse .Spinners
	clearevent EVENT_RECEIVED_SCYTHE
	clearevent EVENT_RECEIVED_AIR_BALLOON
	clearevent EVENT_RECEIVED_RAFT
	clearevent EVENT_RECEIVED_BURLY_MAN
	clearevent EVENT_RECEIVED_LANTERN
	clearevent EVENT_RECEIVED_BATH_PLUG
	clearevent EVENT_RECEIVED_LADDER
	clearevent EVENT_RECEIVED_FART_JAR
	clearevent EVENT_RECEIVED_HONEY_JAR
	clearevent EVENT_RECEIVED_TREE_SHAKER
	clearevent EVENT_RECEIVED_BIG_HAMMER
	clearevent EVENT_RECEIVED_CANDY_JAR
	clearevent EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE_KEY
	setevent   EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE
	writetext ElmsLabText_HMItemsYes
	waitbutton
	waitbutton
	writetext ElmsLabText_ProfessorsRepelAsk
	yesorno
	iftrue .YesProfsRepel
	writetext ElmsLabText_ProfessorsRepelNo
	sjump .ProfsRepelDone
.YesProfsRepel
	verbosegiveitem PROFS_REPEL
	writetext ElmsLabText_ProfessorsRepelYes
.ProfsRepelDone
	waitbutton
	writetext ElmsLabText_CandyJarAsk
	yesorno 
	iffalse .NoCandyjar
	verbosegiveitem CANDY_JAR
	sjump .CandyEvents
.NoCandyjar
	writetext ElmsLabText_CandyJarNo
	waitbutton
	writetext ElmsLabText_RareCandiesAsk
	yesorno
	iffalse .Spinners
	verbosegiveitem RARE_CANDY, 10
.CandyEvents
	setevent EVENT_ROUTE_34_HIDDEN_RARE_CANDY
	setevent EVENT_ROUTE_28_HIDDEN_RARE_CANDY
	setevent EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY
	setevent EVENT_VIOLET_CITY_RARE_CANDY
	setevent EVENT_CINNABAR_ISLAND_HIDDEN_RARE_CANDY
	setevent EVENT_OLIVINE_LIGHTHOUSE_5F_RARE_CANDY
	setevent EVENT_ROUTE_27_RARE_CANDY
	setevent EVENT_MOUNT_MORTAR_2F_INSIDE_RARE_CANDY
	setevent EVENT_WHIRL_ISLAND_B1F_HIDDEN_RARE_CANDY
	setevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT
	writetext ElmsLabText_RareCandiesDone
.Spinners
	writetext ElmsLabText_SpinnersAsk
	yesorno
	iftrue .YesSpinners
	clearevent EVENT_REGULAR_BOARDER_DOUGLAS
	setevent EVENT_STATIC_BOARDER_DOUGLAS
	loadmem wSpinnersOff, 0
	writetext ElmsLabText_SpinnersNo
	sjump .SpinnersDone
.YesSpinners
	setevent EVENT_REGULAR_BOARDER_DOUGLAS
	clearevent EVENT_STATIC_BOARDER_DOUGLAS
	loadmem wSpinnersOff, 1
	writetext ElmsLabText_SpinnersYes
.SpinnersDone
	waitbutton
	writetext ElmsLabText_OptionsDone
	turnobject PLAYER, RIGHT
.EndOptions
	promptbutton
	closetext
.EndNoOptions
	end
	
ElmsLabText_AskHelpfulItems:
	text "Modify some ITEMS"
	line "and add extra"
	cont "helpful items?"
	done

ElmsLabText_AskAboutHelpfulNPCs:
	text "Add helpful NPCs"
	line "to the top floor"
	cont "all #MON"
	cont "CENTERS and a"
	
	para "MOVE REMINDER"
	line "in BLACKTHORN"
	cont "CITY?"
	done
	
ElmsLabText_RareCandiesDone:
	text "All the 10 RARE"
	line "CANDIES have been"
	cont "given to you."
	done
	
ElmsLabText_CandyJarAsk:
	text "Want to take a"
	line "CANDY JAR for"
	cont "your journey?"
	done
	
ElmsLabText_CandyJarNo:
	text "I'll hold on to"
	line "this then."
	done
	
ElmsLabText_RareCandiesAsk:
	text "Want all 10 RARE"
	line "CANDIES straight"
	cont "away?"
	done
	
ElmsLabText_AskGamePlayChanges:
	text "Make changes to"
	line "core GAME PLAY?"
	done
	
ElmsLabText_OptionsDone:
	text "All options have"
	line "now been set."
	done

ElmsLabText_ExtraOptionsGlobalAsk:
	text "You are about to"
	line "be asked to set"
	cont "EXTRA OPTIONS for"
	cont "your challenge."
	
	para "Declining here"
	line "will leave this"
	cont "whole menu."
	
	para "Set EXTRA OPTIONS"
	line "for your game?"
	done
	
ElmsLabText_AskExtraOptionsForYourMon:
	text "Set EXTRA OPTIONS"
	line "for your #MON?"
	done

ElmsLabText_ProfessorsRepelAsk:
	text "Borrow the"
	line "PROF'S REPEL?"
	done
	
ElmsLabText_HMItemsAsk:
	text "Play with ITEMS"
	line "that act like"
	cont "HM Moves?"
	done
	
ElmsLabText_HMItemsYes:
	text "Throughout your"
	line "adventure, you"
	cont "will obtain the"
	cont "HM ITEMS."
	done
	
ElmsLabtext_LevelCapAsk:
	text "Play with a"
	line "hard-coded"
	cont "LEVEL CAP?"
	done

ElmsLabText_LevelCapYes:
	text "You will stop"
	line "gaining EXP."
	cont "once you reach"
	cont "the next key"
	cont "trainer's level."
	done
	
ElmsLabtext_LevelCapNo:
	text "Your #MON"
	line "will gain EXP."
	cont "as normal."
	done
	
ElmsLabText_MetronomeOnlyAsk:
	text "Play on METRONOME"
	line "-only mode?"
	done
	
ElmsLabText_MetronomeOnlyYes:
	text "Good luck."
	line "You'll need it."
	done
	
ElmsLabText_MetronomeOnlyNo:
	text "You're still able"
	line "to pick moves."
	done

ElmsLabText_ProfessorsRepelYes:
	text "Turn it on in"
	line "the KEY ITEMS"
	
	para "and WILD #MON"
	line "will not appear."
	done
	
ElmsLabText_ProfessorsRepelNo:
	text "We'll keep hold"
	line "of this then!"
	done

ElmsLabText_SpinnersAsk:
	text "Turn all SPINNERS"
	line "into ROTATORS?"
	done
	
ElmsLabText_SpinnersYes:
	text "All map objects"
	line "with random spin,"
	
	para "now rotate in a"
	line "predictable way."
	done
	
ElmsLabText_SpinnersNo:
	text "All map objects"
	line "with random spin,"
	
	para "will continue"
	line "to spin randomly."
	done 
	
ElmsLabText_AskMegas:
	text "Do you want to"
	line "be able to"
	cont "MEGA EVOLVE?"
	done
	
ElmsLabText_MegasNo:
	text "No #MON will"
	line "MEGA EVOLVE."
	done
	
ElmsLabText_MegasYes:
	text "If your #MON"
	line "can MEGA EVOLVE,"
	
	para "it will be able"
	line "to as the story"
	cont "progresses."
	done


ElmsLabText_PLAHiddenPowerAsk:
	text "Want to play with"
	line "LEGENDS ARCEUS"
	cont "HIDDEN POWER?"
	done
	
ElmsLabText_PLAHiddenPowerYes:
	text "HIDDEN POWER will"
	line "be 50 power and"
	cont "always choose"
	cont "the best matchup."
	done

ElmsLabText_PLAHiddenPowerWarning:
	text "You will now be"
	line "asked about in-"
	cont "depth altering."
	
	para "This will only"
	line "affect your DVs."
	done

ElmsLabText_AskLimitTutors:
	text "Do you want a"
	line "limit on the"
	cont "amount of times"
	cont "you can use the"
	cont "new TUTORS?"
	done
	
ElmsLabText_LimitTutorsYes:
	text "You can only use"
	line "one new TUTOR a"
	cont "maximum of four"
	cont "times and you"
	cont "can only pick"
	cont "one TUTOR."
	done

ElmsLabText_LimitTutorsNo:
	text "You may use both"
	line "TUTORS unlimited"
	cont "times."
	done

ElmsLabText_AskExtraOptions:
	text "Set EXTRA OPTIONS"
	line "for your game?"
	done

ElmsLabText_NoExtraOptions:
	text "No extra changes"
	line "have been made."
	done

ElmsLabText_AbilitiesAsk:
	text "Do you want your"
	line "#MON to have"
	cont "an ABILITY if one"
	cont "is coded for it?"
	done

ElmsLabText_AbilitiesNo:
	text "Your #MON will"
	line "not have any"
	cont "extra ABILITY."
	done

ElmsLabText_AbilitiesYes:
	text "If your #MON"
	line "has an ability"
	cont "coded in, it will"
	cont "be activated."
	done 

ElmsLabText_AlterHiddenPower:
	text "Want to modify"
	line "HIDDEN POWER?"
	done

ElmsLabText_NoAlteredHiddenPower:
	text "HIDDEN POWER"
	line "stays the same."
	done

ElmsLabText_AlteredHiddenPower:
	text "HIDDEN POWER"
	line "is modified."
	done
	
ElmsLabText_EvolutionsYes:
	text "Evolutions are"
	line "still enabled."
	done
	
ElmsLabText_EvolutionsNo:
	text "Your #MON"
	line "will not evolve."
	done
	
ElmsLabText_EvolutionsAsk:
	text "Should your"
	line "#MON evolve?"
	done
	
ElmsLabText_AskRival:
	text "Do you want the"
	line "RIVAL's starter"
	cont "to change too?"
	done
	
ElmsLabText_RivalChanges:
	text "The RIVAL's"
	line "#MON will"
	cont "be updated."
	done

ElmsLabText_RivalStillSame:
	text "The RIVAL will"
	line "stay unchanged."
	done
	
ElmsLabText_AskAboutHiddenPower:
	text "Want to set type"
	line "for HIDDEN POWER?"
	done
	
ElmsLabText_HiddenPowerUpdated:
	text "HIDDEN POWER"
	line "type updated."
	done
	
ReceivedStarterTextNoPreview:
	text "<PLAYER> received"
	line "a #MON."
	done


ElmsLabChooseStartersAskText:
	text "Update STARTER"
	line "#MON?"
	done
	
ElmsLabChooseStartersYesText:
	text "STARTERS updated."
	line "Have fun...."
	done
	
ElmsLabChooseStartersNoText:
	text "Starters remain"
	line "same as before."
	done
	
ElmsLabText_AskChikorita:
	text "Want to change"
	line "CHIKORITA?"
	done
	
ElmsLabText_AskCyndaquil:
	text "Want to change"
	line "CYNDAQUIL?"
	done

ElmsLabText_AskTotodile:
	text "Want to change"
	line "TOTODILE?"
	done

BinSkipItemRandomizer:
	ld a, $f9
	call RandomRange
	cp ITEM_FA
	jr z, BinSkipItemRandomizer
	cp ITEM_A2
	jr z, BinSkipItemRandomizer
	cp ITEM_AB
	jr z, BinSkipItemRandomizer
	cp ITEM_B0
	jr z, BinSkipItemRandomizer
	cp ITEM_B3
	jr z, BinSkipItemRandomizer
	cp ITEM_BE
	jr z, BinSkipItemRandomizer
	cp ITEM_C3
	jr z, BinSkipItemRandomizer
	cp ITEM_DC
	jr z, BinSkipItemRandomizer
	ld [wPartyMon1Item], a
	ret

ElmsLabRandomizer:
	ld a, 250
	call RandomRange
	inc a
	ld [wElmPokemon1], a
	ld a, 250
	call RandomRange
	inc a
	ld [wElmPokemon2], a
	ld a, 250
	call RandomRange
	inc a
	ld [wElmPokemon3], a
	ret
	
BinSkipRandomizer:
	ld a, 250
	call RandomRange
	inc a
	ld [wBinSkipPokemon], a
	ret

Gen1TMRelearnerScript:
	faceplayer
	opentext
	readmem wPartyMon1Species
	ifgreater 150, .Gen2Mon
	special Gen1TMRelearner
	sjump .RelearnerMerge
.Gen2Mon
	special EggMoveRelearner
.RelearnerMerge
	waitbutton
	closetext
	end


ElmsLabWalkUpToElmScript:
	loadmem wLevelCap, 100
	setevent EVENT_RECEIVED_SCYTHE
	setevent EVENT_RECEIVED_AIR_BALLOON
	setevent EVENT_RECEIVED_RAFT
	setevent EVENT_RECEIVED_BURLY_MAN
	setevent EVENT_RECEIVED_LANTERN
	setevent EVENT_RECEIVED_BATH_PLUG
	setevent EVENT_RECEIVED_LADDER
	setevent EVENT_RECEIVED_FART_JAR
	setevent EVENT_RECEIVED_HONEY_JAR
	setevent EVENT_RECEIVED_TREE_SHAKER
	setevent EVENT_RECEIVED_BIG_HAMMER
	setevent EVENT_RECEIVED_CANDY_JAR
	setevent EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE_KEY

	applymovement PLAYER, ElmsLab_WalkUpToElmMovement
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	turnobject ELMSLAB_ELM, RIGHT
	opentext
	writetext ElmText_Intro
.MustSayYes:
	yesorno
	iftrue .ElmGetsEmail
	writetext ElmText_Refused
	promptbutton
	sjump .MustSayYes

.ElmGetsEmail:
	writetext ElmText_Accepted
	promptbutton
	writetext ElmText_ResearchAmbitions
	waitbutton
	closetext
	playsound SFX_GLASS_TING
	pause 30
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 10
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext ElmText_GotAnEmail
	waitbutton
	closetext
	opentext
	turnobject ELMSLAB_ELM, RIGHT
	writetext ElmText_MissionFromMrPokemon
	waitbutton
	closetext
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement1
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement2
	turnobject PLAYER, RIGHT
	opentext
	writetext ElmText_ChooseAPokemon
	waitbutton
	setscene SCENE_ELMSLAB_CANT_LEAVE
	closetext
	end

ProfElmScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue ElmCheckMasterBall
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue ElmGiveTicketScript
ElmCheckMasterBall:
	checkevent EVENT_GOT_MASTER_BALL_FROM_ELM
	iftrue ElmCheckEverstone
	checkflag ENGINE_RISINGBADGE
	iftrue ElmGiveMasterBallScript
ElmCheckEverstone:
	checkevent EVENT_GOT_EVERSTONE_FROM_ELM
	iftrue ElmScript_CallYou
	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
	iftrue ElmGiveEverstoneScript
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalse ElmCheckTogepiEgg
	setval TOGEPI
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setval TOGETIC
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	writetext ElmThoughtEggHatchedText
	waitbutton
	closetext
	end

ElmEggHatchedScript:
	setval TOGEPI
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setval TOGETIC
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	sjump ElmCheckGotEggAgain

ElmCheckTogepiEgg:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalse ElmCheckGotEggAgain
	checkevent EVENT_TOGEPI_HATCHED
	iftrue ElmEggHatchedScript
ElmCheckGotEggAgain:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE ; why are we checking it again?
	iftrue ElmWaitingEggHatchScript
	checkflag ENGINE_ZEPHYRBADGE
	iftrue ElmAideHasEggScript
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue ElmStudyingEggScript
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue ElmAfterTheftScript
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue ElmDescribesMrPokemonScript
	writetext ElmText_LetYourMonBattleIt
	waitbutton
	closetext
	end

LabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext LabWhereGoingText
	waitbutton
	closetext
	applymovement PLAYER, ElmsLab_CantLeaveMovement
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	readmem wElmPreview
	ifequal 1, .DontPreview
	reanchormap
	getmonname STRING_BUFFER_3, CYNDAQUIL
	pokepic CYNDAQUIL
	cry CYNDAQUIL
	waitbutton
	closepokepic
	opentext
	writetext TakeCyndaquilText
	yesorno
	iffalse DidntChooseStarterScript
.PreviewMerge
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	readmem wElmPreview
	ifequal 1, .DontShowName
	writetext ReceivedStarterText
	sjump .NameMerge
.DontShowName
	writetext ReceivedStarterTextNoPreview
.NameMerge
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke CYNDAQUIL, 5, BERRY
	closetext
	readvar VAR_FACING
	ifequal RIGHT, ElmDirectionsScript
	applymovement PLAYER, AfterCyndaquilMovement
	sjump ElmDirectionsScript
	
.DontPreview
	getmonname STRING_BUFFER_3, CYNDAQUIL
	opentext
	writetext ElmText_TakeThisMon
	yesorno
	iftrue .PreviewMerge
	sjump DidntChooseStarterScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	readmem wElmPreview
	ifequal 1, .DontPreview
	reanchormap
	getmonname STRING_BUFFER_3, TOTODILE
	pokepic TOTODILE
	cry TOTODILE
	waitbutton
	closepokepic
	opentext
	writetext TakeTotodileText
	yesorno
	iffalse DidntChooseStarterScript
.PreviewMerge
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	readmem wElmPreview
	ifequal 1, .DontShowName
	writetext ReceivedStarterText
	sjump .NameMerge
.DontShowName
	writetext ReceivedStarterTextNoPreview
.NameMerge
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke TOTODILE, 5, BERRY
	closetext
	applymovement PLAYER, AfterTotodileMovement
	sjump ElmDirectionsScript
	
.DontPreview
	getmonname STRING_BUFFER_3, TOTODILE
	opentext
	writetext ElmText_TakeThisMon
	yesorno
	iftrue .PreviewMerge
	sjump DidntChooseStarterScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	readmem wElmPreview
	ifequal 1, .DontPreview
	reanchormap
	getmonname STRING_BUFFER_3, CHIKORITA
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
	opentext
	writetext TakeChikoritaText
	yesorno
	iffalse DidntChooseStarterScript
.PreviewMerge
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	readmem wElmPreview
	ifequal 1, .DontShowName
	writetext ReceivedStarterText
	sjump .NameMerge
.DontShowName
	writetext ReceivedStarterTextNoPreview
.NameMerge
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke CHIKORITA, 5, BERRY
	closetext
	applymovement PLAYER, AfterChikoritaMovement
	sjump ElmDirectionsScript

.DontPreview
	getmonname STRING_BUFFER_3, CHIKORITA
	opentext
	writetext ElmText_TakeThisMon
	yesorno
	iftrue .PreviewMerge
	sjump DidntChooseStarterScript
	
	
ElmText_TakeThisMon:
	text "So you like the"
	line "look of this one?"
	done

DidntChooseStarterScript:
	writetext DidntChooseStarterText
	waitbutton
	closetext
	end

ElmDirectionsScript:
	turnobject PLAYER, UP
	opentext
	writetext ElmDirectionsText1
	waitbutton
	closetext
	addcellnum PHONE_ELM
	opentext
	writetext GotElmsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, LEFT
	opentext
	writetext ElmDirectionsText2
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext ElmDirectionsText3
	waitbutton
	closetext
	loadmem wEggMovesLeft, 4
	loadmem wGen1MovesLeft, 4
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setscene SCENE_ELMSLAB_AIDE_GIVES_POTION
	setmapscene NEW_BARK_TOWN, SCENE_NEWBARKTOWN_NOOP
	end

ElmDescribesMrPokemonScript:
	writetext ElmDescribesMrPokemonText
	waitbutton
	closetext
	end

LookAtElmPokeBallScript:
	opentext
	writetext ElmPokeBallText
	waitbutton
	closetext
	end

ElmsLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .CanHeal
	writetext ElmsLabHealingMachineText1
	waitbutton
	closetext
	end

.CanHeal:
	writetext ElmsLabHealingMachineText2
	yesorno
	iftrue ElmsLabHealingMachine_HealParty
	closetext
	end

ElmsLabHealingMachine_HealParty:
	special StubbedTrainerRankings_Healings
	special HealParty
	playmusic MUSIC_NONE
	setval HEALMACHINE_ELMS_LAB
	special HealMachineAnim
	pause 30
	special RestartMapMusic
	closetext
	end

ElmAfterTheftDoneScript:
	waitbutton
	closetext
	end

ElmAfterTheftScript:
	writetext ElmAfterTheftText1
	checkitem MYSTERY_EGG
	iffalse ElmAfterTheftDoneScript
	promptbutton
	writetext ElmAfterTheftText2
	waitbutton
	takeitem MYSTERY_EGG
	scall ElmJumpBackScript1
	writetext ElmAfterTheftText3
	waitbutton
	scall ElmJumpBackScript2
	writetext ElmAfterTheftText4
	promptbutton
	writetext ElmAfterTheftText5
	promptbutton
	setevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	setflag ENGINE_MOBILE_SYSTEM
	setmapscene ROUTE_29, SCENE_ROUTE29_CATCH_TUTORIAL
	clearevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_ROUTE_30_BATTLE
	writetext ElmAfterTheftText6
	waitbutton
	closetext
	setscene SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS
	end

ElmStudyingEggScript:
	writetext ElmStudyingEggText
	waitbutton
	closetext
	end

ElmAideHasEggScript:
	writetext ElmAideHasEggText
	waitbutton
	closetext
	end

ElmWaitingEggHatchScript:
	writetext ElmWaitingEggHatchText
	waitbutton
	closetext
	end

ShowElmTogepiScript:
	writetext ShowElmTogepiText1
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	setevent EVENT_SHOWED_TOGEPI_TO_ELM
	opentext
	writetext ShowElmTogepiText2
	promptbutton
	writetext ShowElmTogepiText3
	promptbutton
ElmGiveEverstoneScript:
	writetext ElmGiveEverstoneText1
	promptbutton
	verbosegiveitem EVERSTONE
	iffalse ElmScript_NoRoomForEverstone
	writetext ElmGiveEverstoneText2
	waitbutton
	closetext
	setevent EVENT_GOT_EVERSTONE_FROM_ELM
	end

ElmScript_CallYou:
	writetext ElmText_CallYou
	waitbutton
ElmScript_NoRoomForEverstone:
	closetext
	end

ElmGiveMasterBallScript:
	writetext ElmGiveMasterBallText1
	promptbutton
	verbosegiveitem MASTER_BALL
	iffalse .notdone
	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
	writetext ElmGiveMasterBallText2
	waitbutton
.notdone
	closetext
	end

ElmGiveTicketScript:
	writetext ElmGiveTicketText1
	promptbutton
	verbosegiveitem S_S_TICKET
	setevent EVENT_GOT_SS_TICKET_FROM_ELM
	writetext ElmGiveTicketText2
	waitbutton
	closetext
	end

ElmJumpBackScript1:
	closetext
	readvar VAR_FACING
	ifequal DOWN, ElmJumpDownScript
	ifequal UP, ElmJumpUpScript
	ifequal LEFT, ElmJumpLeftScript
	ifequal RIGHT, ElmJumpRightScript
	end

ElmJumpBackScript2:
	closetext
	readvar VAR_FACING
	ifequal DOWN, ElmJumpUpScript
	ifequal UP, ElmJumpDownScript
	ifequal LEFT, ElmJumpRightScript
	ifequal RIGHT, ElmJumpLeftScript
	end

ElmJumpUpScript:
	applymovement ELMSLAB_ELM, ElmJumpUpMovement
	opentext
	end

ElmJumpDownScript:
	applymovement ELMSLAB_ELM, ElmJumpDownMovement
	opentext
	end

ElmJumpLeftScript:
	applymovement ELMSLAB_ELM, ElmJumpLeftMovement
	opentext
	end

ElmJumpRightScript:
	applymovement ELMSLAB_ELM, ElmJumpRightMovement
	opentext
	end

AideScript_WalkPotion1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GivePotion
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkPotion2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GivePotion
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GivePotion:
	opentext
	writetext AideText_GiveYouPotion
	promptbutton
	verbosegiveitem POTION
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	setscene SCENE_ELMSLAB_NOOP
	end

AideScript_WalkBalls1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkBalls2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GiveYouBalls:
	opentext
	writetext AideText_GiveYouBalls
	promptbutton
	getitemname STRING_BUFFER_4, POKE_BALL
	scall AideScript_ReceiveTheBalls
	giveitem POKE_BALL, 5
	writetext AideText_ExplainBalls
	promptbutton
	itemnotify
	closetext
	readmem wLevelCap
	ifgreater 9, .skipLevelCap
	loadmem wLevelCap, 9
.skipLevelCap
	setscene SCENE_ELMSLAB_NOOP
	end

AideScript_ReceiveTheBalls:
	jumpstd ReceiveItemScript
	end

ElmsAideScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue AideScript_AfterTheft
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue AideScript_ExplainBalls
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue AideScript_TheftTestimony
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	end

AideScript_TheftTestimony:
	writetext AideText_TheftTestimony
	waitbutton
	closetext
	end

AideScript_ExplainBalls:
	writetext AideText_ExplainBalls
	waitbutton
	closetext
	end

AideScript_AfterTheft:
	writetext AideText_AfterTheft
	waitbutton
	closetext
	end

MeetCopScript2:
	applymovement PLAYER, MeetCopScript2_StepLeft

MeetCopScript:
	applymovement PLAYER, MeetCopScript_WalkUp
CopScript:
	turnobject ELMSLAB_OFFICER, LEFT
	opentext
	writetext ElmsLabOfficerText1
	promptbutton
	special NameRival
	writetext ElmsLabOfficerText2
	waitbutton
	closetext
	applymovement ELMSLAB_OFFICER, OfficerLeavesMovement
	disappear ELMSLAB_OFFICER
	setscene SCENE_ELMSLAB_NOOP
	end

ElmsLabWindow:
	opentext
	checkflag ENGINE_FLYPOINT_VIOLET
	iftrue .Normal
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue .BreakIn
	sjump .Normal

.BreakIn:
	writetext ElmsLabWindowText2
	waitbutton
	closetext
	end

.Normal:
	writetext ElmsLabWindowText1
	waitbutton
	closetext
	end

ElmsLabTravelTip1:
	jumptext ElmsLabTravelTip1Text

ElmsLabTravelTip2:
	jumptext ElmsLabTravelTip2Text

ElmsLabTravelTip3:
	jumptext ElmsLabTravelTip3Text

ElmsLabTravelTip4:
	jumptext ElmsLabTravelTip4Text

ElmsLabTrashcan:
	opentext 
	writetext ElmsLabTrashcanText
	waitbutton
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .end
	writetext ElmsLabShortcutText
	yesorno
	iftrue .shortcut
	writetext ElmsLabNoShortcutText
	waitbutton
	getmonname STRING_BUFFER_3, VOLTORB
	reanchormap
	pokepic VOLTORB
	cry VOLTORB
	waitbutton
	closepokepic
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText2
	promptbutton
	waitsfx
	opentext
	writetext ReceivedStarterTextNoPreview
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke VOLTORB, 5, BERRY
	closetext
	applymovement PLAYER, AfterVoltorbMovement
	sjump ElmDirectionsScript
		
.shortcut
	waitbutton
	callasm BinSkipRandomizer
	givepoke MEWTWO, 100, MYSTERYBERRY
	setflag ENGINE_MINERALBADGE
	setflag ENGINE_HIVEBADGE
	setflag ENGINE_PLAINBADGE
	setflag ENGINE_ZEPHYRBADGE
	setflag ENGINE_GLACIERBADGE
	setflag ENGINE_RISINGBADGE
	setflag ENGINE_STORMBADGE
	setflag ENGINE_FOGBADGE
	setevent EVENT_FOUGHT_SUDOWOODO
	variablesprite SPRITE_WEIRD_TREE, SPRITE_TWIN
	setevent EVENT_BEAT_FALKNER
	setevent EVENT_BEAT_BUGSY
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_BEAT_MORTY
	setevent EVENT_BEAT_CLAIR
	setevent EVENT_BEAT_PRYCE
	setevent EVENT_BEAT_JASMINE
	setevent EVENT_BEAT_CHUCK
	giveitem TM_DYNAMICPUNCH ; bf
	giveitem TM_HEADBUTT     ; c0
	giveitem TM_CURSE        ; c1
	giveitem TM_ROLLOUT      ; c2
	giveitem TM_ROAR         ; c4
	giveitem TM_TOXIC        ; c5
	giveitem TM_ZAP_CANNON   ; c6
	giveitem TM_ROCK_SMASH   ; c7
	giveitem TM_PSYCH_UP     ; c8
	giveitem TM_HIDDEN_POWER ; c9
	giveitem TM_SUNNY_DAY    ; ca
	giveitem TM_SWEET_SCENT  ; cb
	giveitem TM_SNORE        ; cc
	giveitem TM_BLIZZARD     ; cd
	giveitem TM_HYPER_BEAM   ; ce
	giveitem TM_ICY_WIND     ; cf
	giveitem TM_PROTECT      ; d0
	giveitem TM_RAIN_DANCE   ; d1
	giveitem TM_GIGA_DRAIN   ; d2
	giveitem TM_ENDURE       ; d3
	giveitem TM_FRUSTRATION  ; d4
	giveitem TM_SOLARBEAM    ; d5
	giveitem TM_IRON_TAIL    ; d6
	giveitem TM_DRAGONBREATH ; d7
	giveitem TM_THUNDER      ; d8
	giveitem TM_EARTHQUAKE   ; d9
	giveitem TM_RETURN       ; da
	giveitem TM_DIG          ; db
	giveitem TM_PSYCHIC_M    ; dd
	giveitem TM_SHADOW_BALL  ; de
	giveitem TM_MUD_SLAP     ; df
	giveitem TM_DOUBLE_TEAM  ; e0
	giveitem TM_ICE_PUNCH    ; e1
	giveitem TM_SWAGGER      ; e2
	giveitem TM_SLEEP_TALK   ; e3
	giveitem TM_SLUDGE_BOMB  ; e4
	giveitem TM_SANDSTORM    ; e5
	giveitem TM_FIRE_BLAST   ; e6
	giveitem TM_SWIFT        ; e7
	giveitem TM_DEFENSE_CURL ; e8
	giveitem TM_THUNDERPUNCH ; e9
	giveitem TM_DREAM_EATER  ; ea
	giveitem TM_DETECT       ; eb
	giveitem TM_REST         ; ec
	giveitem TM_ATTRACT      ; ed
	giveitem TM_THIEF        ; ee
	giveitem TM_STEEL_WING   ; ef
	giveitem TM_FIRE_PUNCH   ; f0
	giveitem TM_FURY_CUTTER  ; f1
	giveitem TM_NIGHTMARE    ; f2
	giveitem HM_CUT
	giveitem HM_FLASH
	giveitem HM_STRENGTH
	giveitem HM_SURF
	giveitem HM_FLY
	giveitem HM_WHIRLPOOL
	giveitem HM_WATERFALL
	callasm BinSkipItemRandomizer
	closetext
	setevent EVENT_OPENED_MT_SILVER
	clearevent EVENT_RED_IN_MT_SILVER
	warp SILVER_CAVE_ROOM_3, 9, 11
	end
.end
	closetext
	end

ElmsLabNoShortcutText:
	text "Okay, then. You"
	line "asked for this..."
	done
	
ElmsLabShortcutText:
	text "Time to take"
	line "a shortcut?"
	done
	
ElmsLabPC:
	jumptext ElmsLabPCText
	
ElmsLabRandomizeStarters:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .End
	clearevent EVENT_REGULAR_BOARDER_DOUGLAS
	setevent EVENT_STATIC_BOARDER_DOUGLAS
	opentext
	writetext ElmsLab_RandomizeStartersAsk
	yesorno
	iffalse .NoRandom
	callasm ElmsLabRandomizer
	writetext ElmsLab_RandomizerYes
	waitbutton
	writetext ElmsLab_RandomizerHide
	yesorno
	iffalse .YesPreview
	loadmem wElmPreview, 1
	writetext ElmsLabText_PreviewDisabled
	sjump .PreviewMerge
.YesPreview
	writetext ElmsLabText_PreviewEnabled
.PreviewMerge
	waitbutton
	writetext ElmsLabText_AskAboutHiddenPower
	yesorno
	iffalse .NoHiddenPower
	special SetHiddenPower
	writetext ElmsLabText_HiddenPowerUpdated
	waitbutton
	sjump .HandledHiddenPower
.NoHiddenPower
	loadmem wIsAStarter, 0
.HandledHiddenPower
; Check to see if MON should Evolve
	writetext ElmsLabText_EvolutionsAsk
	yesorno
	iftrue .KeepEvolutions
	loadmem wEvolutionsDisabled, 1
	writetext ElmsLabText_EvolutionsNo
	waitbutton
	sjump .HandledEvolutions
.KeepEvolutions
	loadmem wEvolutionsDisabled, 0
	writetext ElmsLabText_EvolutionsYes
	waitbutton
.HandledEvolutions
	writetext ElmsLabText_AskRival
	yesorno
	iffalse .NoRival
	loadmem wRivalCarriesStarter, 1
	writetext ElmsLabText_RivalChanges
	waitbutton
	sjump .StartersDone
.NoRival
	loadmem wRivalCarriesStarter, 0
	writetext ElmsLabText_RivalStillSame
	waitbutton
.StartersDone
	writetext ElmsLabChooseStartersYesText
	sjump .Merge	
.NoRandom
	writetext ElmsLab_RandomizerNo
	waitbutton
.Merge
	writetext ElmsLabText_AskAboutHMFriends
	yesorno
	iffalse .NoHMFriends
	loadmem wIlexForestEncounters, 0
	loadmem wRoute34Encounters, 0
	loadmem wGuaranteedHMFriendCatch, 1
	writetext ElmsLabText_AskAboutHMFriendsYes
	sjump .DoneHMFriends
.NoHMFriends
	writetext ElmsLabText_AskAboutHMFriendsNo
	loadmem wIlexForestEncounters, 3
	loadmem wRoute34Encounters, 3
	loadmem wGuaranteedHMFriendCatch, 0
.DoneHMFriends
	waitbutton
	closetext
	turnobject PLAYER, UP
.End
	end
ElmsLabText_PreviewEnabled:
	text "You will still"
	line "see what you"
	cont "can receive."
	done
	
ElmsLabText_PreviewDisabled:
	text "You will not"
	line "be able to see"
	cont "what you get."
	done
	
ElmsLab_RandomizerHide:
	text "Do you want to"
	line "hide what is"
	cont "in each ball?"
	done
	
ElmsLab_RandomizeStartersAsk:
	text "Do you want"
	line "to randomize"
	cont "your starters?"
	done
	
ElmsLab_RandomizerNo:
	text "Starters are"
	line "kept unchanged."
	done
	
ElmsLab_RandomizerYes:
	text "Starters are"
	line "now randomized."
	done
	

ElmsLabTrashcan2: ; unreferenced
	jumpstd TrashCanScript

ElmsLabBookshelf:
	jumpstd DifficultBookshelfScript

ElmsLab_WalkUpToElmMovement:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head LEFT
	step_end

ElmsLab_CantLeaveMovement:
	step UP
	step_end

MeetCopScript2_StepLeft:
	step LEFT
	step_end

MeetCopScript_WalkUp:
	step UP
	step UP
	turn_head RIGHT
	step_end

OfficerLeavesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

AideWalksRight1:
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksRight2:
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksLeft1:
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

AideWalksLeft2:
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

ElmJumpUpMovement:
	fix_facing
	big_step UP
	remove_fixed_facing
	step_end

ElmJumpDownMovement:
	fix_facing
	big_step DOWN
	remove_fixed_facing
	step_end

ElmJumpLeftMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	step_end

ElmJumpRightMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	step_end

ElmsLab_ElmToDefaultPositionMovement1:
	step UP
	step_end

ElmsLab_ElmToDefaultPositionMovement2:
	step RIGHT
	step RIGHT
	step UP
	turn_head DOWN
	step_end

AfterCyndaquilMovement:
	step LEFT
	step UP
	turn_head UP
	step_end

AfterTotodileMovement:
	step LEFT
	step LEFT
	step UP
	turn_head UP
	step_end

AfterVoltorbMovement:
	step LEFT
AfterChikoritaMovement:
	step LEFT
	step LEFT
	step LEFT
	step UP
	turn_head UP
	step_end

ElmText_Intro:
	text "ELM: <PLAY_G>!"
	line "There you are!"

	para "I needed to ask"
	line "you a favor."

	para "I'm conducting new"
	line "#MON research"

	para "right now. I was"
	line "wondering if you"

	para "could help me with"
	line "it, <PLAY_G>."

	para "You see…"

	para "I'm writing a"
	line "paper that I want"

	para "to present at a"
	line "conference."

	para "But there are some"
	line "things I don't"

	para "quite understand"
	line "yet."

	para "So!"

	para "I'd like you to"
	line "raise a #MON"

	para "that I recently"
	line "caught."
	done

ElmText_Accepted:
	text "Thanks, <PLAY_G>!"

	para "You're a great"
	line "help!"
	done

ElmText_Refused:
	text "But… Please, I"
	line "need your help!"
	done

ElmText_ResearchAmbitions:
	text "When I announce my"
	line "findings, I'm sure"

	para "we'll delve a bit"
	line "deeper into the"

	para "many mysteries of"
	line "#MON."

	para "You can count on"
	line "it!"
	done

ElmText_GotAnEmail:
	text "Oh, hey! I got an"
	line "e-mail!"

	para "<……><……><……>"
	line "Hm… Uh-huh…"

	para "Okay…"
	done

ElmText_MissionFromMrPokemon:
	text "Hey, listen."

	para "I have an acquain-"
	line "tance called MR."
	cont "#MON."

	para "He keeps finding"
	line "weird things and"

	para "raving about his"
	line "discoveries."

	para "Anyway, I just got"
	line "an e-mail from him"

	para "saying that this"
	line "time it's real."

	para "It is intriguing,"
	line "but we're busy"

	para "with our #MON"
	line "research…"

	para "Wait!"

	para "I know!"

	para "<PLAY_G>, can you"
	line "go in our place?"
	done

ElmText_ChooseAPokemon:
	text "I want you to"
	line "raise one of the"

	para "#MON contained"
	line "in these BALLS."

	para "You'll be that"
	line "#MON's first"
	cont "partner, <PLAY_G>!"

	para "Go on. Pick one!"
	done

ElmText_LetYourMonBattleIt:
	text "If a wild #MON"
	line "appears, let your"
	cont "#MON battle it!"
	done

LabWhereGoingText:
	text "ELM: Wait! Where"
	line "are you going?"
	done

TakeCyndaquilText:
	text "ELM: You'll take"
	line "@"
	text_ram wStringBuffer3
	text "?"
	done

TakeTotodileText:
	text "ELM: Do you want"
	line "@"
	text_ram wStringBuffer3
	text "?"
	done

TakeChikoritaText:
	text "ELM: So, you like"
	line "@"
	text_ram wStringBuffer3
	text "?"
	done

DidntChooseStarterText:
	text "ELM: Think it over"
	line "carefully."

	para "Your partner is"
	line "important."
	done

ChoseStarterText:
	text "ELM: I think"
	line "that's a great"
	cont "#MON too!"
	done

ChoseStarterText2:
	text "ELM: Oh, oh no."
	line "That's not a"
	cont "good #MON!"
	done

ReceivedStarterText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

ElmDirectionsText1:
	text "MR.#MON lives a"
	line "little bit beyond"

	para "CHERRYGROVE, the"
	line "next city over."

	para "It's almost a"
	line "direct route"

	para "there, so you"
	line "can't miss it."

	para "But just in case,"
	line "here's my phone"

	para "number. Call me if"
	line "anything comes up!"
	done

ElmDirectionsText2:
	text "If your #MON is"
	line "hurt, you should"

	para "heal it with this"
	line "machine."

	para "Feel free to use"
	line "it anytime."
	done

ElmDirectionsText3:
	text "<PLAY_G>, I'm"
	line "counting on you!"
	done

GotElmsNumberText:
	text "<PLAYER> got ELM's"
	line "phone number."
	done

ElmDescribesMrPokemonText:
	text "MR.#MON goes"
	line "everywhere and"
	cont "finds rarities."

	para "Too bad they're"
	line "just rare and"
	cont "not very useful…"
	done

ElmPokeBallText:
	text "It contains a"
	line "#MON caught by"
	cont "PROF.ELM."
	done

ElmsLabHealingMachineText1:
	text "I wonder what this"
	line "does?"
	done

ElmsLabHealingMachineText2:
	text "Would you like to"
	line "heal your #MON?"
	done

ElmAfterTheftText1:
	text "ELM: <PLAY_G>, this"
	line "is terrible…"

	para "Oh, yes, what was"
	line "MR.#MON's big"
	cont "discovery?"
	done

ElmAfterTheftText2:
	text "<PLAYER> handed"
	line "the MYSTERY EGG to"
	cont "PROF.ELM."
	done

ElmAfterTheftText3:
	text "ELM: This?"
	done

ElmAfterTheftText4:
	text "But… Is it a"
	line "#MON EGG?"

	para "If it is, it is a"
	line "great discovery!"
	done

ElmAfterTheftText5:
	text "ELM: What?!?"

	para "PROF.OAK gave you"
	line "a #DEX?"

	para "<PLAY_G>, is that"
	line "true? Th-that's"
	cont "incredible!"

	para "He is superb at"
	line "seeing the poten-"
	cont "tial of people as"
	cont "trainers."

	para "Wow, <PLAY_G>. You"
	line "may have what it"

	para "takes to become"
	line "the CHAMPION."

	para "You seem to be"
	line "getting on great"
	cont "with #MON too."

	para "You should take"
	line "the #MON GYM"
	cont "challenge."

	para "The closest GYM"
	line "would be the one"
	cont "in VIOLET CITY."
	done

ElmAfterTheftText6:
	text "…<PLAY_G>. The"
	line "road to the"

	para "championship will"
	line "be a long one."

	para "Before you leave,"
	line "make sure that you"
	cont "talk to your mom."
	done

ElmStudyingEggText:
	text "ELM: Don't give"
	line "up! I'll call if"

	para "I learn anything"
	line "about that EGG!"
	done

ElmAideHasEggText:
	text "ELM: <PLAY_G>?"
	line "Didn't you meet my"
	cont "assistant?"

	para "He should have met"
	line "you with the EGG"

	para "at VIOLET CITY's"
	line "#MON CENTER."

	para "You must have just"
	line "missed him. Try to"
	cont "catch him there."
	done

ElmWaitingEggHatchText:
	text "ELM: Hey, has that"
	line "EGG changed any?"
	done

ElmThoughtEggHatchedText:
	text "<PLAY_G>? I thought"
	line "the EGG hatched."

	para "Where is the"
	line "#MON?"
	done

ShowElmTogepiText1:
	text "ELM: <PLAY_G>, you"
	line "look great!"
	done

ShowElmTogepiText2:
	text "What?"
	line "That #MON!?!"
	done

ShowElmTogepiText3:
	text "The EGG hatched!"
	line "So, #MON are"
	cont "born from EGGS…"

	para "No, perhaps not"
	line "all #MON are."

	para "Wow, there's still"
	line "a lot of research"
	cont "to be done."
	done

ElmGiveEverstoneText1:
	text "Thanks, <PLAY_G>!"
	line "You're helping"

	para "unravel #MON"
	line "mysteries for us!"

	para "I want you to have"
	line "this as a token of"
	cont "our appreciation."
	done

ElmGiveEverstoneText2:
	text "That's an"
	line "EVERSTONE."

	para "Some species of"
	line "#MON evolve"

	para "when they grow to"
	line "certain levels."

	para "A #MON holding"
	line "the EVERSTONE"
	cont "won't evolve."

	para "Give it to a #-"
	line "MON you don't want"
	cont "to evolve."
	done

ElmText_CallYou:
	text "ELM: <PLAY_G>, I'll"
	line "call you if any-"
	cont "thing comes up."
	done

AideText_AfterTheft:
	text "…sigh… That"
	line "stolen #MON."

	para "I wonder how it's"
	line "doing."

	para "They say a #MON"
	line "raised by a bad"

	para "person turns bad"
	line "itself."
	done

ElmGiveMasterBallText1:
	text "ELM: Hi, <PLAY_G>!"
	line "Thanks to you, my"

	para "research is going"
	line "great!"

	para "Take this as a"
	line "token of my"
	cont "appreciation."
	done

ElmGiveMasterBallText2:
	text "The MASTER BALL is"
	line "the best!"

	para "It's the ultimate"
	line "BALL! It'll catch"

	para "any #MON with-"
	line "out fail."

	para "It's given only to"
	line "recognized #MON"
	cont "researchers."

	para "I think you can"
	line "make much better"

	para "use of it than I"
	line "can, <PLAY_G>!"
	done

ElmGiveTicketText1:
	text "ELM: <PLAY_G>!"
	line "There you are!"

	para "I called because I"
	line "have something for"
	cont "you."

	para "See? It's an"
	line "S.S.TICKET."

	para "Now you can catch"
	line "#MON in KANTO."
	done

ElmGiveTicketText2:
	text "The ship departs"
	line "from OLIVINE CITY."

	para "But you knew that"
	line "already, <PLAY_G>."

	para "After all, you've"
	line "traveled all over"
	cont "with your #MON."

	para "Give my regards to"
	line "PROF.OAK in KANTO!"
	done

ElmsLabMonEggText: ; unreferenced
	text "It's the #MON"
	line "EGG being studied"
	cont "by PROF.ELM."
	done

AideText_GiveYouPotion:
	text "<PLAY_G>, I want"
	line "you to have this"
	cont "for your errand."
	done

AideText_AlwaysBusy:
	text "There are only two"
	line "of us, so we're"
	cont "always busy."
	done

AideText_TheftTestimony:
	text "There was a loud"
	line "noise outside…"

	para "When we went to"
	line "look, someone"
	cont "stole a #MON."

	para "It's unbelievable"
	line "that anyone would"
	cont "do that!"

	para "…sigh… That"
	line "stolen #MON."

	para "I wonder how it's"
	line "doing."

	para "They say a #MON"
	line "raised by a bad"

	para "person turns bad"
	line "itself."
	done

AideText_GiveYouBalls:
	text "<PLAY_G>!"

	para "Use these on your"
	line "#DEX quest!"
	done

AideText_ExplainBalls:
	text "To add to your"
	line "#DEX, you have"
	cont "to catch #MON."

	para "Throw # BALLS"
	line "at wild #MON"
	cont "to get them."
	done

ElmsLabOfficerText1:
	text "I heard a #MON"
	line "was stolen here…"

	para "I was just getting"
	line "some information"
	cont "from PROF.ELM."

	para "Apparently, it was"
	line "a young male with"
	cont "long, red hair…"

	para "What?"

	para "You battled a"
	line "trainer like that?"

	para "Did you happen to"
	line "get his name?"
	done

ElmsLabOfficerText2:
	text "OK! So <RIVAL>"
	line "was his name."

	para "Thanks for helping"
	line "my investigation!"
	done

ElmsLabWindowText1:
	text "The window's open."

	para "A pleasant breeze"
	line "is blowing in."
	done

ElmsLabWindowText2:
	text "He broke in"
	line "through here!"
	done

ElmsLabTravelTip1Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 1:"

	para "Press START to"
	line "open the MENU."
	done

ElmsLabTravelTip2Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 2:"

	para "Record your trip"
	line "with SAVE!"
	done

ElmsLabTravelTip3Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 3:"

	para "Open your PACK and"
	line "press SELECT to"
	cont "move items."
	done

ElmsLabTravelTip4Text:
	text "<PLAYER> opened a"
	line "book."

	para "Travel Tip 4:"

	para "Check your #MON"
	line "moves. Press the"

	para "A Button to switch"
	line "moves."
	done

ElmsLabTrashcanText:
	text "The wrapper from"
	line "the snack PROF.ELM"
	cont "ate is in there…"
	done

ElmsLabPCText:
	text "OBSERVATIONS ON"
	line "#MON EVOLUTION"

	para "…It says on the"
	line "screen…"
	done

ElmsLabText_AskAboutHMFriends:
	text "Do you want"
	line "the HM Friends"
	cont "to be guaranteed"
	cont "first encounters"
	para "and to be caught"
	line "first ball?"
	done
	
ElmsLabText_AskAboutHMFriendsYes:
	text "On ROUTES 33,"
	line "34, and ILEX"
	cont "FOREST, your"
	cont "first encounters"
	cont "will be fixed."
	done
	
ElmsLabText_AskAboutHMFriendsNo:
	text "The HM Friends"
	line "will be random"
	cont "encounters."
	done
	


ElmsLab_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, NEW_BARK_TOWN, 1
	warp_event  5, 11, NEW_BARK_TOWN, 1

	def_coord_events
	coord_event  4,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  5,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  4,  5, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript
	coord_event  5,  5, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript2
	coord_event  4,  8, SCENE_ELMSLAB_AIDE_GIVES_POTION, AideScript_WalkPotion1
	coord_event  5,  8, SCENE_ELMSLAB_AIDE_GIVES_POTION, AideScript_WalkPotion2
	coord_event  4,  8, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS, AideScript_WalkBalls1
	coord_event  5,  8, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS, AideScript_WalkBalls2

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ElmsLabHealingMachine
	bg_event  6,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  7,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  8,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  0,  7, BGEVENT_READ, ElmsLabTravelTip1
	bg_event  1,  7, BGEVENT_READ, ElmsLabTravelTip2
	bg_event  2,  7, BGEVENT_READ, ElmsLabTravelTip3
	bg_event  3,  7, BGEVENT_READ, ElmsLabTravelTip4
	bg_event  6,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  7,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  8,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  3, BGEVENT_READ, ElmsLabTrashcan
	bg_event  5,  0, BGEVENT_READ, ElmsLabWindow
	bg_event  3,  5, BGEVENT_DOWN, ElmsLabPC
	bg_event  2,  5, BGEVENT_DOWN, ElmsLabRandomizeStarters
	bg_event  3,  1, BGEVENT_READ, ElmsLabStarterChoice
	bg_event  1,  2, BGEVENT_READ, ElmsLabExtraOptions
	
	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, -1
	object_event  2,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ElmsAideScript, EVENT_ELMS_AIDE_IN_LAB
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  5,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CopScript, EVENT_COP_IN_ELMS_LAB
	object_event  5,  1, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Gen1TMRelearnerScript, -1

