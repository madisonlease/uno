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

/* EXPLORATION */
test expect {

    // can we eventually reach a state where both players have one card?
    -- yes!
    doubleUno: {
        traces
        eventually (#{card: Card | card in One.hand} = 1 and #{card: Card | card in Two.hand} = 1)
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat

    // is it possible to have a game where no one can ever play?
    -- no, because in any 7 cards there must be a playable card, so even if
    -- both players don't have a playable card to begin, once one player draws they
    -- will be able to play
    alwaysDraw: {
        traces 
        always draw
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is unsat

    // is it possible for neither player to be able to play in their first turn?
    -- yes, because there are always 6 cards that cannot be played on top of any one card
    noPlayableCards: {
        traces
        no c: Card | {
            c in One.hand
            playable[c]
        }
        no c: Card | {
            c in Two.hand 
            playable[c]
        }
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat

    // if there is no playable card in either player's hand, the next card drawn must be playable
    nextCardPlayable: {
        traces
        no c: Card | {
            c in One.hand
            playable[c]
        }
        no c: Card | {
            c in Two.hand 
            playable[c]
        }
        draw
        next_state draw
        next_state next_state (some c: Card | play[c])
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat

    // is it possible for players to never draw?
    -- yes :)
    alwaysPlay: {
        traces
        always (some c: Card | play[c])
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is sat
    
}

/* THEOREM TESTS */
test expect {

    // always wellformed
    alwaysWellformed: {
        traces implies always wellformed
    } for 5 Int, exactly 12 NumberCard, exactly 2 Player is theorem

    -- these two tests make the run time too long
    // always somethingHappens
    // alwaysSomethingHappens: {
    //     traces implies always somethingHappens
    // } for 5 Int, exactly 12 NumberCard, exactly 2 Player is theorem
    // // always lastPlayed
    // alwaysLastPlayed: {
    //     traces implies always lastPlayed
    // } for 5 Int, exactly 12 NumberCard, exactly 2 Player is theorem
}