	db ABQA ; 252

	db 130, 136, 132, 141, 147, 147
	;   hp  atk  def  spd  sat sdf

	db GHOST, NORMAL ; type
	db 110 ; catch rate
	db 185 ; base exp
	db BERRY, BERRY ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN  "gfx/pokemon/abqa/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_TOO_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm  CURSE, TOXIC, HIDDEN_POWER, SNORE, PROTECT, ENDURE, FRUSTRATION,      	      RETURN, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, REST, ATTRACT, THUNDERBOLT
        ; end

