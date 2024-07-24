ReadTrainerParty:
	ld a, [wInBattleTowerBattle]
	bit 0, a
	ret nz

	ld a, [wLinkMode]
	and a
	ret nz

	ld hl, wOTPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	xor a
	call ByteFill

	ld a, [wOtherTrainerClass]
	cp CAL
	jr nz, .not_cal2
	ld a, [wOtherTrainerID]
	cp CAL2
	jr z, .cal2
	ld a, [wOtherTrainerClass]
.not_cal2

	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOtherTrainerID]
	ld b, a
.skip_trainer
	dec b
	jr z, .got_trainer
.loop
	ld a, [hli]
	cp -1
	jr nz, .loop
	jr .skip_trainer
.got_trainer

.skip_name
	ld a, [hli]
	cp "@"
	jr nz, .skip_name

	ld a, [hli]
	ld c, a
	ld b, 0
	ld d, h
	ld e, l
	ld hl, TrainerTypes
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, .done
	push bc
	jp hl

.done
	jp ComputeTrainerReward

.cal2
	ld a, BANK(sMysteryGiftTrainer)
	call OpenSRAM
	ld de, sMysteryGiftTrainer
	call TrainerType2
	call CloseSRAM
	jr .done

TrainerTypes:
; entries correspond to TRAINERTYPE_* constants
	dw TrainerType1 ; level, species
	dw TrainerType2 ; level, species, moves
	dw TrainerType3 ; level, species, item
	dw TrainerType4 ; level, species, item, moves

TrainerType1:

; normal (level, species)
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z
	
	ld [wCurPartyLevel], a
	
	call ScaleTrainerEncounters
	
	ld a, [hli]
	ld [wCurPartySpecies], a
	
	call CheckForRivalMons
	
	call CheckIfTrainerShouldBeEvolved
	
	ld a, OTPARTYMON
	ld [wMonType], a
	push hl
	predef TryAddMonToParty
	pop hl
	jr .loop

TrainerType2:
; moves

	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	
	call ScaleTrainerEncounters
	
	ld a, [hli]
	ld [wCurPartySpecies], a
	
	call CheckIfTrainerShouldBeEvolved
	
	ld a, OTPARTYMON
	ld [wMonType], a

	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	
	
	
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	
	
	
	dec a
	ld hl, wOTPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de
	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl
	jr .loop

TrainerType3:
; item
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	
	call ScaleTrainerEncounters
	
	ld a, [hli]
	ld [wCurPartySpecies], a
	
	call CheckIfTrainerShouldBeEvolved
	
	ld a, OTPARTYMON
	ld [wMonType], a
	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	
	
	
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld [de], a
	jr .loop

TrainerType4:
; item + moves
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	
	call ScaleTrainerEncounters
	
	ld a, [hli]
	ld [wCurPartySpecies], a
	
	call CheckIfTrainerShouldBeEvolved

	ld a, OTPARTYMON
	ld [wMonType], a

	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	
	
	
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld a, [hli]
	ld [de], a

	push hl
	ld a, [wOTPartyCount]
	
	
	
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
		
	dec a
	ld hl, wOTPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl
	jp .loop

ComputeTrainerReward:
	ld hl, hProduct
	xor a
	ld [hli], a
	ld [hli], a ; hMultiplicand + 0
	ld [hli], a ; hMultiplicand + 1
	ld a, [wEnemyTrainerBaseReward]
	ld [hli], a ; hMultiplicand + 2
	ld a, [wCurPartyLevel]
	ld [hl], a ; hMultiplier
	call Multiply
	ld hl, wBattleReward
	xor a
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	ret

Battle_GetTrainerName::
	ld a, [wInBattleTowerBattle]
	bit 0, a
	ld hl, wOTPlayerName
	jp nz, CopyTrainerName

	ld a, [wOtherTrainerID]
	ld b, a
	ld a, [wOtherTrainerClass]
	ld c, a

GetTrainerName::
	ld a, c
	cp CAL
	jr nz, .not_cal2

	ld a, BANK(sMysteryGiftTrainerHouseFlag)
	call OpenSRAM
	ld a, [sMysteryGiftTrainerHouseFlag]
	and a
	call CloseSRAM
	jr z, .not_cal2

	ld a, BANK(sMysteryGiftPartnerName)
	call OpenSRAM
	ld hl, sMysteryGiftPartnerName
	call CopyTrainerName
	jp CloseSRAM

.not_cal2
	dec c
	push bc
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc

.loop
	dec b
	jr z, CopyTrainerName

.skip
	ld a, [hli]
	cp $ff
	jr nz, .skip
	jr .loop

CopyTrainerName:
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	call CopyBytes
	pop de
	ret

IncompleteCopyNameFunction: ; unreferenced
; Copy of CopyTrainerName but without "call CopyBytes"
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	pop de
	ret

INCLUDE "data/trainers/parties.asm"



ScaleTrainerEncounters:
	push hl
    ld hl, wJohtoBadges
    ld b, 2
    call CountSetBits
    ld a, [wNumSetBits]
    and a
    jr z, .nobadges
    ld c, a
    ld a, 5
    call SimpleMultiply
    jr .addrandom
.nobadges
    ld a, 5
.addrandom
    ld b, a
    ld a, 6
    call RandomRange
    add a, b    
    pop hl
    ld [wCurPartyLevel], a
	ret

CheckIfTrainerShouldBeEvolved::
    ld a, [wCurPartySpecies]
    dec a
    push hl
    push bc
    cp EEVEE - 1
    jp z, .eevee
    cp TYROGUE - 1
    jp z, .tyrogue
    ld c, a
    ld b, 0
    ld hl, EvosAttacksPointers
    add hl, bc
    add hl, bc
    ld a, BANK(EvosAttacksPointers)
    call GetFarHalf
    ld a, BANK("Evolutions and Attacks")
    call GetFarByte
    ld a, BANK("Evolutions and Attacks")
    call GetFarByte
    and a
    jp z, .done
.has_evolution
    inc hl
    cp EVOLVE_LEVEL
    jp nz, .not_level_up
    ld a, [wCurPartyLevel]
    ld b, a
    ld a, BANK("Evolutions and Attacks")
    call GetFarByte ; a = level for evolutions
    cp b
    jp nc, .lower
    inc hl
    ld a, BANK("Evolutions and Attacks")
    call GetFarByte ; a = evolved species
    pop bc
    pop hl
    ld [wCurPartySpecies], a
	jr CheckIfTrainerShouldBeEvolved
    ret

.eevee
    ld hl, .EeveeEvolutions
    ld a, 5
    jr .evolve_list
.tyrogue
    ld hl, .TyrogueEvolutions
    ld a, 3
.evolve_list
    call RandomRange
    ld b, 0
    ld c, a
    add hl, bc
    ld a, [hl]
    ld [wTestingRamSlot1], a
    pop bc
    pop hl
    jp .load_and_end

.not_level_up
    pop bc
	ld a, [wCurPartySpecies]
	ld b, a
    ld hl, .EvolveList
.search_list
    ld a, [hl]
    cp b
    jr z, .found_in_list
    inc hl
    inc hl
    inc hl
    jr .search_list

.found_in_list
    inc hl     ; Move to the first evolution option
    call Random
    cp 50
    jr c, .first_option
    inc hl     ; Move to the second evolution option if random >= 50
.first_option
    ld a, [hl]
    ld [wTempCompSpecies], a  ; Store evolved species in wTempWildMonSpecies
    ld [wCurPartySpecies], a  ; Store evolved species in wTempWildMonSpecies
    pop hl
    jp .load_and_end

.lower
.done
    ld a, 2
    ld [wTestingRamSlot1], a
    xor a
    pop bc
    pop hl
    ret
    pop hl
    ret
.load_and_end
    ret

.EvolveList:
    db PIKACHU,    PIKACHU,     RAICHU
    db NIDORINA,   NIDOQUEEN,  NIDOQUEEN
    db NIDORINO,   NIDOKING,   NIDOKING
    db CLEFAIRY,   CLEFAIRY,   CLEFABLE
    db VULPIX,     NINETALES,  NINETALES
    db JIGGLYPUFF, JIGGLYPUFF, WIGGLYTUFF
    db GLOOM,      VILEPLUME,  BELLOSSOM
    db GROWLITHE,  ARCANINE,   ARCANINE
    db POLIWHIRL,  POLIWRATH,  POLITOED
    db WEEPINBELL, VICTREEBEL, VICTREEBEL
    db SLOWPOKE,   SLOWBRO,    SLOWKING
    db SHELLDER,   CLOYSTER,   CLOYSTER
    db EXEGGCUTE,  EXEGGUTOR,  EXEGGUTOR
    db SEADRA,     KINGDRA,    KINGDRA
    db STARYU,     STARMIE,    STARMIE
    db PORYGON,    PORYGON2,   PORYGON2
    db SUNKERN,    SUNFLORA,   SUNFLORA
    db GOLBAT,     CROBAT,     CROBAT
    db CHANSEY,    BLISSEY,    BLISSEY
    db PICHU,      PIKACHU,    PIKACHU
    db CLEFFA,     CLEFAIRY,   CLEFAIRY
    db IGGLYBUFF,  JIGGLYPUFF, JIGGLYPUFF
    db TOGEPI,     TOGETIC,    TOGETIC

.EeveeEvolutions:
    db JOLTEON, VAPOREON, FLAREON, ESPEON, UMBREON

.TyrogueEvolutions:
    db HITMONLEE, HITMONCHAN, HITMONTOP
	
CheckForRivalMons:
	ld a, [wCurPartySpecies]
	cp CYNDAQUIL
	jr z, .cyndaquilball
	cp QUILAVA
	jr z, .cyndaquilball
	cp TYPHLOSION
	jr nz, .checktotodile
.cyndaquilball
	ld a, [wElmPokemon1]
	jr .merge
.checktotodile
	cp TOTODILE
	jr z, .totodileball
	cp CROCONAW
	jr z, .totodileball
	cp FERALIGATR
	jr nz, .checkchikorita
.totodileball
	ld a, [wElmPokemon2]
	jr .merge
.checkchikorita
	cp CHIKORITA
	jr z, .chikoritaball
	cp BAYLEEF
	jr z, .chikoritaball
	cp MEGANIUM
	ret nz
.chikoritaball
	ld a, [wElmPokemon3]
.merge
	ld [wCurPartySpecies], a
	ret