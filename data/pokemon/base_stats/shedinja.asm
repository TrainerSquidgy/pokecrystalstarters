	db SHEDINJA ; 143

	db 1, 90,  45,  40,  30, 30
	;   hp  atk  def  spd  sat  sdf

	db BUG, GHOST ; type
	db 45 ; catch rate
	db 95 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 15 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/shedinja/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_ERRATIC ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, SNORE, HYPER_BEAM, PROTECT, GIGA_DRAIN, ENDURE, FRUSTRATION, SOLARBEAM, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, SANDSTORM, DREAM_EATER, REST, ATTRACT, THIEF, FURY_CUTTER, NIGHTMARE, CUT, FLASH
	; end
