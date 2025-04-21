	object_const_def
	const MAHOGANYTMSHOP_ROCKET1
	const MAHOGANYTMSHOP_ROCKET2
	const MAHOGANYTMSHOP_ROCKET3
	const MAHOGANYTMSHOP_ROCKET4
	const MAHOGANYTMSHOP_ROCKET5

MahoganyTMShop_MapScripts:
	def_scene_scripts
	def_callbacks
	
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
	bg_event 14,  0, BGEVENT_READ, MahoganyMartTMShopText

	def_object_events
	object_event  2,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript1, -1
	object_event  3,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript2, -1
	object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript3, -1
	object_event  5,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript4, -1
	object_event  6,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMartTMShopScript5, -1

