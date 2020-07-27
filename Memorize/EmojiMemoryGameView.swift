//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Tomas Havlicek on 21/07/2020.
//  Copyright © 2020 Tomas Havlicek. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack(alignment: .leading) {
            viewModel.currentTheme.map { currentTheme in
                VStack {
                    Text(currentTheme.name)
                        .foregroundColor(.black)
                        .font(Font.largeTitle)
                    Grid(viewModel.cards) { card in
                        CardView(card: card).onTapGesture {
                            self.viewModel.choose(card: card)
                        }.padding(self.cardPadding)
                    }
                }
                .foregroundColor(currentTheme.color)
            }
            HStack {
                Text("Score: \(self.viewModel.score)")
                Button("New game") {
                    self.viewModel.startNewGame()
                }
            }
        }
        .padding()
    }
    
    // MARK: - Drawing Constants
    let cardPadding: CGFloat = 2
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let scalingFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width,  size.height) * scalingFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
