	db IRON_BUNDLE 

	db  56,  80,  114,  136,  124,  60
	;   hp  atk  def  spd  sat  sdf

	db WATER, ICE ; type
	db 50 ; catch rate
	db 255 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 50 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/ironbundle/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SNORE, BLIZZARD, HYPER_BEAM, ICY_WIND, PROTECT, RAIN_DANCE, ENDURE, FRUSTRATION, RETURN, DOUBLE_TEAM, ICE_PUNCH, SWAGGER, SLEEP_TALK, SWIFT, REST, THIEF, ICE_BEAM
	; end
