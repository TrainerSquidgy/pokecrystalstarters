	db BLACEPHALN ; 150

	db  53, 127,  53, 107, 151,  79
	;   hp  atk  def  spd  sat  sdf

	db FIRE, GHOST ; type
	db 30 ; catch rate
	db 255 ; base exp
	db NO_ITEM, BERSERK_GENE ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 120 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/blacephaln/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, SNORE, HYPER_BEAM, PROTECT, ENDURE, FRUSTRATION, SOLARBEAM, RETURN, PSYCHIC_M, SHADOW_BALL, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, FIRE_BLAST, REST, ATTRACT, THIEF, FIRE_PUNCH, FLAMETHROWER
	; end
