ExtraBattleCommand_FakeOut:
	ret
	
FlinchTarget2:
	ret

	
ExtraBattleCommand_Frustration:
	; BUG: Return and Frustration deal no damage when the user's happiness is low or high, respectively (see docs/bugs_and_glitches.md)
	push bc
	ld hl, wBattleMonHappiness
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyMonHappiness
.ok
	ld a, $ff
	sub [hl]
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, 10
	ldh [hMultiplier], a
	call Multiply
	ld a, 25
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 3]
	ld d, a
	pop bc
	ret
	
EndMoveEffect2:
	ld a, [wBattleScriptBufferAddress]
	ld l, a
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, endmove_command
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret


SkipToBattleCommand2:
; Skip over commands until reaching command b.
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, [wBattleScriptBufferAddress]
	ld l, a
.loop
	ld a, [hli]
	cp b
	jr nz, .loop

	ld a, h
	ld [wBattleScriptBufferAddress + 1], a
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ret


ExtraBattleCommand_StoreEnergy:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_BIDE, a
	ret z

	ld hl, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .check_still_storing_energy
	ld hl, wEnemyRolloutCount
.check_still_storing_energy
	dec [hl]
	jr nz, .still_storing

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_BIDE, [hl]

	ld hl, UnleashedEnergyText
	call StdBattleTextbox

	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
	ld a, 1
	ld [hl], a
	ld hl, wPlayerDamageTaken + 1
	ld de, wPlayerCharging ; player
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld hl, wEnemyDamageTaken + 1
	ld de, wEnemyCharging ; enemy
.player
	ld a, [hld]
	add a
	ld b, a
	ld [wCurDamage + 1], a
	ld a, [hl]
	rl a
	ld [wCurDamage], a
	jr nc, .not_maxed
	ld a, $ff
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
.not_maxed
	or b
	jr nz, .built_up_something
	ld a, 1
	ld [wAttackMissed], a
.built_up_something
	xor a
	ld [hli], a
	ld [hl], a
	ld [de], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	ld a, BIDE
	ld [hl], a

	ld b, unleashenergy_command
	jp SkipToBattleCommand2
	ret

.still_storing
	ld hl, StoringEnergyText
	call StdBattleTextbox
	jp EndMoveEffect2
	ret
	
ExtraBattleCommand_UnleashEnergy:
	ld de, wPlayerDamageTaken
	ld bc, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_damage
	ld de, wEnemyDamageTaken
	ld bc, wEnemyRolloutCount
.got_damage
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_BIDE, [hl]
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld [wPlayerMoveStructEffect], a
	ld [wEnemyMoveStructEffect], a
	call BattleRandom
	and 1
	inc a
	inc a
	ld [bc], a
	ld a, 1
	ld [wBattleAnimParam], a
	call AnimateCurrentMove2
	jp EndMoveEffect2
	ret
	
AnimateCurrentMove2:
	push hl
	push de
	push bc
	ld a, [wBattleAnimParam]
	push af
	farcall BattleCommand_LowerSub
	pop af
	ld [wBattleAnimParam], a
	farcall LoadMoveAnim
	farcall BattleCommand_RaiseSub
	pop bc
	pop de
	pop hl
	ret
