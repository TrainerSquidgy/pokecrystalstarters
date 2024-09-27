BattleCommand_StoreEnergy:
BattleCommand_UnleashEnergy:
	ld a, 1
	ld [wAttackMissed], a
	ret
	
