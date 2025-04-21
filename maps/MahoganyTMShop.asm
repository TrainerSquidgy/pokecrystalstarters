	object_const_def
	const MAHOGANYTMSHOP_ROCKET1
	const MAHOGANYTMSHOP_ROCKET2
	const MAHOGANYTMSHOP_ROCKET3
	const MAHOGANYTMSHOP_ROCKET4
	const MAHOGANYTMSHOP_ROCKET5
	const MAHOGANYTMSHOP_COOLTRAINERM

MahoganyTMShop_MapScripts:
	def_scene_scripts
	def_callbacks

MahoganyMartCooltrainerMScript:
	faceplayer
	opentext
	special PlaceMoneyTopRight
	writetext MahoganyMartCooltrainerMMoneyAsk
	yesorno
	iftrue .GiveMoney
	writetext MahoganyMartCooltrainerMMoneyNo
	sjump .Merge
.GiveMoney
	writetext MahoganyMartCooltrainerMMoneyYes
	givemoney YOUR_MONEY, 100000
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
.Merge
	waitbutton
	closetext
	end
	
MahoganyMartCooltrainerMMoneyAsk:
	text "Need some extra"
	line "funds for TMs?"
	done

MahoganyMartCooltrainerMMoneyNo:
	text "Never mind, I'll"
	line "hold on to it."
	done
	
MahoganyMartCooltrainerMMoneyYes:
	text "There you go,"
	line "that should help."
	done
	
	
MahoganyMartTMShopScript1:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_TMS1
	closetext
	end

MahoganyMartTMShopScript2:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_TMS2
	closetext
	end

MahoganyMartTMShopScript3:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_TMS3
	closetext
	end

MahoganyMartTMShopScript4:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_TMS4
	closetext
	end

MahoganyMartTMShopScript5:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_TMS5
	closetext
	end

MahoganyMartTMShop:
	jumptextfaceplayer MahoganyMartTMShopText

MahoganyMartTMShopText:
	text "For all your"
	line "dodgy TM needs!"

	para "MAHOGANY"
	line "   TM SUPPLIES"
	done

MahoganyTMShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11,  0, MAHOGANY_MART_1F, 4
	def_coord_events

	def_bg_events
	bg_event 10,  0, BGEVENT_READ, MahoganyMartTMShop

	def_object_events
	object_event  3,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript1, -1
	object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript2, -1
	object_event  5,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript3, -1
	object_event  6,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript4, -1
	object_event  7,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript5, -1
	object_event  7,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MahoganyMartCooltrainerMScript, -1

