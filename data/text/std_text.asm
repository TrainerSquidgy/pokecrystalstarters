NurseMornText:
	text "Good morning!"
	line "Welcome to our"
	cont "#MON CENTER."
	done

NurseDayText:
	text "Hello!"
	line "Welcome to our"
	cont "#MON CENTER."
	done

NurseNiteText:
	text "Good evening!"
	line "You're out late."

	para "Welcome to our"
	line "#MON CENTER."
	done

PokeComNurseMornText:
	text "Good morning!"

	para "This is the #-"
	line "MON COMMUNICATION"

	para "CENTER--or the"
	line "#COM CENTER."
	done

PokeComNurseDayText:
	text "Hello!"

	para "This is the #-"
	line "MON COMMUNICATION"

	para "CENTER--or the"
	line "#COM CENTER."
	done

PokeComNurseNiteText:
	text "Good to see you"
	line "working so late."

	para "This is the #-"
	line "MON COMMUNICATION"

	para "CENTER--or the"
	line "#COM CENTER."
	done

NurseAskHealText:
	text "We can heal your"
	line "#MON to perfect"
	cont "health."

	para "Shall we heal your"
	line "#MON?"
	done

NurseTakePokemonText:
	text "OK, may I see your"
	line "#MON?"
	done

NurseReturnPokemonText:
	text "Thank you for"
	line "waiting."

	para "Your #MON are"
	line "fully healed."
	done

NurseGoodbyeText:
	text "We hope to see you"
	line "again."
	done

; not used
	text "We hope to see you"
	line "again."
	done

NursePokerusText:
	text "Your #MON"
	line "appear to be"

	para "infected by tiny"
	line "life forms."

	para "Your #MON are"
	line "healthy and seem"
	cont "to be fine."

	para "But we can't tell"
	line "you anything more"

	para "at a #MON"
	line "CENTER."
	done

PokeComNursePokerusText:
	text "Your #MON"
	line "appear to be"

	para "infected by tiny"
	line "life forms."

	para "Your #MON are"
	line "healthy and seem"
	cont "to be fine."

	para "But we can't tell"
	line "you anything more."
	done

DifficultBookshelfText:
	text "It's full of"
	line "difficult books."
	done

PictureBookshelfText:
	text "A whole collection"
	line "of #MON picture"
	cont "books!"
	done

MagazineBookshelfText:
	text "#MON magazines…"
	line "#MON PAL,"

	para "#MON HANDBOOK,"
	line "#MON GRAPH…"
	done

TeamRocketOathText:
	text "TEAM ROCKET OATH"

	para "Steal #MON for"
	line "profit!"

	para "Exploit #MON"
	line "for profit!"

	para "All #MON exist"
	line "for the glory of"
	cont "TEAM ROCKET!"
	done

IncenseBurnerText:
	text "What is this?"

	para "Oh, it's an"
	line "incense burner!"
	done

MerchandiseShelfText:
	text "Lots of #MON"
	line "merchandise!"
	done

LookTownMapText:
	text "It's the TOWN MAP."
	done

WindowText:
	text "My reflection!"
	line "Lookin' good!"
	done

TVText:
	text "It's a TV."
	done

HomepageText:
	text "#MON JOURNAL"
	line "HOME PAGE…"

	para "It hasn't been"
	line "updated…"
	done

; not used
	text "#MON RADIO!"

	para "Call in with your"
	line "requests now!"
	done

TrashCanText:
	text "There's nothing in"
	line "here…"
	done

; not used
	text "A #MON may be"
	line "able to move this."
	done

; not used
	text "Maybe a #MON"
	line "can break this."
	done

PokecenterSignText:
	text "Heal Your #MON!"
	line "#MON CENTER"
	done

MartSignText:
	text "For All Your"
	line "#MON Needs"

	para "#MON MART"
	done

ContestResults_ReadyToJudgeText:
	text "We will now judge"
	line "the #MON you've"
	cont "caught."

	para "<……>"
	line "<……>"

	para "We have chosen the"
	line "winners!"

	para "Are you ready for"
	line "this?"
	done

ContestResults_PlayerWonAPrizeText:
	text "<PLAYER>, the No.@"
	text_ram wStringBuffer3
	text_start
	line "finisher, wins"
	cont "@"
	text_ram wStringBuffer4
	text "!"
	done

ReceivedItemText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer4
	text "."
	done

ContestResults_JoinUsNextTimeText:
	text "Please join us for"
	line "the next Contest!"
	done

ContestResults_ConsolationPrizeText:
	text "Everyone else gets"
	line "a BERRY as a con-"
	cont "solation prize!"
	done

ContestResults_DidNotWinText:
	text "We hope you do"
	line "better next time."
	done

ContestResults_ReturnPartyText:
	text "We'll return the"
	line "#MON we kept"

	para "for you."
	line "Here you go!"
	done

ContestResults_PartyFullText:
	text "Your party's full,"
	line "so the #MON was"

	para "sent to your BOX"
	line "in BILL's PC."
	done

GymStatue_CityGymText:
	text_ram wStringBuffer3
	text_start
	line "#MON GYM"
	done

GymStatue_WinningTrainersText:
	text "LEADER: @"
	text_ram wStringBuffer4
	text_start
	para "WINNING TRAINERS:"
	line "<PLAYER>"
	done

CoinVendor_WelcomeText:
	text "Welcome to the"
	line "GAME CORNER."
	done

CoinVendor_NoCoinCaseText:
	text "Do you need game"
	line "coins?"

	para "Oh, you don't have"
	line "a COIN CASE for"
	cont "your coins."
	done

CoinVendor_IntroText:
	text "Do you need some"
	line "game coins?"

	para "It costs ¥1000 for"
	line "50 coins. Do you"
	cont "want some?"
	done

CoinVendor_Buy50CoinsText:
	text "Thank you!"
	line "Here are 50 coins."
	done

CoinVendor_Buy500CoinsText:
	text "Thank you! Here"
	line "are 500 coins."
	done

CoinVendor_NotEnoughMoneyText:
	text "You don't have"
	line "enough money."
	done

CoinVendor_CoinCaseFullText:
	text "Whoops! Your COIN"
	line "CASE is full."
	done

CoinVendor_CancelText:
	text "No coins for you?"
	line "Come again!"
	done

BugContestPrizeNoRoomText:
	text "Oh? Your PACK is"
	line "full."

	para "We'll keep this"
	line "for you today, so"

	para "come back when you"
	line "make room for it."
	done

HappinessText3:
	text "Wow! You and your"
	line "#MON are really"
	cont "close!"
	done

HappinessText2:
	text "#MON get more"
	line "friendly if you"

	para "spend time with"
	line "them."
	done

HappinessText1:
	text "You haven't tamed"
	line "your #MON."

	para "If you aren't"
	line "nice, it'll pout."
	done

RegisteredNumber1Text:
	text "<PLAYER> registered"
	line "@"
	text_ram wStringBuffer3
	text "'s number."
	done

RegisteredNumber2Text:
	text "<PLAYER> registered"
	line "@"
	text_ram wStringBuffer3
	text "'s number."
	done

ObtainedRareCandiesText::
	text "You have obtained"
	line "@"
	text_decimal wRareCandiesObtained, 1, 2
	text " RARE CANDIES."
	done
	
RareCandyGuy_CinnabarIsland::
	text "Amidst the terror"
	line "and carnage of a"
	cont "volcanic mess,"
	
	para "a single RARE"
	line "CANDY survived"
	cont "in-tact."
	done

RareCandyGuy_OlivineLighthouse::
	text "Near the peak of"
	line "a LIGHTHOUSE"
	cont "overlooking the"
	cont "open seas, a"
	
	para "kind soul has"
	line "left a RARE"
	cont "CANDY as a reward"
	cont "for those who"
	cont "ascend the steps."
	done
	
RareCandyGuy_LakeOfRage::
	text "Behind a body"
	line "of water where"
	cont "MAGIKARP are said"
	cont "to be bountiful,"
	
	para "near the house"
	line "of a meditating"
	cont "man, lies a"
	cont "well concealed"
	cont "RARE CANDY."
	done

RareCandyGuy_SilverCave::
	text "At the end of an"
	line "alley where only"
	cont "the strongest"
	cont "trainers are"
	cont "allowed to enter,"
	
	para "somebody has"
	line "hidden a RARE"
	cont "CANDY in a bush."
	done

RareCandyGuy_VermilionCityChairman::
	text "Near a PORT in a"
	line "coastal city,"
	
	para "A man who loves"
	line "his RAPIDASH is"
	cont "said to reward"
	cont "with a RARE CANDY"
	
	para "trainers who"
	cont "listen to his"
	cont "ramblings."
	done 
	
RareCandy_Route34::
	text "In a thicket"
	line "overlooking a"
	cont "friendly old"
	cont "couple's nursery,"
	
	para "You will find"
	line "a RARE CANDY"
	cont "hidden away."
	done

RareCandy_VioletCity::
	text "Across a pond"
	line "adjacent to a"
	cont "swaying tower,"
	
	para "near a GYM home"
	line "to a youthful"
	cont "BIRD KEEPER,"
	
	para "you may find"
	line "a RARE CANDY."
	done

RareCandy_MtMortar::
	text "Enter in the"
	line "MIDDLE ENTRANCE"
	cont "of a three holed"
	cont "MOUNTAIN and then"
	
	para "climb a WATERFALL"
	cont "to find one of"
	cont "the RARE CANDIES."
	done

RareCandy_Route27::
	text "There is a RARE"
	line "CANDY up a creek"
	
	para "where two regions"
	line "adjoin together."
	
	para "It is past the"
	line "cave with the"
	cont "large WATERFALL."
	done
	
RareCandy_WhirlIslands::
	text "In a cave ravaged"
	line "by WHIRLPOOLS,"
	
	para "lies a RARE CANDY"
	line "not visible to"
	cont "the human eye."
	done
	
RareCandy_AllObtained::
	text "Congratulations!"
	
	para "There are no more"
	line "RARE CANDIES that"
	cont "I can help find."
	done
	
RareCandy_End::
	text "I wish you luck"
	line "in your quest"
	cont "for RARE CANDIES."
	done
	
RareCandyGuy_FallbackText::
	text "There are more"
	line "RARE CANDIES but"
	
	para "my powers are"
	line "hazy right now."	
	done
	
RareCandyGuy_IntroText::
	text "I know where to"
	line "find all the"
	cont "RARE CANDIES"
	cont "in the land."
	
	para "Do you require"
	line "my assistance?"
	done