//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tomas Havlicek on 21/07/2020.
//  Copyright © 2020 Tomas Havlicek. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>()
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var currentTheme: MemoryGame<String>.Theme? {
        model.currentTheme
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func startNewGame() {
        model.startNewGame()
    }
}
