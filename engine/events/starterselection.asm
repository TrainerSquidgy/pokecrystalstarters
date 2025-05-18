SetStarter1::
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	ld de, TimeSetUpArrowGFX
	ld hl, vTiles0 tile TIMESET_UP_ARROW
	lb bc, BANK(TimeSetUpArrowGFX), 1
	call Request1bpp
	ld de, TimeSetDownArrowGFX
	ld hl, vTiles0 tile TIMESET_DOWN_ARROW
	lb bc, BANK(TimeSetDownArrowGFX), 1
	call Request1bpp
	xor a
	ld [wElmPokemon1], a
.loop
	hlcoord 0, 12
	lb bc, 4, 2
	call Textbox
	call LoadStandardMenuHeader
	ld hl, WhichPokemonInBall1Text
	call PrintText
	hlcoord 6, 3
	ld b, 2
	ld c, 12
	call Textbox
	hlcoord 13, 3
	ld [hl], TIMESET_UP_ARROW
	hlcoord 11, 6
	ld [hl], TIMESET_DOWN_ARROW
	hlcoord 7, 5
	call PlacePokemonString1
	call ApplyTilemap
	ld c, 10
	call DelayFrames
.loop2
	call JoyTextDelay
	call .GetJoypadAction
	jr nc, .loop2
	call ExitMenu
	call UpdateSprites
	ld hl, ConfirmPokemonText
	call PrintText
	call YesNoBox
	jr c, .loop
	ld a, [wElmPokemon1]
	inc a
	ld [wStringBuffer2], a
	call LoadStandardFont
	pop af
	ldh [hInMenu], a
	ret

.GetJoypadAction:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr z, .not_A
	scf
	ret

.not_A
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wElmPokemon1
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, CARBINK
;PYTHONBUFFER1
.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wElmPokemon1
	ld a, [hl]
	cp 251
;PYTHONBUFFER2
	jr c, .increase
	ld a, 0

.increase
	inc a
	ld [hl], a

.finish_dpad
	xor a
	ldh [hBGMapMode], a
	hlcoord 7, 4
	ld b, 2
	ld c, 11
	call ClearBox
	hlcoord 7, 5
	call .PlacePokemonStrings
	call WaitBGMap
	and a
	ret

.PlacePokemonStrings
	push hl
	ld a, [wElmPokemon1]
	ld e, a
	ld d, 0
	ld hl, PokemonStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret
	
SetStarter2::
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	ld de, TimeSetUpArrowGFX
	ld hl, vTiles0 tile TIMESET_UP_ARROW
	lb bc, BANK(TimeSetUpArrowGFX), 1
	call Request1bpp
	ld de, TimeSetDownArrowGFX
	ld hl, vTiles0 tile TIMESET_DOWN_ARROW
	lb bc, BANK(TimeSetDownArrowGFX), 1
	call Request1bpp
	xor a
	ld [wElmPokemon2], a
.loop
	hlcoord 0, 12
	lb bc, 4, 2
	call Textbox
	call LoadStandardMenuHeader
	ld hl, WhichPokemonInBall2Text
	call PrintText
	hlcoord 6, 3
	ld b, 2
	ld c, 12
	call Textbox
	hlcoord 13, 3
	ld [hl], TIMESET_UP_ARROW
	hlcoord 11, 6
	ld [hl], TIMESET_DOWN_ARROW
	hlcoord 7, 5
	call PlacePokemonString2
	call ApplyTilemap
	ld c, 10
	call DelayFrames
.loop2
	call JoyTextDelay
	call .GetJoypadAction
	jr nc, .loop2
	call ExitMenu
	call UpdateSprites
	ld hl, ConfirmPokemonText
	call PrintText
	call YesNoBox
	jr c, .loop
	ld a, [wElmPokemon2]
	inc a
	ld [wStringBuffer2], a
	call LoadStandardFont
	pop af
	ldh [hInMenu], a
	ret

.GetJoypadAction:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr z, .not_A
	scf
	ret

.not_A
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wElmPokemon2
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, CARBINK
;PYTHONBUFFER1
.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wElmPokemon2
	ld a, [hl]
	cp 251
;PYTHONBUFFER2
	jr c, .increase
	ld a, 0

.increase
	inc a
	ld [hl], a

.finish_dpad
	xor a
	ldh [hBGMapMode], a
	hlcoord 7, 4
	ld b, 2
	ld c, 11
	call ClearBox
	hlcoord 7, 5
	call .PlacePokemonStrings
	call WaitBGMap
	and a
	ret

.PlacePokemonStrings
	push hl
	ld a, [wElmPokemon2]
	ld e, a
	ld d, 0
	ld hl, PokemonStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret

SetStarter3::
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	ld de, TimeSetUpArrowGFX
	ld hl, vTiles0 tile TIMESET_UP_ARROW
	lb bc, BANK(TimeSetUpArrowGFX), 1
	call Request1bpp
	ld de, TimeSetDownArrowGFX
	ld hl, vTiles0 tile TIMESET_DOWN_ARROW
	lb bc, BANK(TimeSetDownArrowGFX), 1
	call Request1bpp
	xor a
	ld [wElmPokemon3], a
.loop
	hlcoord 0, 12
	lb bc, 4, 2
	call Textbox
	call LoadStandardMenuHeader
	ld hl, WhichPokemonInBall3Text
	call PrintText
	hlcoord 6, 3
	ld b, 2
	ld c, 12
	call Textbox
	hlcoord 13, 3
	ld [hl], TIMESET_UP_ARROW
	hlcoord 11, 6
	ld [hl], TIMESET_DOWN_ARROW
	hlcoord 7, 5
	call PlacePokemonString3
	call ApplyTilemap
	ld c, 10
	call DelayFrames
.loop2
	call JoyTextDelay
	call .GetJoypadAction
	jr nc, .loop2
	call ExitMenu
	call UpdateSprites
	ld hl, ConfirmPokemonText
	call PrintText
	call YesNoBox
	jr c, .loop
	ld a, [wElmPokemon3]
	inc a
	ld [wStringBuffer2], a
	call LoadStandardFont
	pop af
	ldh [hInMenu], a
	ret

.GetJoypadAction:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr z, .not_A
	scf
	ret

.not_A
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wElmPokemon3
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, CARBINK
;PYTHONBUFFER1
.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wElmPokemon3
	ld a, [hl]
	cp 251
;PYTHONBUFFER2
	jr c, .increase
	ld a, 0

.increase
	inc a
	ld [hl], a

.finish_dpad
	xor a
	ldh [hBGMapMode], a
	hlcoord 7, 4
	ld b, 2
	ld c, 11
	call ClearBox
	hlcoord 7, 5
	call .PlacePokemonStrings
	call WaitBGMap
	and a
	ret

.PlacePokemonStrings
	push hl
	ld a, [wElmPokemon3]
	ld e, a
	ld d, 0
	ld hl, PokemonStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret

PokemonStrings:
; entries correspond to Pokemon constants
	dw .Bulbasaur
	dw .Ivysaur
	dw .Venusaur
	dw .Charmander
	dw .Charmeleon
	dw .Charizard
	dw .Squirtle
	dw .Wartortle
	dw .Blastoise
	dw .Caterpie
	dw .Metapod
	dw .Butterfree
	dw .Weedle
	dw .Kakuna
	dw .Beedrill
	dw .Pidgey
	dw .Pidgeotto
	dw .Pidgeot
	dw .Rattata
	dw .Raticate
	dw .Spearow
	dw .Fearow
	dw .Ekans
	dw .Arbok
	dw .Pikachu
	dw .Raichu
	dw .Sandshrew
	dw .Sandslash
	dw .NidoranF
	dw .Nidorina
	dw .Nidoqueen
	dw .NidoranM
	dw .Nidorino
	dw .Nidoking
	dw .Clefairy
	dw .Clefable
	dw .Vulpix
	dw .Ninetales
	dw .Jigglypuff
	dw .Wigglytuff
	dw .Zubat
	dw .Golbat
	dw .Oddish
	dw .Gloom
	dw .Vileplume
	dw .Paras
	dw .Parasect
	dw .Venonat
	dw .Venomoth
	dw .Diglett
	dw .Dugtrio
	dw .Meowth
	dw .Persian
	dw .Psyduck
	dw .Golduck
	dw .Mankey
	dw .Primeape
	dw .Growlithe
	dw .Arcanine
	dw .Poliwag
	dw .Poliwhirl
	dw .Poliwrath
	dw .Abra
	dw .Kadabra
	dw .Alakazam
	dw .Machop
	dw .Machoke
	dw .Machamp
	dw .Bellsprout
	dw .Weepinbell
	dw .Victreebel
	dw .Tentacool
	dw .Tentacruel
	dw .Geodude
	dw .Graveler
	dw .Golem
	dw .Ponyta
	dw .Rapidash
	dw .Slowpoke
	dw .Slowbro
	dw .Magnemite
	dw .Magneton
	dw .Farfetchd
	dw .Doduo
	dw .Dodrio
	dw .Seel
	dw .Dewgong
	dw .Grimer
	dw .Muk
	dw .Shellder
	dw .Cloyster
	dw .Gastly
	dw .Haunter
	dw .Gengar
	dw .Onix
	dw .Drowzee
	dw .Hypno
	dw .Krabby
	dw .Kingler
	dw .Voltorb
	dw .Electrode
	dw .Exeggcute
	dw .Exeggutor
	dw .Cubone
	dw .Marowak
	dw .Hitmonlee
	dw .Hitmonchan
	dw .Lickitung
	dw .Koffing
	dw .Weezing
	dw .Rhyhorn
	dw .Rhydon
	dw .Chansey
	dw .Tangela
	dw .Kangaskhan
	dw .Horsea
	dw .Seadra
	dw .Goldeen
	dw .Seaking
	dw .Staryu
	dw .Starmie
	dw .MrMime
	dw .Scyther
	dw .Jynx
	dw .Electabuzz
	dw .Magmar
	dw .Pinsir
	dw .Tauros
	dw .Magikarp
	dw .Gyarados
	dw .Lapras
	dw .Ditto
	dw .Eevee
	dw .Vaporeon
	dw .Jolteon
	dw .Flareon
	dw .Porygon
	dw .Omanyte
	dw .Omastar
	dw .Kabuto
	dw .Kabutops
	dw .Aerodactyl
	dw .Snorlax
	dw .Articuno
	dw .Zapdos
	dw .Moltres
	dw .Dratini
	dw .Dragonair
	dw .Dragonite
	dw .Mewtwo
	dw .Mew
	dw .Chikorita
	dw .Bayleef
	dw .Meganium
	dw .Cyndaquil
	dw .Quilava
	dw .Typhlosion
	dw .Totodile
	dw .Croconaw
	dw .Feraligatr
	dw .Sentret
	dw .Furret
	dw .Hoothoot
	dw .Noctowl
	dw .Ledyba
	dw .Ledian
	dw .Spinarak
	dw .Ariados
	dw .Crobat
	dw .Chinchou
	dw .Lanturn
	dw .Pichu
	dw .Cleffa
	dw .Igglybuff
	dw .Togepi
	dw .Togetic
	dw .Natu
	dw .Xatu
	dw .Mareep
	dw .Flaaffy
	dw .Ampharos
	dw .Bellossom
	dw .Marill
	dw .Azumarill
	dw .Sudowoodo
	dw .Politoed
	dw .Hoppip
	dw .Skiploom
	dw .Jumpluff
	dw .Aipom
	dw .Sunkern
	dw .Sunflora
	dw .Yanma
	dw .Wooper
	dw .Quagsire
	dw .Espeon
	dw .Umbreon
	dw .Murkrow
	dw .Slowking
	dw .Misdreavus
	dw .Unown
	dw .Wobbuffet
	dw .Girafarig
	dw .Pineco
	dw .Forretress
	dw .Dunsparce
	dw .Gligar
	dw .Steelix
	dw .Snubbull
	dw .Granbull
	dw .Qwilfish
	dw .Scizor
	dw .Shuckle
	dw .Heracross
	dw .Sneasel
	dw .Teddiursa
	dw .Ursaring
	dw .Slugma
	dw .Magcargo
	dw .Swinub
	dw .Piloswine
	dw .Corsola
	dw .Remoraid
	dw .Octillery
	dw .Delibird
	dw .Mantine
	dw .Skarmory
	dw .Houndour
	dw .Houndoom
	dw .Kingdra
	dw .Phanpy
	dw .Donphan
	dw .Porygon2
	dw .Stantler
	dw .Smeargle
	dw .Tyrogue
	dw .Hitmontop
	dw .Smoochum
	dw .Elekid
	dw .Magby
	dw .Miltank
	dw .Blissey
	dw .Raikou
	dw .Entei
	dw .Suicune
	dw .Larvitar
	dw .Pupitar
	dw .Tyranitar
	dw .Lugia
	dw .Hooh
	dw .Celebi
	dw .Carbink
;PYTHONBUFFER3
	
.Bulbasaur	db "BULBASAUR@@"
.Ivysaur	db "IVYSAUR@@@@"
.Venusaur	db "VENUSAUR@@@"
.Charmander	db "CHARMANDER@"
.Charmeleon	db "CHARMELEON@"
.Charizard	db "CHARIZARD@@"
.Squirtle	db "SQUIRTLE@@@"
.Wartortle	db "WARTORTLE@@"
.Blastoise	db "BLASTOISE@@"
.Caterpie	db "CATERPIE@@@"
.Metapod	db "METAPOD@@@@"
.Butterfree	db "BUTTERFREE@"
.Weedle		db "WEEDLE@@@@@"
.Kakuna		db "KAKUNA@@@@@"
.Beedrill	db "BEEDRILL@@@"
.Pidgey		db "PIDGEY@@@@@"
.Pidgeotto	db "PIDGEOTTO@@"
.Pidgeot	db "PIDGEOT@@@@"
.Rattata	db "RATTATA@@@@"
.Raticate	db "RATICATE@@@"
.Spearow	db "SPEAROW@@@@"
.Fearow		db "FEAROW@@@@@"
.Ekans		db "EKANS@@@@@@"
.Arbok		db "ARBOK@@@@@@"
.Pikachu	db "PIKACHU@@@@"
.Raichu		db "RAICHU@@@@@"
.Sandshrew	db "SANDSHREW@@"
.Sandslash	db "SANDSLASH@@"
.NidoranF	db "NIDORAN@F@@"
.Nidorina	db "NIDORINA@@@"
.Nidoqueen	db "NIDOQUEEN@@"
.NidoranM	db "NIDORAN@M@@"
.Nidorino	db "NIDORINO@@@"
.Nidoking	db "NIDOKING@@@"
.Clefairy	db "CLEFAIRY@@@"
.Clefable	db "CLEFABLE@@@"
.Vulpix		db "VULPIX@@@@@"
.Ninetales	db "NINETALES@@"
.Jigglypuff	db "JIGGLYPUFF@"
.Wigglytuff	db "WIGGLYTUFF@"
.Zubat		db "ZUBAT@@@@@@"
.Golbat		db "GOLBAT@@@@@"
.Oddish		db "ODDISH@@@@@"
.Gloom		db "GLOOM@@@@@@"
.Vileplume	db "VILEPLUME@@"
.Paras		db "PARAS@@@@@@"
.Parasect	db "PARASECT@@@"
.Venonat	db "VENONAT@@@@"
.Venomoth	db "VENOMOTH@@@"
.Diglett	db "DIGLETT@@@@"
.Dugtrio	db "DUGTRIO@@@@"
.Meowth		db "MEOWTH@@@@@"
.Persian	db "PERSIAN@@@@"
.Psyduck	db "PSYDUCK@@@@"
.Golduck	db "GOLDUCK@@@@"
.Mankey		db "MANKEY@@@@@"
.Primeape	db "PRIMEAPE@@@"
.Growlithe	db "GROWLITHE@@"
.Arcanine	db "ARCANINE@@@"
.Poliwag	db "POLIWAG@@@@"
.Poliwhirl	db "POLIWHIRL@@"
.Poliwrath	db "POLIWRATH@@"
.Abra		db "ABRA@@@@@@@"
.Kadabra	db "KADABRA@@@@"
.Alakazam	db "ALAKAZAM@@@"
.Machop		db "MACHOP@@@@@"
.Machoke	db "MACHOKE@@@@"
.Machamp	db "MACHAMP@@@@"
.Bellsprout	db "BELLSPROUT@"
.Weepinbell	db "WEEPINBELL@"
.Victreebel	db "VICTREEBEL@"
.Tentacool	db "TENTACOOL@@"
.Tentacruel	db "TENTACRUEL@"
.Geodude	db "GEODUDE@@@@"
.Graveler	db "GRAVELER@@@"
.Golem		db "GOLEM@@@@@@"
.Ponyta		db "PONYTA@@@@@"
.Rapidash	db "RAPIDASH@@@"
.Slowpoke	db "SLOWPOKE@@@"
.Slowbro	db "SLOWBRO@@@@"
.Magnemite	db "MAGNEMITE@@"
.Magneton	db "MAGNETON@@@"
.Farfetchd	db "FARFETCH'D@"
.Doduo		db "DODUO@@@@@@"
.Dodrio		db "DODRIO@@@@@"
.Seel		db "SEEL@@@@@@@"
.Dewgong	db "DEWGONG@@@@"
.Grimer		db "GRIMER@@@@@"
.Muk		db "MUK@@@@@@@@"
.Shellder	db "SHELLDER@@@"
.Cloyster	db "CLOYSTER@@@"
.Gastly		db "GASTLY@@@@@"
.Haunter	db "HAUNTER@@@@"
.Gengar		db "GENGAR@@@@@"
.Onix		db "ONIX@@@@@@@"
.Drowzee	db "DROWZEE@@@@"
.Hypno		db "HYPNO@@@@@@"
.Krabby		db "KRABBY@@@@@"
.Kingler	db "KINGLER@@@@"
.Voltorb	db "VOLTORB@@@@"
.Electrode	db "ELECTRODE@@"
.Exeggcute	db "EXEGGCUTE@@"
.Exeggutor	db "EXEGGUTOR@@"
.Cubone		db "CUBONE@@@@@"
.Marowak	db "MAROWAK@@@@"
.Hitmonlee	db "HITMONLEE@@"
.Hitmonchan	db "HITMONCHAN@"
.Lickitung	db "LICKITUNG@@"
.Koffing	db "KOFFING@@@@"
.Weezing	db "WEEZING@@@@"
.Rhyhorn	db "RHYHORN@@@@"
.Rhydon		db "RHYDON@@@@@"
.Chansey	db "CHANSEY@@@@"
.Tangela	db "TANGELA@@@@"
.Kangaskhan	db "KANGASKHAN@"
.Horsea		db "HORSEA@@@@@"
.Seadra		db "SEADRA@@@@@"
.Goldeen	db "GOLDEEN@@@@"
.Seaking	db "SEAKING@@@@"
.Staryu		db "STARYU@@@@@"
.Starmie	db "STARMIE@@@@"
.MrMime		db "MR.MIME@@@@"
.Scyther	db "SCYTHER@@@@"
.Jynx		db "JYNX@@@@@@@"
.Electabuzz	db "ELECTABUZZ@"
.Magmar		db "MAGMAR@@@@@"
.Pinsir		db "PINSIR@@@@@"
.Tauros		db "TAUROS@@@@@"
.Magikarp	db "MAGIKARP@@@"
.Gyarados	db "GYARADOS@@@"
.Lapras		db "LAPRAS@@@@@"
.Ditto		db "DITTO@@@@@@"
.Eevee		db "EEVEE@@@@@@"
.Vaporeon	db "VAPOREON@@@"
.Jolteon	db "JOLTEON@@@@"
.Flareon	db "FLAREON@@@@"
.Porygon	db "PORYGON@@@@"
.Omanyte	db "OMANYTE@@@@"
.Omastar	db "OMASTAR@@@@"
.Kabuto		db "KABUTO@@@@@"
.Kabutops	db "KABUTOPS@@@"
.Aerodactyl	db "AERODACTYL@"
.Snorlax	db "SNORLAX@@@@"
.Articuno	db "ARTICUNO@@@"
.Zapdos		db "ZAPDOS@@@@@"
.Moltres	db "MOLTRES@@@@"
.Dratini	db "DRATINI@@@@"
.Dragonair	db "DRAGONAIR@@"
.Dragonite	db "DRAGONITE@@"
.Mewtwo		db "MEWTWO@@@@@"
.Mew		db "MEW@@@@@@@@"
.Chikorita	db "CHIKORITA@@"
.Bayleef	db "BAYLEEF@@@@"
.Meganium	db "MEGANIUM@@@"
.Cyndaquil	db "CYNDAQUIL@@"
.Quilava	db "QUILAVA@@@@"
.Typhlosion	db "TYPHLOSION@"
.Totodile	db "TOTODILE@@@"
.Croconaw	db "CROCONAW@@@"
.Feraligatr	db "FERALIGATR@"
.Sentret	db "SENTRET@@@@"
.Furret		db "FURRET@@@@@"
.Hoothoot	db "HOOTHOOT@@@"
.Noctowl	db "NOCTOWL@@@@"
.Ledyba		db "LEDYBA@@@@@"
.Ledian		db "LEDIAN@@@@@"
.Spinarak	db "SPINARAK@@@"
.Ariados	db "ARIADOS@@@@"
.Crobat		db "CROBAT@@@@@"
.Chinchou	db "CHINCHOU@@@"
.Lanturn	db "LANTURN@@@@"
.Pichu		db "PICHU@@@@@@"
.Cleffa		db "CLEFFA@@@@@"
.Igglybuff	db "IGGLYBUFF@@"
.Togepi		db "TOGEPI@@@@@"
.Togetic	db "TOGETIC@@@@"
.Natu		db "NATU@@@@@@@"
.Xatu		db "XATU@@@@@@@"
.Mareep		db "MAREEP@@@@@"
.Flaaffy	db "FLAAFFY@@@@"
.Ampharos	db "AMPHAROS@@@"
.Bellossom	db "BELLOSSOM@@"
.Marill		db "MARILL@@@@@"
.Azumarill	db "AZUMARILL@@"
.Sudowoodo	db "SUDOWOODO@@"
.Politoed	db "POLITOED@@@"
.Hoppip		db "HOPPIP@@@@@"
.Skiploom	db "SKIPLOOM@@@"
.Jumpluff	db "JUMPLUFF@@@"
.Aipom		db "AIPOM@@@@@@"
.Sunkern	db "SUNKERN@@@@"
.Sunflora	db "SUNFLORA@@@"
.Yanma		db "YANMA@@@@@@"
.Wooper		db "WOOPER@@@@@"
.Quagsire	db "QUAGSIRE@@@"
.Espeon		db "ESPEON@@@@@"
.Umbreon	db "UMBREON@@@@"
.Murkrow	db "MURKROW@@@@"
.Slowking	db "SLOWKING@@@"
.Misdreavus	db "MISDREAVUS@"
.Unown		db "UNOWN@@@@@@"
.Wobbuffet	db "WOBBUFFET@@"
.Girafarig	db "GIRAFARIG@@"
.Pineco		db "PINECO@@@@@"
.Forretress	db "FORRETRESS@"
.Dunsparce	db "DUNSPARCE@@"
.Gligar		db "GLIGAR@@@@@"
.Steelix	db "STEELIX@@@@"
.Snubbull	db "SNUBBULL@@@"
.Granbull	db "GRANBULL@@@"
.Qwilfish	db "QWILFISH@@@"
.Scizor		db "SCIZOR@@@@@"
.Shuckle	db "SHUCKLE@@@@"
.Heracross	db "HERACROSS@@"
.Sneasel	db "SNEASEL@@@@"
.Teddiursa	db "TEDDIURSA@@"
.Ursaring	db "URSARING@@@"
.Slugma		db "SLUGMA@@@@@"
.Magcargo	db "MAGCARGO@@@"
.Swinub		db "SWINUB@@@@@"
.Piloswine	db "PILOSWINE@@"
.Corsola	db "CORSOLA@@@@"
.Remoraid	db "REMORAID@@@"
.Octillery	db "OCTILLERY@@"
.Delibird	db "DELIBIRD@@@"
.Mantine	db "MANTINE@@@@"
.Skarmory	db "SKARMORY@@@"
.Houndour	db "HOUNDOUR@@@"
.Houndoom	db "HOUNDOOM@@@"
.Kingdra	db "KINGDRA@@@@"
.Phanpy		db "PHANPY@@@@@"
.Donphan	db "DONPHAN@@@@"
.Porygon2	db "PORYGON2@@@"
.Stantler	db "STANTLER@@@"
.Smeargle	db "SMEARGLE@@@"
.Tyrogue	db "TYROGUE@@@@"
.Hitmontop	db "HITMONTOP@@"
.Smoochum	db "SMOOCHUM@@@"
.Elekid		db "ELEKID@@@@@"
.Magby		db "MAGBY@@@@@@"
.Miltank	db "MILTANK@@@@"
.Blissey	db "BLISSEY@@@@"
.Raikou		db "RAIKOU@@@@@"
.Entei		db "ENTEI@@@@@@"
.Suicune	db "SUICUNE@@@@"
.Larvitar	db "LARVITAR@@@"
.Pupitar	db "PUPITAR@@@@"
.Tyranitar	db "TYRANITAR@@"
.Lugia		db "LUGIA@@@@@@"
.Hooh		db "HO-OH@@@@@@"
.Celebi		db "CELEBI@@@@@"
.Carbink	db "CARBINK@@@@"
;PYTHONBUFFER4


WhichPokemonInBall1Text:
	text_far _WhichPokemonInBall1Text
	text_end
	
WhichPokemonInBall2Text:
	text_far _WhichPokemonInBall2Text
	text_end
	
WhichPokemonInBall3Text:
	text_far _WhichPokemonInBall3Text
	text_end
	
WhatHiddenPowerTypeText:
	text_far _WhatHiddenPowerTypeText
	text_end

ModifyHiddenPowerTypeText:
	text_far _ModifyHiddenPowerTypeText
	text_end
	


ConfirmPokemonText:
	text_far _AreYouSurePokemonText
	text_end

PlacePokemonString1:
	push hl
	ld a, [wElmPokemon1]
	ld e, a
	ld d, 0
	ld hl, PokemonStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret

PlacePokemonString2:
	push hl
	ld a, [wElmPokemon2]
	ld e, a
	ld d, 0
	ld hl, PokemonStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret

PlacePokemonString3:
	push hl
	ld a, [wElmPokemon3]
	ld e, a
	ld d, 0
	ld hl, PokemonStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret
	
	
HandleStarterOffset::
	ld a, [wElmPokemon1]
	inc a
	ld [wElmPokemon1], a
	ld a, [wElmPokemon2]
	inc a
	ld [wElmPokemon2], a
	ld a, [wElmPokemon3]
	inc a
	ld [wElmPokemon3], a
	ret
	
	
SetHiddenPower::
	ld a, 1
	ld [wIsAStarter], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	ld de, TimeSetUpArrowGFX
	ld hl, vTiles0 tile TIMESET_UP_ARROW
	lb bc, BANK(TimeSetUpArrowGFX), 1
	call Request1bpp
	ld de, TimeSetDownArrowGFX
	ld hl, vTiles0 tile TIMESET_DOWN_ARROW
	lb bc, BANK(TimeSetDownArrowGFX), 1
	call Request1bpp
	xor a
	ld [wStarterDVSelection], a
.loop
	hlcoord 0, 12
	lb bc, 4, 2
	call Textbox
	call LoadStandardMenuHeader
	ld hl, WhatHiddenPowerTypeText
	call PrintText
	hlcoord 6, 3
	ld b, 2
	ld c, 12
	call Textbox
	hlcoord 13, 3
	ld [hl], TIMESET_UP_ARROW
	hlcoord 11, 6
	ld [hl], TIMESET_DOWN_ARROW
	hlcoord 7, 5
	call TypeStrings
	call ApplyTilemap
	ld c, 10
	call DelayFrames
.loop2
	call JoyTextDelay
	call .GetJoypadAction
	jr nc, .loop2
	call ExitMenu
	call UpdateSprites
	ld hl, ConfirmPokemonText
	call PrintText
	call YesNoBox
	jr c, .loop
	ld a, [wStarterDVSelection]
	inc a
	ld [wStringBuffer2], a
	call LoadStandardFont
	pop af
	ldh [hInMenu], a
	ret

.GetJoypadAction:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr z, .not_A
	scf
	ret

.not_A
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wStarterDVSelection
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, 15

.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wStarterDVSelection
	ld a, [hl]
	cp 15
	jr c, .increase
	ld a, 0

.increase
	inc a
	ld [hl], a

.finish_dpad
	xor a
	ldh [hBGMapMode], a
	hlcoord 7, 4
	ld b, 2
	ld c, 11
	call ClearBox
	hlcoord 7, 5
	call .PlaceTypeStrings
	call WaitBGMap
	and a
	ret

.PlaceTypeStrings
	push hl
	ld a, [wStarterDVSelection]
	ld e, a
	ld d, 0
	ld hl, TypeTextStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret
	
TypeStrings:
	push hl
	ld a, [wStarterDVSelection]
	ld e, a
	ld d, 0
	ld hl, TypeTextStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret
	
TypeTextStrings:
; entries correspond to Pokemon constants
	dw .Dark
	dw .Dragon
	dw .Ice
	dw .Psychic
	dw .Electric
	dw .Grass
	dw .Water
	dw .Fire
	dw .Steel
	dw .Ghost
	dw .Bug
	dw .Rock
	dw .Ground
	dw .Poison
	dw .Flying
	dw .Fighting
	
	
	.Dark     db "DARK@@@@@@@"
	.Dragon   db "DRAGON@@@@@"
	.Ice      db "ICE@@@@@@@@"
	.Psychic  db "PSYCHIC@@@@"
	.Electric db "ELECTRIC@@@"
	.Grass    db "GRASS@@@@@@"
	.Water    db "WATER@@@@@"
	.Fire     db "FIRE@@@@@@"
	.Steel    db "STEEL@@@@@"
	.Ghost    db "GHOST@@@@@"
	.Bug      db "BUG@@@@@@@"
	.Rock     db "ROCK@@@@@@"
	.Ground   db "GROUND@@@"
	.Poison   db "POISON@@@"
	.Flying   db "FLYING@@@"
	.Fighting db "FIGHTING@"
	
AlteredHiddenPower::
	ld a, 1
	ld [wIsAStarter], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	ld de, TimeSetUpArrowGFX
	ld hl, vTiles0 tile TIMESET_UP_ARROW
	lb bc, BANK(TimeSetUpArrowGFX), 1
	call Request1bpp
	ld de, TimeSetDownArrowGFX
	ld hl, vTiles0 tile TIMESET_DOWN_ARROW
	lb bc, BANK(TimeSetDownArrowGFX), 1
	call Request1bpp
	xor a
	ld [wAlteredHiddenPowerDVs], a
.loop
	hlcoord 0, 12
	lb bc, 4, 2
	call Textbox
	call LoadStandardMenuHeader
	ld hl, ModifyHiddenPowerTypeText
	call PrintText
	hlcoord 6, 3
	ld b, 2
	ld c, 12
	call Textbox
	hlcoord 13, 3
	ld [hl], TIMESET_UP_ARROW
	hlcoord 11, 6
	ld [hl], TIMESET_DOWN_ARROW
	hlcoord 7, 5
	call AlteredHiddenPowerStrings
	call ApplyTilemap
	ld c, 10
	call DelayFrames
.loop2
	call JoyTextDelay
	call .GetJoypadAction
	jr nc, .loop2
	call ExitMenu
	call UpdateSprites
	ld hl, ConfirmPokemonText
	call PrintText
	call YesNoBox
	jr c, .loop
	ld a, [wAlteredHiddenPowerDVs]
	inc a
	ld [wStringBuffer2], a
	call LoadStandardFont
	pop af
	ldh [hInMenu], a
	ret

.GetJoypadAction:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr z, .not_A
	scf
	ret

.not_A
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wAlteredHiddenPowerDVs
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, 3 + 1

.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wAlteredHiddenPowerDVs
	ld a, [hl]
	cp 3
	jr c, .increase
	ld a, 0 - 1

.increase
	inc a
	ld [hl], a

.finish_dpad
	xor a
	ldh [hBGMapMode], a
	hlcoord 7, 4
	ld b, 2
	ld c, 11
	call ClearBox
	hlcoord 7, 5
	call .PlaceTypeStrings
	call WaitBGMap
	and a
	ret

.PlaceTypeStrings
	push hl
	ld a, [wAlteredHiddenPowerDVs]
	ld e, a
	ld d, 0
	ld hl, AlteredHiddenPowerTextStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret


AlteredHiddenPowerStrings:
	push hl
	ld a, [wAlteredHiddenPowerDVs]
	ld e, a
	ld d, 0
	ld hl, AlteredHiddenPowerTextStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret
	
AlteredHiddenPowerTextStrings:
; entries correspond to Pokemon constants
	dw .Max
	dw .SeventyFive
	dw .Fifty
	dw .TwentyFive
		
	.Max     		db "TOP@@@@@@@@"
	.SeventyFive	db "HI-MIDDLE@@"
	.Fifty     		db "LO-MIDDLE@@"
	.TwentyFive		db "BOTTOM@@@@@"