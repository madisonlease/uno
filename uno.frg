#lang forge
option problem_type temporal
option max_tracelength 10

abstract sig Color {}
one sig Red extends Color {}
one sig Blue extends Color {}
one sig Yellow extends Color {}
one sig Green extends Color {}

abstract sig Card {}
sig NumberCard extends Card {
    color: one Color,
    number: one Int
}

one sig Deck {
    var cards: set Card
}

one sig Game {
    players: set Player,
    var turn: one Player,
    var lastPlayed: one Card
}

abstract sig Player {
    var hand: set Card
}
one sig One, Two extends Player {}

-- wellformed is for constricting the non-var things
pred wellformed {

    -- all number cards are created
    all n: Int, c: Color | (n >= 0 and n <= 2) implies {
        some card: NumberCard | {
            card.number = n
            card.color = c
        }
    }else {
        no card: NumberCard | {
            card.number = n
        }
    }

    -- game has two players
    Game.players = (One + Two)

}

pred init {

    wellformed

    // 24 number cards total
    #{NumberCard} = 12
    
    // random last played to start
    some c: Card | {
        Game.lastPlayed = c
    }
    
    // each player's hand has the correct number of cards
    #{card: Card | card in One.hand} = 3
    #{card: Card | card in Two.hand} = 3

    // the deck has the original number of cards minus the cards in each player's hand minus last played card
    #{card: Card | card in Deck.cards} = 5
    // the deck is all the number cards that aren't in a player's hand
    Deck.cards = NumberCard - (One.hand + Two.hand + Game.lastPlayed)

    // it's player One's turn
    Game.turn = One

    // no intersection between the two hands
    no One.hand & Two.hand
    // no intersection between the deck & hands
    no Deck.cards & One.hand
    no Deck.cards & Two.hand
    // no intersection between last played & hands
    no Game.lastPlayed & One.hand
    no Game.lastPlayed & Two.hand
    // no intersection between deck & last played
    no Deck.cards & Game.lastPlayed
    
}

pred final {

    // one player must have no cards left
    (#{card: Card | card in One.hand} = 0) or (#{card: Card | card in Two.hand} = 0)
    
}

pred playable[playablecard: Card] {

    // the card needs to be valid to be played according to the last discarded card
    (playablecard.number = Game.lastPlayed.number) or (playablecard.color = Game.lastPlayed.color)
}

pred play[c: Card] {
    Game.lastPlayed' = c
    Game.turn.hand' = Game.turn.hand - c
    Deck.cards' = Deck.cards
}

pred draw {
    some c: Card | {
        -- card comes from deck
        c in Deck.cards

        Deck.cards' = (Deck.cards - c)

        -- can play it
        playable[c] implies {
            Game.lastPlayed' = c
            Game.turn.hand' = Game.turn.hand
        } else { -- can't play it
            Game.lastPlayed' = Game.lastPlayed
            Game.turn.hand' = Game.turn.hand + c
        }
    }
}

pred move {

    // if there is no card that is both in the player's hand and playable, draw
    (no c: Card | {(c in Game.turn.hand) and playable[c]}) implies {
        draw
    } else { // player doesn't have a card to play so they draw one card
        some c2: Card | {(c2 in Game.turn.hand) and playable[c2] and play[c2]}
    }

    // change whose turn it is
    (Game.turn = One) implies {
        -- hand of inactive player stays the same
        Two.hand' = Two.hand
        -- change turn
        Game.turn' = Two
    }
    (Game.turn = Two) implies {
        -- hand of inactive player stays the same
        One.hand' = One.hand
        -- change turn
        Game.turn' = One
        
    }

}

pred doNothing {

    // GUARD

    -- must be a final state
    final

    // ACTION

    -- nothing changes between states
    Game.turn' = Game.turn
    One.hand' = One.hand
    Two.hand' = Two.hand
    Deck.cards' = Deck.cards
    Game.lastPlayed' = Game.lastPlayed

}

pred traces {
    
    init
    move // one plays (3 cards left)
    // next_state move // two plays
    // next_state next_state move // one plays (2 cards left)
    // next_state next_state next_state move // two plays
    // next_state next_state next_state next_state move // one plays (1 card left)
    // next_state next_state next_state next_state next_state move // two plays
    // next_state next_state next_state next_state next_state next_state move // one plays (0 cards left)
    // next_state next_state next_state next_state next_state next_state next_state final
    // next_state next_state next_state next_state next_state next_state next_state next_state final

    // always {
    //     final implies {
    //         doNothing
    //     } else {
    //         move
    //     }
    // }

}

run {
    traces
} for 5 Int, exactly 12 NumberCard