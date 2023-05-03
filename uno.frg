#lang forge
option problem_type temporal

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
    // all n: Int | {


        all n: Int, c: Color | (n >= 0 and n <= 5) implies {
            some card: NumberCard | {
                card.number = n
                card.color = c
            }
        } 
    //     // else {
    //     //     no card: NumberCard | {
    //     //         card.number = n
    //     //         // card.color = c
    //     //     }
    //     // }
    // }

    -- game has two players
    Game.players = (One + Two)

    
}

pred init {

    wellformed
    
    // // no card played
    // no Game.lastPlayed

    // #{NumberCard} = 40

    // each player's hand has the correct number of cards
    // #{card: Card | card in One.hand} = 4
    // #{card: Card | card in Two.hand} = 4

    // the deck has the original number of cards minus the cards in each player's hand
    // #{card: Card | card in Deck.cards} = 32
    // the deck is all the number cards that aren't in a player's hand
    // Deck.cards = NumberCard - (One.hand + Two.hand)

    // it's player One's turn
    // Game.turn = One

    // no intersection between the two hands
    // no One.hand & Two.hand
    // // no intersection between the deck & hands
    // no Deck.cards & One.hand
    // no Deck.cards & Two.hand
    
}

pred final {

    // one player must have no cards left
    (#{card: Card | card in One.hand} = 0) or (#{card: Card | card in Two.hand} = 0)
    
}

pred playable[playablecard: Card] {
    // the card needs to be valid to be played according to the last discarded card
    playablecard.number = Game.lastPlayed.number or 
    playablecard.color = Game.lastPlayed.color 
}

pred move {

    // // player doesn't have a card to play so they draw one card and:


    // // player does have a card to play so they play it
    // some c: Card | (c in Game.turn.hand and playable[c]) implies {
    //     Game.lastPlayed' = c
    //     Game.turn.hand' = Game.turn.hand - c
    // } else {
    //     some c: Card | {
    //         -- card comes from deck
    //         c in Deck.cards

    //         Deck.cards' = (Deck.cards - c)

    //         -- can play it
    //         playable[c] implies {
    //             Game.lastPlayed' = c
    //             Game.turn.hand' = Game.turn.hand
    //         } else { -- can't play it
    //             Game.lastPlayed' = Game.lastPlayed
    //             Game.turn.hand' = Game.turn.hand + c
    //         }
    //     }
        
    // }

    // // change whose turn it is
    // (Game.turn = One) implies {
    //     -- hand of inactive player stays the same
    //     Two.hand' = Two.hand
    //     -- change turn
    //     Game.turn' = Two
    // }
    // (Game.turn = Two) implies {
    //     -- hand of inactive player stays the same
    //     One.hand' = One.hand
    //     -- change turn
    //     Game.turn' = One
        
    // }

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
    // move
    // next_state doNothing

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
} for 6 Int, exactly 24 NumberCard



