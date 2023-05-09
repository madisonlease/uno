#lang forge

open "uno.frg"

/* TESTS FOR FINAL STATE */

test expect {

    // final is possible with exactly 5 moves
    finalTest: {
        traces
        some c: Card | {play[c]}
        some c: Card | {next_state play[c]}
        some c: Card | {next_state next_state play[c]}
        some c: Card | {next_state next_state next_state play[c]}
        some c: Card | {next_state next_state next_state next_state play[c]}
        next_state next_state next_state next_state next_state final
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat

    // final is impossible with less than 5 moves
    notFinal: {
        traces
        some c: Card | {play[c]}
        next_state final
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

}

test expect {

    // no card can be played twice
    playSameCardTwice: {
        traces
        some c: Card | {
            play[c]
            next_state play[c]
        } 
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // can't play a card in the other player's hand
    cardStealer: {
        traces
        some c: Card | {
            c in Two.hand -- in first state it's player One's turn
            play[c]
        } 
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // can't draw if you have a playable card
    canPlayButDraws: {
        traces
        some c: Card | {
            c in Game.turn.hand
            playable[c]
        }
        draw
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // can't play nonplayable card
    nonPlayable: {
        traces
        some c: Card | {
            not playable[c]
            play[c]
        }
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat
}

test expect {
    
    // players should never both have 0 cards - after one wins nothing should happen
    bothHandsEmpty: {
        traces
        eventually(#{card: Card | card in One.hand} = 0 && #{card: Card | card in Two.hand} = 0)
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat
    
}


// can't play after final *next_state next_state next_state next_state next_state final*

// can't play and draw in one move

// can't play more than one card in the same turn

// can't draw and have less cards than you started with

// can draw and have the same number of cards you started with

// can eventually reach the final state

// can eventually get to a state where both players have one card

// always wellformed

test expect {
    alwaysWellformed: {
        traces
        always wellformed
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat
}

-- OTHER TESTS:
    

