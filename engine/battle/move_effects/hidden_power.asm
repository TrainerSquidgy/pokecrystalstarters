BattleCommand_HiddenPower:
	ld a, [wAttackMissed]
	and a
	ret nz
	ld a, [wWhichHiddenPower]
	and a
	jr nz, .PLAHiddenPower
	farcall HiddenPowerDamage
	ret
.PLAHiddenPower
	farcall BattleCommand_PLAHiddenPower
	ld a, 50
	push af
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
	pop af
	ld [hl], a
	call BattleCommand_DamageStats
	ret