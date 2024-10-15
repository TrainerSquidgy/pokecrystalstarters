	WonderTrade::
	ld hl, .Text_WonderTradeQuestion
	call PrintText
	call YesNoBox
	ret c

	ld hl, .Text_WonderTradePrompt
	call PrintText

	ld b, 6
	farcall SelectTradeOrDayCareMon
	ret c

	ld a, [wCurPartySpecies]
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wStringBuffer1
	call CopyTradeName
	ld hl, .Text_WonderTradeConfirm
	call PrintText
	call YesNoBox
	ret c

	ld hl, .Text_WonderTradeSetup
	call PrintText

	call DoWonderTrade
	
	ld hl, .Text_WonderTradeReady
	call PrintText

	call DisableSpriteUpdates
	predef TradeAnimation
	call ReturnToMapWithSpeechTextbox

	ld hl, .Text_WonderTradeComplete
	call PrintText
	jp RestartMapMusic

.Text_WonderTradeQuestion:
	text_far WonderTradeQuestionText
	db "@"

.Text_WonderTradePrompt:
	text_far WonderTradePromptText
	db "@"

.Text_WonderTradeConfirm:
	text_far WonderTradeConfirmText
	db "@"

.Text_WonderTradeSetup:
	text_far WonderTradeSetupText
	db "@"

.Text_WonderTradeReady:
	text_far WonderTradeReadyText
	db "@"

.Text_WonderTradeComplete:
	text_far WonderTradeCompleteText
	text_asm
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld hl, .trade_done
	ret

.trade_done
	text_far WonderTradeDoneFanfare
	db "@"

DoWonderTrade:
	ld a, [wCurPartySpecies]
	ld [wPlayerTrademonSpecies], a
	
.random_trademon
	ld a, NUM_POKEMON - 1
	call RandomRange
	inc a
	ld [wOTTrademonSpecies], a
	call CheckValidLevel
	and a
	jr nz, .random_trademon
	ld a, [wPlayerTrademonSpecies]
	ld b, a
	ld a, [wOTTrademonSpecies]
	cp b
	jr z, .random_trademon

	ld a, [wPlayerTrademonSpecies]
	ld de, wPlayerTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonOTName
	call CopyTradeName

	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	call CopyTradeName

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonID
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld a, c
	ld [wPlayerTrademonCaughtData], a

	xor a
	ld [wOTTrademonCaughtData], a

	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	xor a
	ld [wMonType], a ; PARTYMON
	ld [wPokemonWithdrawDepositParameter], a ; REMOVE_PARTY
	callfar RemoveMonFromPartyOrBox
	predef TryAddMonToParty

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonNickname
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	call Random
	ld [wStringBuffer1], a
	call Random
	ld [wStringBuffer1 + 1], a
	ld hl, wStringBuffer1
	ld de, wOTTrademonID
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Trade_CopyTwoBytes

	call GetWonderTradeOTName
	push hl
	ld de, wOTTrademonOTName
	call CopyTradeName
	pop hl
	ld de, wOTTrademonSenderName
	call CopyTradeName

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call CopyTradeName

	call GetWonderTradeOTGender
	ld b, a

	farcall SetGiftPartyMonCaughtData

	; Random DVs
	call Random
	ld [wStringBuffer1], a
	call Random
	ld [wStringBuffer1 + 1], a
	ld hl, wStringBuffer1
	ld de, wOTTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld de, wOTTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	call GetWonderTradeHeldItem
	ld [de], a

.compute_trademon_stats
	push af
	push bc
	push de
	push hl
	ld a, [wCurPartyMon]
	push af
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall ComputeNPCTrademonStats
	pop af
	ld [wCurPartyMon], a
	pop hl
	pop de
	pop bc
	pop af
	ret


GetWonderTradeOTName:
; pick from WonderTradeOTNames1 if [wOTTrademonID] is even,
; WonderTradeOTNames2 if odd, using [wOTTrademonID+1] as the index.
	ld hl, wOTTrademonID
	ld a, [hli]
	and 1
	ld a, [hl]
	ld hl, WonderTradeOTNames1
	jr z, .ok
	ld hl, WonderTradeOTNames2
.ok
	lb bc, 0, PLAYER_NAME_LENGTH
	jp AddNTimes

INCLUDE "data/events/wonder_trade/ot_names.asm"

GetWonderTradeOTGender:
; pick from .WonderTradeOTGenders1 if [wOTTrademonID] is even,
; WonderTradeOTGenders2 if odd, using [wOTTrademonID+1] as the index.
	ld hl, wOTTrademonID
	ld a, [hli]
	and 1
	ld a, [hl]
	ld hl, WonderTradeOTGenders1
	jr z, .ok
	ld hl, WonderTradeOTGenders2
.ok
	ld c, a
;	ld b, CHECK_FLAG
;	predef FlagPredef
;	ld a, c
;	and a
;	ret z ; MALE
;	ld a, FEMALE
	ld b, 0
	add hl, bc
	ld a, [hl]
	ret

INCLUDE "data/events/wonder_trade/ot_genders.asm"


CheckValidLevel:
; Don't receive Pokémon outside a valid level range.
; Legendaries and other banned Pokémon have a "valid" range of 255 to 255.
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld d, a

	ld a, [wOTTrademonSpecies]
	ld hl, WonderTradeLevels
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc

	ld a, [hli]
	dec a
	cp d
	ret nc

	ld a, [hl]
	cp d
	ret c

	xor a
	ret

INCLUDE "data/pokemon/wonder_trade_levels.asm"

Trade_CopyThreeBytes:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret
	
GetWonderTradeHeldItem:
	ld hl, WonderTradeHeldItems
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	jr .loop
.ok
	ld a, [hli]
	cp -1
	ld a, NO_ITEM
	ret z
	ld a, [hli]
	ret
	
INCLUDE "data/events/wonder_trade/held_items.asm"


FillTrademonMovesFromIndicesbuffer: ; unreferenced
	ld hl, wPartyMon1Moves
	ld de, wListMoves_MoveIndicesBuffer
	ld b, NUM_MOVES
.loop
	ld a, [de]
	inc de
	ld [hli], a
	and a
	jr z, .clearpp

	push bc
	push hl

	push hl
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop hl

	ld bc, wPartyMon1PP - (wPartyMon1Moves + 1)
	add hl, bc
	ld [hl], a

	pop hl
	pop bc

	dec b
	jr nz, .loop
	ret

.clear
	xor a
	ld [hli], a

.clearpp
	push bc
	push hl
	ld bc, wPartyMon1PP - (wPartyMon1Moves + 1)
	add hl, bc
	xor a
	ld [hl], a
	pop hl
	pop bc
	dec b
	jr nz, .clear
	ret