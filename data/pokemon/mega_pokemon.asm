MegaEvolvePokemon:
	ld a, 1
	ld [wSetMegaEvolutionPicture], a
	ld hl, wBattleMonMaxHP     ; Load address of wBattleMonMaxHP
    ld a, [hl]                 ; Load low byte
    ld [wBackupMaxHP], a         ; Store low byte in temporary location
    inc hl                     ; Move to high byte
    ld a, [hl]                 ; Load high byte
    ld [wBackupMaxHP + 1], a     ; Store high byte in temporary location
	
	call GetMegaEvolutionStats

	ld a, [wBaseType1]
	ld [wBattleMonType1], a
	
	ld a, [wBaseType2]
	ld [wBattleMonType2], a
	
	ld a, [wBattleMonLevel]
	ld [wCurPartyLevel], a
	
	ld hl, wPartyMon1StatExp
	ld de, wBattleMonMaxHP
	ld b, TRUE
	predef CalcMonStats
	push hl
	push de
	push bc
	ld hl, wBattleMonAttack
	ld de, wPlayerStats
	ld bc, PARTYMON_STRUCT_LENGTH - MON_ATK
	call CopyBytes
	farcall ApplyStatusEffectOnPlayerStats
	farcall BadgeStatBoosts
	pop hl
	pop de
	pop bc
	
	ld hl, wBackupMaxHP     ; Load address of wBattleMonMaxHP
    ld a, [hl]                 ; Load low byte
    ld [wBattleMonMaxHP], a         ; Store low byte in temporary location
    inc hl                     ; Move to high byte
    ld a, [hl]                 ; Load high byte
    ld [wBattleMonMaxHP + 1], a     ; Store high byte in temporary location
	
	ld a, [wAlreadyMegaEvolved]
	and a
	ret nz
	
	ld a, 1
	ld [wAlreadyMegaEvolved], a
	farcall SendOutPlayerMon
	ld c, 40
	call DelayFrames
	ld hl, MegaEvolvedText
	call StdBattleTextbox
	ret


CheckIfMonIsInMegaList:
	ld hl, MegaPokemonList
	call IsInByteArray
	jr nc, .not_in_array
	ld a, 1
	ret	
.not_in_array
	xor a
	ret
	


MegaPokemonList:
	db VENUSAUR
	db CHARIZARD
	db BLASTOISE
	db BEEDRILL
	db PIDGEOT
	db ALAKAZAM
	db SLOWBRO
	db GENGAR
	db KANGASKHAN
	db PINSIR
	db GYARADOS
	db AERODACTYL
	db MEWTWO
	db AMPHAROS
	db STEELIX
	db SCIZOR
	db HERACROSS
	db HOUNDOOM
	db TYRANITAR
	db ALTARIA
	db -1

GetMegaEvolutionStats:
	ld a, [wBattleMonSpecies]
	cp VENUSAUR
	jp z, .Venusaur
	cp CHARIZARD
	jp z, .Charizard
	cp BLASTOISE
	jp z, .Blastoise
	cp BEEDRILL
	jp z, .Beedrill
	cp PIDGEOT
	jp z, .Pidgeot
	cp ALAKAZAM
	jp z, .Alakazam
	cp SLOWBRO
	jp z, .Slowbro
	cp GENGAR
	jp z, .Gengar
	cp KANGASKHAN
	jp z, .Kangaskhan
	cp PINSIR
	jp z, .Pinsir
	cp GYARADOS
	jp z, .Gyarados
	cp AERODACTYL
	jp z, .Aerodactyl
	cp MEWTWO
	jp z, .Mewtwo
	cp AMPHAROS
	jp z, .Ampharos
	cp STEELIX
	jp z, .Steelix
	cp SCIZOR
	jp z, .Scizor
	cp HERACROSS
	jp z, .Heracross
	cp HOUNDOOM
	jp z, .Houndoom
	cp TYRANITAR
	jp z, .Tyranitar
	cp ALTARIA
	jp z, .Altaria
	ret

.Venusaur
	ld a, 80
	ld [wBaseHP], a
	ld a, 100
	ld [wBaseAttack], a
	ld a, 123
	ld [wBaseDefense], a
	ld a, 80
	ld [wBaseSpeed], a
	ld a, 122
	ld [wBaseSpecialAttack], a
	ld a, 120
	ld [wBaseSpecialDefense], a
	ld a, GRASS
	ld [wBaseType1], a
	ld a, POISON
	ld [wBaseType2], a
	ret
.Charizard
	ld a, [wMegaXorY]
	dec a
	and a
	jr z, .CharizardY
	ld a, 78
	ld [wBaseHP], a
	ld a, 130
	ld [wBaseAttack], a
	ld a, 111
	ld [wBaseDefense], a
	ld a, 100
	ld [wBaseSpeed], a
	ld a, 130
	ld [wBaseSpecialAttack], a
	ld a, 85
	ld [wBaseSpecialDefense], a
	ld a, FIRE
	ld [wBaseType1], a
	ld a, DRAGON
	ld [wBaseType2], a
	ret
.CharizardY
	ld a, 78
	ld [wBaseHP], a
	ld a, 104
	ld [wBaseAttack], a
	ld a, 78
	ld [wBaseDefense], a
	ld a, 100
	ld [wBaseSpeed], a
	ld a, 159
	ld [wBaseSpecialAttack], a
	ld a, 115
	ld [wBaseSpecialDefense], a
	ld a, FIRE
	ld [wBaseType1], a
	ld a, FLYING
	ld [wBaseType2], a
	ret

.Blastoise
	ld a, 79
	ld [wBaseHP], a
	ld a, 103
	ld [wBaseAttack], a
	ld a, 120
	ld [wBaseDefense], a
	ld a, 78
	ld [wBaseSpeed], a
	ld a, 135
	ld [wBaseSpecialAttack], a
	ld a, 115
	ld [wBaseSpecialDefense], a
	ld a, WATER
	ld [wBaseType1], a
	ld a, WATER
	ld [wBaseType2], a
	ret
.Beedrill
	ld a, 65
	ld [wBaseHP], a
	ld a, 150
	ld [wBaseAttack], a
	ld a, 40
	ld [wBaseDefense], a
	ld a, 145
	ld [wBaseSpeed], a
	ld a, 15
	ld [wBaseSpecialAttack], a
	ld a, 80
	ld [wBaseSpecialDefense], a
	ld a, BUG
	ld [wBaseType1], a
	ld a, POISON
	ld [wBaseType2], a
	ret
.Pidgeot
	ld a, 83
	ld [wBaseHP], a
	ld a, 80
	ld [wBaseAttack], a
	ld a, 80
	ld [wBaseDefense], a
	ld a, 121
	ld [wBaseSpeed], a
	ld a, 135
	ld [wBaseSpecialAttack], a
	ld a, 80
	ld [wBaseSpecialDefense], a
	ld a, NORMAL
	ld [wBaseType1], a
	ld a, FLYING
	ld [wBaseType2], a
	ret
.Alakazam
	ld a, 55
	ld [wBaseHP], a
	ld a, 50
	ld [wBaseAttack], a
	ld a, 65
	ld [wBaseDefense], a
	ld a, 150
	ld [wBaseSpeed], a
	ld a, 175
	ld [wBaseSpecialAttack], a
	ld a, 95
	ld [wBaseSpecialDefense], a
	ld a, PSYCHIC_TYPE
	ld [wBaseType1], a
	ld a, PSYCHIC_TYPE
	ld [wBaseType2], a
	ret
.Slowbro
	ld a, 95
	ld [wBaseHP], a
	ld a, 75
	ld [wBaseAttack], a
	ld a, 180
	ld [wBaseDefense], a
	ld a, 30
	ld [wBaseSpeed], a
	ld a, 130
	ld [wBaseSpecialAttack], a
	ld a, 80
	ld [wBaseSpecialDefense], a
	ld a, WATER
	ld [wBaseType1], a
	ld a, PSYCHIC_TYPE
	ld [wBaseType2], a
	ret
.Gengar
	ld a, 60
	ld [wBaseHP], a
	ld a, 65
	ld [wBaseAttack], a
	ld a, 80
	ld [wBaseDefense], a
	ld a, 130
	ld [wBaseSpeed], a
	ld a, 170
	ld [wBaseSpecialAttack], a
	ld a, 95
	ld [wBaseSpecialDefense], a
	ld a, GHOST
	ld [wBaseType1], a
	ld a, POISON
	ld [wBaseType2], a
	ret
.Kangaskhan
	ld a, 105
	ld [wBaseHP], a
	ld a, 125
	ld [wBaseAttack], a
	ld a, 100
	ld [wBaseDefense], a
	ld a, 100
	ld [wBaseSpeed], a
	ld a, 60
	ld [wBaseSpecialAttack], a
	ld a, 100
	ld [wBaseSpecialDefense], a
	ld a, NORMAL
	ld [wBaseType1], a
	ld a, NORMAL
	ld [wBaseType2], a
	ret
.Pinsir
	ld a, 65
	ld [wBaseHP], a
	ld a, 155
	ld [wBaseAttack], a
	ld a, 120
	ld [wBaseDefense], a
	ld a, 105
	ld [wBaseSpeed], a
	ld a, 65
	ld [wBaseSpecialAttack], a
	ld a, 90
	ld [wBaseSpecialDefense], a
	ld a, BUG
	ld [wBaseType1], a
	ld a, FLYING
	ld [wBaseType2], a
	ret
.Gyarados
	ld a, 95
	ld [wBaseHP], a
	ld a, 155
	ld [wBaseAttack], a
	ld a, 109
	ld [wBaseDefense], a
	ld a, 81
	ld [wBaseSpeed], a
	ld a, 70
	ld [wBaseSpecialAttack], a
	ld a, 130
	ld [wBaseSpecialDefense], a
	ld a, WATER
	ld [wBaseType1], a
	ld a, DARK
	ld [wBaseType2], a
	ret
.Aerodactyl
	ld a, 80
	ld [wBaseHP], a
	ld a, 135
	ld [wBaseAttack], a
	ld a, 85
	ld [wBaseDefense], a
	ld a, 150
	ld [wBaseSpeed], a
	ld a, 70
	ld [wBaseSpecialAttack], a
	ld a, 95
	ld [wBaseSpecialDefense], a
	ld a, ROCK
	ld [wBaseType1], a
	ld a, FLYING
	ld [wBaseType2], a
	ret
.Mewtwo
	ld a, [wMegaXorY]
	dec a
	and a
	jr z, .MewtwoY
	ld a, 106
	ld [wBaseHP], a
	ld a, 150
	ld [wBaseAttack], a
	ld a, 70
	ld [wBaseDefense], a
	ld a, 140
	ld [wBaseSpeed], a
	ld a, 194
	ld [wBaseSpecialAttack], a
	ld a, 120
	ld [wBaseSpecialDefense], a
	ld a, PSYCHIC_TYPE
	ld [wBaseType1], a
	ld a, FIGHTING
	ld [wBaseType2], a
	ret
.MewtwoY
	ld a, 106
	ld [wBaseHP], a
	ld a, 190
	ld [wBaseAttack], a
	ld a, 100
	ld [wBaseDefense], a
	ld a, 130
	ld [wBaseSpeed], a
	ld a, 154
	ld [wBaseSpecialAttack], a
	ld a, 100
	ld [wBaseSpecialDefense], a
	ld a, PSYCHIC_TYPE
	ld [wBaseType1], a
	ld a, PSYCHIC_TYPE
	ld [wBaseType2], a
	ret
.Ampharos
	ld a, 90
	ld [wBaseHP], a
	ld a, 95
	ld [wBaseAttack], a
	ld a, 105
	ld [wBaseDefense], a
	ld a, 45
	ld [wBaseSpeed], a
	ld a, 165
	ld [wBaseSpecialAttack], a
	ld a, 110
	ld [wBaseSpecialDefense], a
	ld a, ELECTRIC
	ld [wBaseType1], a
	ld a, DRAGON
	ld [wBaseType2], a
	ret
.Steelix
	ld a, 75
	ld [wBaseHP], a
	ld a, 125
	ld [wBaseAttack], a
	ld a, 230
	ld [wBaseDefense], a
	ld a, 30
	ld [wBaseSpeed], a
	ld a, 55
	ld [wBaseSpecialAttack], a
	ld a, 95
	ld [wBaseSpecialDefense], a
	ld a, STEEL
	ld [wBaseType1], a
	ld a, GROUND
	ld [wBaseType2], a
	ret
.Scizor
	ld a, 70
	ld [wBaseHP], a
	ld a, 150
	ld [wBaseAttack], a
	ld a, 140
	ld [wBaseDefense], a
	ld a, 75
	ld [wBaseSpeed], a
	ld a, 65
	ld [wBaseSpecialAttack], a
	ld a, 100
	ld [wBaseSpecialDefense], a
	ld a, BUG
	ld [wBaseType1], a
	ld a, STEEL
	ld [wBaseType2], a
	ret
.Heracross
	ld a, 80
	ld [wBaseHP], a
	ld a, 185
	ld [wBaseAttack], a
	ld a, 115
	ld [wBaseDefense], a
	ld a, 75
	ld [wBaseSpeed], a
	ld a, 40
	ld [wBaseSpecialAttack], a
	ld a, 105
	ld [wBaseSpecialDefense], a
	ld a, BUG
	ld [wBaseType1], a
	ld a, FIGHTING
	ld [wBaseType2], a
	ret
.Houndoom
	ld a, 75
	ld [wBaseHP], a
	ld a, 90
	ld [wBaseAttack], a
	ld a, 90
	ld [wBaseDefense], a
	ld a, 115
	ld [wBaseSpeed], a
	ld a, 140
	ld [wBaseSpecialAttack], a
	ld a, 90
	ld [wBaseSpecialDefense], a
	ld a, DARK
	ld [wBaseType1], a
	ld a, FIRE
	ld [wBaseType2], a
	ret
.Tyranitar
	ld a, 100
	ld [wBaseHP], a
	ld a, 164
	ld [wBaseAttack], a
	ld a, 150
	ld [wBaseDefense], a
	ld a, 71
	ld [wBaseSpeed], a
	ld a, 95
	ld [wBaseSpecialAttack], a
	ld a, 120
	ld [wBaseSpecialDefense], a
	ld a, ROCK
	ld [wBaseType1], a
	ld a, DARK
	ld [wBaseType2], a
	ret
.Altaria
	ld a, 75
	ld [wBaseHP], a
	ld a, 110
	ld [wBaseAttack], a
	ld a, 110
	ld [wBaseDefense], a
	ld a, 80
	ld [wBaseSpeed], a
	ld a, 110
	ld [wBaseSpecialAttack], a
	ld a, 110
	ld [wBaseSpecialDefense], a
	ld a, DRAGON
	ld [wBaseType1], a
	ld a, FAIRY_S
	ld [wBaseType2], a
	ret