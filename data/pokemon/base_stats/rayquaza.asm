	db RAYQUAZA ; 149

	db  105, 150,  90,  95, 150,  90
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, FLYING ; type
	db 3 ; catch rate
	db 220 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 120 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/rayquaza/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, CURSE, ROAR, TOXIC, ROCK_SMASH, PSYCH_UP, HIDDEN_POWER, SUNNY_DAY, SNORE, BLIZZARD, HYPER_BEAM, ICY_WIND, PROTECT, RAIN_DANCE, ENDURE, FRUSTRATION, SOLARBEAM, IRON_TAIL, THUNDER, EARTHQUAKE, RETURN, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, SANDSTORM, FIRE_BLAST, SWIFT, REST, ATTRACT, FURY_CUTTER, FLY, SURF, STRENGTH, WHIRLPOOL, WATERFALL, FLAMETHROWER, ICE_BEAM, THUNDERBOLT
	; end
