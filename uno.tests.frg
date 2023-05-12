#lang forge

open "uno.frg"

/* TESTS FOR FINAL STATE */
test expect {

    // can eventually reach the final state
    finalPossible: {
        traces
        eventually final
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat

    // final is possible with exactly 5 moves
    finalNumMoves: {
        traces
        next_state next_state next_state next_state next_state final
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat

    // final is impossible with less than 5 moves
    finalImpossible: {
        traces
        next_state next_state next_state next_state final
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // players should never both have 0 cards - after one wins nothing should happen
    bothHandsEmpty: {
        traces
        eventually(#{card: Card | card in One.hand} = 0 and #{card: Card | card in Two.hand} = 0)
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // no moves should happen after reaching a final state
    noMovesAfterFinal: {
        traces
        next_state next_state next_state next_state next_state final
        next_state next_state next_state next_state next_state eventually move
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

}

/* TESTS FOR VALID & INVALID MOVES */
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

    // can't play and draw in one move
    playAndDraw: {
        traces
        some c: Card | {
            play[c]
        }
        draw
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // can't play more than one card in the same turn
    playTwoCards: {
        traces
        some disj c1, c2: Card | {
            play[c1]
            play[c2]
        }
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // can't draw and have less cards than you started with
    drawSubtractsCards: {
        traces
        draw
        #{card: Card | card in One.hand'} < #{card: Card | card in One.hand}
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // can draw and have the same number of cards you started with
    drawAndPlay: {
        traces
        draw
        #{card: Card | card in One.hand'} = #{card: Card | card in One.hand}
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat

}

/* MISCELLANEOUS */
test expect {

    // can eventually reach a state where both players have one card
    doubleUno: {
        traces
        eventually (#{card: Card | card in One.hand} = 1 and #{card: Card | card in Two.hand} = 1)
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat

}

/* THEOREM */
test expect {

    // always wellformed
    alwaysWellformed: {
        traces implies always wellformed
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is theorem

}

