	db KLAWF ; 128

	db  70, 100, 115,  75,  35,  55
	;   hp  atk  def  spd  sat  sdf

	db ROCK, ROCK ; type
	db 120 ; catch rate
	db 158 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 35 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/klawf/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_3, EGG_WATER_3 ; egg groups

	; tm/hm learnset
	tmhm CURSE, TOXIC, ROCK_SMASH, HIDDEN_POWER, SUNNY_DAY, SNORE, HYPER_BEAM, PROTECT, RAIN_DANCE, ENDURE, FRUSTRATION, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, SANDSTORM, REST, ATTRACT, THIEF
	; end
