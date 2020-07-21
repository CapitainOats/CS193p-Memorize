//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tomas Havlicek on 21/07/2020.
//  Copyright © 2020 Tomas Havlicek. All rights reserved.
//

import SwiftUI

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> {
        shuffled().prefix(n)
    }
}

class EmojiMemoryGame {
    private var model: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷", "🕸", "🦇", "😱", "🙀", "☠️", "💀", "🍭"]
        let gameEmojis = emojis.choose(Int.random(in: 2...5))
        return MemoryGame<String>(numberOfPairsOfCards: gameEmojis.count) { pairIndex in
            return gameEmojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
