BattleCommand_FuryCutter:
	ld hl, wPlayerFuryCutterCount
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyFuryCutterCount

.go
	ld a, [wAttackMissed]
	and a
	jp nz, ResetFuryCutterCount

	inc [hl]

; Damage capped at 5 turns' worth (16x).
	ld a, [hl]
	ld b, a
	cp 6
	jr c, .checkdouble
	ld b, 5

.checkdouble
	dec b
	ret z

; Double the damage
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .checkdouble

; No overflow
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

ResetFuryCutterCount:
	push hl

	ld hl, wPlayerFuryCutterCount
	ldh a, [hBattleTurn]
	and a
	jr z, .reset
	ld hl, wEnemyFuryCutterCount

.reset
	xor a
	ld [hl], a

	pop hl
	ret

BattleCommand_EchoedVoice:
	ld hl, wPlayerEchoedVoiceCount
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyEchoedVoiceCount

.go
	inc [hl]
	ld a, [hl]
	cp 5
	jr c, .loop
	ld a, 5
.loop
	dec a
	and a
	ret z
	call AddDamage
	jr .loop
	
	
AddDamage:
	push af
	push hl
    ld hl, wCurDamage+1  ; Point to the high byte of wCurDamage
    ld a, [hl]           ; Load the high byte of wCurDamage into A
    ld d, a              ; Store the high byte in D temporarily
    dec hl               ; Point to the low byte of wCurDamage
    ld a, [hl]           ; Load the low byte of wCurDamage into A
    ld e, a              ; Store the low byte in E temporarily

    ; Perform the addition of wCurDamage to itself
    ld hl, wCurDamage    ; Point to wCurDamage
    ld a, [hl]           ; Load the low byte of wCurDamage into A
    add a, e             ; Add the low byte of wCurDamage to itself
    ld [hl], a           ; Store the result back to the low byte of wCurDamage
    inc hl               ; Move to the high byte
    ld a, [hl]           ; Load the high byte of wCurDamage into A
    adc a, d             ; Add the high byte with carry (from low byte addition)
    ld [hl], a           ; Store the result back to the high byte of wCurDamage

    ; If overflow occurred, the carry flag would be set (overflow means too large for 16-bit)
    jr nc, .done         ; If no overflow, we're done

    ; Overflow handling: set wCurDamage to $FFFF (maximum 16-bit value)
    ld a, $FF            ; Load $FF into A
    ld hl, wCurDamage    ; Point back to wCurDamage
    ld [hl], a           ; Set low byte to $FF
    ld [hli], a         ; Set high byte to $FF

.done:
	pop hl
	pop af
    ret                  ; Return
