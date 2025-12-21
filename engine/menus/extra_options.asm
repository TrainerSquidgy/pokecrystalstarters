; GetOptionPointer.Pointers indexes
    const_def
    const EXTRA_OPT_TEXT_SPEED    ; 0
    const EXTRA_OPT_BATTLE_SCENE  ; 1
    const EXTRA_OPT_BATTLE_STYLE  ; 2
    const EXTRA_OPT_SOUND         ; 3
    const EXTRA_OPT_PRINT         ; 4
    const EXTRA_OPT_MENU_ACCOUNT  ; 5
    const EXTRA_OPT_FRAME         ; 6
    const EXTRA_OPT_CANCEL        ; 7
DEF NUM_EXTRA_OPTIONS EQU const_value ; 8

_ExtraOption:
    ld hl, hInMenu
    ld a, [hl]
    push af
    ld [hl], TRUE
    call ClearBGPalettes
    hlcoord 0, 0
    ld b, SCREEN_HEIGHT - 2
    ld c, SCREEN_WIDTH - 2
    call Textbox
    hlcoord 2, 2
    ld de, StringExtraOptions
    call PlaceString
    xor a
    ld [wJumptableIndex], a

    ld c, NUM_EXTRA_OPTIONS
.print_text_loop
    push bc
    xor a
    ldh [hJoyLast], a
    call GetExtraOptionPointer
    pop bc
    ld hl, wJumptableIndex
    inc [hl]
    dec c
    jr nz, .print_text_loop

    xor a
    ld [wJumptableIndex], a
    inc a
    ldh [hBGMapMode], a
    call WaitBGMap
    ld b, SCGB_DIPLOMA
    call GetSGBLayout
    call SetDefaultBGPAndOBP

.joypad_loop
    call JoyTextDelay
    ldh a, [hJoyPressed]
    and START | B_BUTTON
    jr nz, .ExitExtraOptions
    call ExtraOptionsControl
    jr c, .dpad
    call GetExtraOptionPointer
    jr c, .ExitExtraOptions

.dpad
    call ExtraOptions_UpdateCursorPosition
    ld c, 3
    call DelayFrames
    jr .joypad_loop

.ExitExtraOptions:
    ld de, SFX_TRANSACTION
    call PlaySFX
    call WaitSFX
    pop af
    ldh [hInMenu], a
    ret

StringExtraOptions:
    db "HIDDEN POWER<LF>"
    db "        :<LF>"
    db "MOVE TUTORS<LF>"
    db "        :<LF>"
    db "FORCE HM FRIENDS<LF>"
    db "        :<LF>"
    db "ENABLE MEGA EVOS<LF>"
    db "        :<LF>"
    db "DISABLE EVOLUTION<LF>"
    db "        :<LF>"
    db "MENU ACCOUNT<LF>"
    db "        :<LF>"
    db "RIVAL CHANGES<LF>"
    db "        :<LF>"
    db "CANCEL@"

GetExtraOptionPointer:
    jumptable .ExtraPointers, wJumptableIndex

.ExtraPointers:
    dw ExtraOptions_HiddenPower
    dw ExtraOptions_MoveTutors
    dw ExtraOptions_HMFriends
    dw ExtraOptions_Megas
    dw ExtraOptions_DisableEvos
    dw ExtraOptions_Abilities
    dw ExtraOptions_Rival
    dw ExtraOptions_Cancel

ExtraOptions_HiddenPower:
    ldh a, [hJoyPressed]
    bit D_LEFT_F, a
    jr nz, .LeftPressed
    bit D_RIGHT_F, a
    jr z, .NonePressed
    ld a, [wWhichHiddenPower]
    and a
    jr z, .ToggleOn
    jr .ToggleOff

    .LeftPressed:
    ld a, [wWhichHiddenPower]
    and a
    jr nz, .ToggleOff
    jr .ToggleOn

    .NonePressed:
    ld a, [wWhichHiddenPower]
    and a
    jr nz, .ToggleOn
    jr .ToggleOff

    .ToggleOn:
    ld a, 1
    ld [wWhichHiddenPower], a
    ld de, .On
    jr .Display

    .ToggleOff:
    xor a
    ld [wWhichHiddenPower], a
    ld de, .Off

    .Display:
    hlcoord 11, 3
    call PlaceString
    and a
    ret

.On:  db "PLA  @"
.Off: db "GEN 2@"

ExtraOptions_MoveTutors:
    ldh a, [hJoyPressed]
    bit D_LEFT_F, a
    jr nz, .LeftPressed
    bit D_RIGHT_F, a
    jr z, .NonePressed
    ld a, [wTutorsLimited]
    and a
    jr z, .ToggleOn
    jr .ToggleOff

    .LeftPressed:
    ld a, [wTutorsLimited]
    and a
    jr nz, .ToggleOff
    jr .ToggleOn

    .NonePressed:
    ld a, [wTutorsLimited]
    and a
    jr nz, .ToggleOn
    jr .ToggleOff

    .ToggleOn:
    ld a, 1
    ld [wTutorsLimited], a
    ld de, .On
    jr .Display

    .ToggleOff:
    xor a
    ld [wTutorsLimited], a
    ld de, .Off

    .Display:
    hlcoord 11, 5
    call PlaceString
    and a
    ret

    .Off:  db "CAPPED @"
    .On: db "NO CAP @"   

ExtraOptions_HMFriends:
    ldh a, [hJoyPressed]
    bit D_LEFT_F, a
    jr nz, .LeftPressed
    bit D_RIGHT_F, a
    jr z, .NonePressed
    ld a, [wGuaranteedHMFriendCatch]
    and a
    jr z, .ToggleOn
    jr .ToggleOff

    .LeftPressed:
    ld a, [wGuaranteedHMFriendCatch]
    and a
    jr nz, .ToggleOff
    jr .ToggleOn

    .NonePressed:
    ld a, [wGuaranteedHMFriendCatch]
    and a
    jr nz, .ToggleOn
    jr .ToggleOff

    .ToggleOn:
    ld a, 1
    ld [wGuaranteedHMFriendCatch], a
    ld de, .On
    jr .Display

    .ToggleOff:
    xor a
    ld [wGuaranteedHMFriendCatch], a
    ld de, .Off

    .Display:
    hlcoord 11, 7
    call PlaceString
    and a
    ret

    .Off:  db "NO @"
    .On: db "YES@"   

ExtraOptions_Megas:
    ldh a, [hJoyPressed]
    bit D_LEFT_F, a
    jr nz, .LeftPressed
    bit D_RIGHT_F, a
    jr z, .NonePressed
    ld a, [wMegaEvolutionActive]
    and a
    jr z, .ToggleOn
    jr .ToggleOff

    .LeftPressed:
    ld a, [wMegaEvolutionActive]
    and a
    jr nz, .ToggleOff
    jr .ToggleOn

    .NonePressed:
    ld a, [wMegaEvolutionActive]
    and a
    jr nz, .ToggleOn
    jr .ToggleOff

    .ToggleOn:
    ld a, 1
    ld [wMegaEvolutionActive], a
    ld de, .On
    jr .Display

    .ToggleOff:
    xor a
    ld [wMegaEvolutionActive], a
    ld de, .Off

    .Display:
    hlcoord 11, 9
    call PlaceString
    and a
    ret

    .Off:  db "NO @"
    .On: db "YES@"  

ExtraOptions_DisableEvos:
    ldh a, [hJoyPressed]
    bit D_LEFT_F, a
    jr nz, .LeftPressed
    bit D_RIGHT_F, a
    jr z, .NonePressed
    ld a, [wEvolutionsDisabled]
    and a
    jr z, .ToggleOn
    jr .ToggleOff

    .LeftPressed:
    ld a, [wEvolutionsDisabled]
    and a
    jr nz, .ToggleOff
    jr .ToggleOn

    .NonePressed:
    ld a, [wEvolutionsDisabled]
    and a
    jr nz, .ToggleOn
    jr .ToggleOff

    .ToggleOn:
    ld a, 1
    ld [wEvolutionsDisabled], a
    ld de, .On
    jr .Display

    .ToggleOff:
    xor a
    ld [wEvolutionsDisabled], a
    ld de, .Off

    .Display:
    hlcoord 11, 11
    call PlaceString
    and a
    ret

    .Off:  db "NO @"
    .On: db "YES@"  

ExtraOptions_Abilities:
    ldh a, [hJoyPressed]
    bit D_LEFT_F, a
    jr nz, .LeftPressed
    bit D_RIGHT_F, a
    jr z, .NonePressed
    ld a, [wAbilitiesActivated]
    and a
    jr z, .ToggleOn
    jr .ToggleOff

    .LeftPressed:
    ld a, [wAbilitiesActivated]
    and a
    jr nz, .ToggleOff
    jr .ToggleOn

    .NonePressed:
    ld a, [wAbilitiesActivated]
    and a
    jr nz, .ToggleOn
    jr .ToggleOff

    .ToggleOn:
    ld a, 1
    ld [wAbilitiesActivated], a
    ld de, .On
    jr .Display

    .ToggleOff:
    xor a
    ld [wAbilitiesActivated], a
    ld de, .Off

    .Display:
    hlcoord 11, 13
    call PlaceString
    and a
    ret

    .Off:  db "NO @"
    .On: db "YES@"  

ExtraOptions_Rival:
    ldh a, [hJoyPressed]
    bit D_LEFT_F, a
    jr nz, .LeftPressed
    bit D_RIGHT_F, a
    jr z, .NonePressed
    ld a, [wRivalCarriesStarter]
    and a
    jr z, .ToggleOn
    jr .ToggleOff

    .LeftPressed:
    ld a, [wRivalCarriesStarter]
    and a
    jr nz, .ToggleOff
    jr .ToggleOn

    .NonePressed:
    ld a, [wRivalCarriesStarter]
    and a
    jr nz, .ToggleOn
    jr .ToggleOff

    .ToggleOn:
    ld a, 1
    ld [wRivalCarriesStarter], a
    ld de, .On
    jr .Display

    .ToggleOff:
    xor a
    ld [wRivalCarriesStarter], a
    ld de, .Off

    .Display:
    hlcoord 11, 15
    call PlaceString
    and a
    ret

    .Off:  db "NO @"
    .On: db "YES@"  

ExtraOptions_Cancel:
    ldh a, [hJoyPressed]
    and A_BUTTON
    jr nz, .Exit
    and a
    ret

    .Exit:
    scf
    ret

ExtraOptionsControl:
    ld hl, wJumptableIndex
    ldh a, [hJoyLast]
    cp D_DOWN
    jr z, .DownPressed
    cp D_UP
    jr z, .UpPressed
    and a
    ret

.DownPressed:
    ld a, [hl]
    cp EXTRA_OPT_CANCEL ; maximum option index
    jr nz, .CheckMenuAccount
    ld [hl], OPT_TEXT_SPEED ; first option
    scf
    ret

.CheckMenuAccount:
    cp OPT_MENU_ACCOUNT
    jr nz, .Increase
    ld [hl], OPT_MENU_ACCOUNT

.Increase:
    inc [hl]
    scf
    ret

.UpPressed:
    ld a, [hl]
    cp OPT_FRAME
    jr nz, .NotFrame
    ld [hl], OPT_MENU_ACCOUNT
    scf
    ret

.NotFrame:
    and a ; OPT_TEXT_SPEED, minimum option index
    jr nz, .Decrease
    ld [hl], NUM_EXTRA_OPTIONS ; decrements to OPT_CANCEL, maximum option index

.Decrease:
    dec [hl]
    scf
    ret

ExtraOptions_UpdateCursorPosition:
    hlcoord 1, 1
    ld de, SCREEN_WIDTH
    ld c, SCREEN_HEIGHT - 2
.loop
    ld [hl], " "
    add hl, de
    dec c
    jr nz, .loop
    hlcoord 1, 2
    ld bc, 2 * SCREEN_WIDTH
    ld a, [wJumptableIndex]
    call AddNTimes
    ld [hl], "▶"
    ret

DummyFunction:
    ; This is a dummy function
    ret