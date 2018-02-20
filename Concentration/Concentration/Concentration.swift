//
//  Concentration.swift
//  Concentration
//
//  Created by Павел Пономарев on 01.01.18.
//  Copyright © 2018 Pavel Ponomarev. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexofOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly

        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) { ///mutating needs to reset something in the struct
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index) :  index is not in bounds")
            if !cards[index].isMatched {
            if let matchIndex = indexofOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexofOneAndOnlyFaceUpCard = index
            }

        }
        
    }
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card) /////cards += [card, card]
        }
        
        for _ in 0..<cards.count { ////that's my shuffle, might not work that good, should check normal solutions
            let firstRandom = cards.remove(at :Int(arc4random_uniform(UInt32(cards.count))))
            let secondRandom = cards.remove(at :Int(arc4random_uniform(UInt32(cards.count))))
            cards.append(firstRandom)
            cards.append(secondRandom)
        }
    }

}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
