//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tomas Havlicek on 21/07/2020.
//  Copyright © 2020 Tomas Havlicek. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card> = []
    
    var currentTheme: Theme?
    
    var score: Int = 0
    
    let themes: Array<Theme> = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🕸", "🦇", "😱", "🙀", "☠️", "💀", "🍭"], color: Color.orange),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🦊", "🐻", "🐝", "🐼"], color: Color.red),
        Theme(name: "Food", emojis: ["🍏", "🍒", "🍉", "🍌", "🥕", "🥦", "🍇", "🍍"], color: Color.green),
        Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜"], color: Color.purple),
        Theme(name: "Flags", emojis: ["🇨🇿", "🇸🇰", "🇵🇱", "🇩🇪", "🇭🇺"], color: Color.blue, numberOfPairsOfCards: 5),
        Theme(name: "Faces", emojis: ["😀", "😆", "🤣", "😇", "🙃", "😍", "🤓", "😎", "🤩", "🥳", "🤯", "🥶", "🤮"], color: Color.yellow),
    ]
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                if cards[index].isFaceUp && !cards[index].seen && index != newValue {
                    cards[index].seen = true
                }
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let choosenIndex = cards.firstIndex(matching: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched {
            if let potentionalMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[choosenIndex].content == cards[potentionalMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentionalMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[choosenIndex].seen {
                        score -= 1
                    }
                    if cards[potentionalMatchIndex].seen {
                        score -= 1
                    }
                }
                self.cards[choosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
        }
    }
    
    mutating func startNewGame() {
        if let theme = themes.randomElement() {
            currentTheme = theme
            score = 0
            cards = []
            let numberOfPairsOfCards = theme.numberOfPairsOfCards != nil ? theme.numberOfPairsOfCards! : Int.random(in: 2...theme.emojis.count)
            for pairIndex in 0..<numberOfPairsOfCards {
                let content = theme.emojis[pairIndex]
                cards.append(Card(content: content as! CardContent, id: pairIndex*2))
                cards.append(Card(content: content as! CardContent, id: pairIndex*2+1))
            }
            cards.shuffle()
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var seen: Bool = false
    }
    
    struct Theme {
        var name: String
        var emojis: Array<String>
        var color: Color
        var numberOfPairsOfCards: Int?
    }
}
