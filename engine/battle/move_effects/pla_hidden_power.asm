BattleCommand_PLAHiddenPower:
	ld hl, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, HiddenPowerCheckTypeMatchup
	ld hl, wBattleMonType1
	; fallthrough
HiddenPowerCheckTypeMatchup:
; BUG: AI makes a false assumption about CheckTypeMatchup (see docs/bugs_and_glitches.md)
	push hl
	push de
	push bc
	call HiddenPowerTypesLoop
	ld d, a
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld a, EFFECTIVE
	ld [wTypeMatchup], a
	push af
	ld hl, TypeMatchups
	ld a, [wInverseActivated]
	and a
	jr z, .got_inverted
	ld hl, InverseTypeMatchups
.got_inverted
	pop af
.TypesLoop:
	call GetNextTypeMatchupsByte2
    inc hl
	cp -1
	jr z, .End
	cp -2
	jr nz, .Next
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .End
	jr .TypesLoop

.Next:
	cp d
	jr nz, .Nope
	call GetNextTypeMatchupsByte2
	inc hl
	cp b
	jr z, .Yup
	cp c
	jr z, .Yup
	jr .Nope2

.Nope:
	inc hl
.Nope2:
	inc hl
	jr .TypesLoop

.Yup:
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call GetNextTypeMatchupsByte2
	inc hl
	ldh [hMultiplicand + 2], a
	ld a, [wTypeMatchup]
	ldh [hMultiplier], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	push bc
	ld b, 4
	call Divide
	pop bc
	ldh a, [hQuotient + 3]
	ld [wTypeMatchup], a
	jr .TypesLoop

.End:
	pop bc
	pop de
	pop hl
	push bc
	ld a, [wTypeMatchup]
	ld b, a
	ld a, [wTempHiddenPowerPower]
	cp b
	jr z, .randomcheck
	jr nc, .skipsaving
.randompass
	ld a, b
	ld [wTempHiddenPowerPower], a
	ld a, [wTempHiddenPowerType]
	ld [wHiddenPowerType], a
.skipsaving
	pop bc
	ld a, [wHiddenPowerLoop]
	cp 19
	jp nz, HiddenPowerCheckTypeMatchup
	ld a, [wHiddenPowerType]
	push af
	xor a
	ld [wHiddenPowerLoop], a
	ld [wTempHiddenPowerPower], a
	ld [wTempHiddenPowerType], a
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	pop af
	ld [hl], a
	ret

.randomcheck
	call Random
	cp 50 percent + 1
	jr c, .randompass
	jr .skipsaving
	
HiddenPowerTypesLoop:
	ld a, [wHiddenPowerLoop]
	inc a
	ld [wHiddenPowerLoop], a
	cp 1
	jr z, .Dark
	cp 2
	jr z, .Dragon
	cp 3
	jr z, .Ice
	cp 4
	jr z, .Psychic
	cp 5
	jr z, .Electric
	cp 6
	jr z, .Grass
	cp 7
	jr z, .Water
	cp 8
	jr z, .Fire
	cp 9
	jp z, .Steel
	cp 10
	jp z, .Ghost
	cp 11
	jp z, .Bug
	cp 12
	jp z, .Rock
	cp 13
	jp z, .Ground
	cp 14
	jp z, .Poison
	cp 15
	jp z, .Flying
	cp 16
	jp z, .Fighting
	cp 17
	jp z, .Fairy
	ret
.Dark
	ld a, DARK
	ld [wTempHiddenPowerType], a
	ret
.Dragon
	ld a, DRAGON
	ld [wTempHiddenPowerType], a
	ret
.Ice
	ld a, ICE
	ld [wTempHiddenPowerType], a
	ret
.Psychic
	ld a, PSYCHIC_TYPE
	ld [wTempHiddenPowerType], a
	ret
.Electric
	ld a, ELECTRIC
	ld [wTempHiddenPowerType], a
	ret
.Grass
	ld a, GRASS
	ld [wTempHiddenPowerType], a
	ret
.Water
	ld a, WATER
	ld [wTempHiddenPowerType], a
	ret
.Fire
	ld a, FIRE
	ld [wTempHiddenPowerType], a
	ret
.Steel
	ld a, STEEL
	ld [wTempHiddenPowerType], a
	ret
.Ghost
	ld a, GHOST
	ld [wTempHiddenPowerType], a
	ret
.Bug
	ld a, BUG
	ld [wTempHiddenPowerType], a
	ret
.Rock
	ld a, ROCK
	ld [wTempHiddenPowerType], a
	ret
.Ground
	ld a, GROUND
	ld [wTempHiddenPowerType], a
	ret
.Poison
	ld a, POISON
	ld [wTempHiddenPowerType], a
	ret
.Flying
	ld a, FLYING
	ld [wTempHiddenPowerType], a
	ret
.Fighting
	ld a, FIGHTING
	ld [wTempHiddenPowerType], a
	ret
.Fairy
	ld a, FAIRY_S
	ld [wTempHiddenPowerType], a
	ret
	
GetNextTypeMatchupsByte2:
   ld a, BANK(TypeMatchups)
   call GetFarByte
   ret
