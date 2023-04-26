#lang forge --idk if we're actually supposed to name it

abstract sig Color {}
sig Red extends Color {}
sig Blue extends Color {}
sig Yellow extends Color {}
sig Green extends Color {}

abstract sig Card {}
sig NumberCard extends Card {
    color: one Color,
    number: one Int
}

one sig Deck {
    cards: set Card,
    top: one Card
}
one sig Discard {
    lastPlayed: one Card
}

sig UnoState {
    next: one UnoState,
    turn: one Player,
    currentHands: pfunc Player -> Hand,
    deck: one Deck,
    discard: one Discard
}

abstract sig Player {}
one sig One, Two extends Player {
    hand: set Card
}

one sig Game {
    players: set Player,
    initial: one UnoState
    // next: pfunc UnoState -> UnoState
}

pred wellformed[s: UnoState] {
    
    -- Q: all of these constraints feel like they would already happen based on how
    -- we are planning on moving around cards, would forge duplicate card sigs by itself?

    // no intersection between the two hands
    no s.currentHands[One] & s.currentHands[Two]
    // no intersection between the deck & hands
    no Deck.cards & s.currentHands[One]
    no Deck.cards & s.currentHands[Two]
    // no intersection between the deck & discard
    no Deck.cards & Discard.lastPlayed
    // no intersection between the discard & hands
    no Discard.lastPlayed & s.currentHands[One]
    no Discard.lastPlayed & s.currentHands[Two]
    
    // currentHands pfunc matches up with hands of player sigs -- Q: worried about this
    s.currentHands[One] = One.hand
    s.currentHands[One] = Two.hand
    
}

pred init[s: UnoState] {
    
    // no discard pile
    no s.discard.lastPlayed
    // each player's hand has the correct number of cards
    #{card: Card | card in s.playerOneHand} = 4
    #{card: Card | card in s.playerTwoHand} = 4
    // the hands have unique cards
    
    // the deck has the original number of cards minus the cards in each player's hand
    #{card: Card | card in s.deck.cards} = 32

    // it's player One's turn
    s.turn = One
    
}

pred final[s: UnoState] {
    // one player must have no cards left
    (#{card: Card | card in s.playerOneHand} = 0) or (#{card: Card | card in s.playerTwoHand} = 0)
    
    // the other player should have cards left?? Q: is this necessary?
    (#{card: Card | card in s.playerOneHand} > 0) or (#{card: Card | card in s.playerTwoHand} > 0)
    
}

pred move[s: UnoState] {

    // GUARD

    // ACTION

    // one player either...

    // draws one card and doesn't play or
    
    -- if drawn card is playable, it should be played (in discard in next state)
    playable[s.deck.top] implies s.deck.top in s.next.discard.lastPlayed
    
    -- if drawn card is not playable, it should be in the correct player's hand in next state
    
    not playable[s.deck.top] implies s.deck.top in s.next.currentHands[s.turn]


    -- the top card of the next state's deck is randomly selected(?) from the rest of the deck

    -- state's deck is current state's deck without current state's top
    s.next.deck.cards = s.deck.cards - s.deck.top
    
    // plays one card from their hand or

    // draws one card then plays it

    // change whose turn it is
    s.turn = One implies s.next.turn = Two
    s.turn = Two implies s.next.turn = One

    // MAINTAIN PREVIOUS/UNINVOLVED fields
    all p:Player | (p != s.turn) implies {
        s.currentHands[p] = s.next.currentHands[p]
    }

}

pred playable[playablecard: Card] {
    // the card needs to be valid to be played according to the last discarded card
    playablecard.number = Discard.lastPlayed.number or 
    playablecard.color = Discard.lastPlayed.color 
}

pred doNothing[currentState: UnoState] {

    // GUARD

    -- must be a final state
    final[currentState]

    // ACTION

    -- nothing changes between states
    currentState.next.turn = currentState.turn
    currentState.next.currentHands = currentState.currentHands
    currentState.next.deck = currentState.deck
    currentState.next.discard = currentState.discard

}

pred traces {
    
    init[Game.initial]
    
    // initial is actually the first state (initial isn't the next state of any state)
    all s : UnoState | {
        s.next != Game.initial
    }

    all s: UnoState | some Game.next[b] implies {
        some row, col: Int | {
            move[b, Game.next[b], row, col]            
        }
        or
            doNothing[b, Game.next[b]]
    }

    // no partial traces; Game must be over at end of trace
    // some b : Board | no Game.next[b] and final[b]

}

run {
    all s : UnoState | wellformed[s]
    traces
} for exactly 10 UnoState for {next is linear}



