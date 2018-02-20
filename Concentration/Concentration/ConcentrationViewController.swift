//
//  ViewController.swift
//  Concentration
//
//  Created by Павел Пономарев on 01.01.18.
//  Copyright © 2018 Pavel Ponomarev. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)" , attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    @IBOutlet private var cardButtons: [UIButton]! //Array<UIButton>
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        let cardNumber = cardButtons.index(of: sender)!
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                    button.isEnabled = card.isMatched ? false : true
                }
                
            }
        }
        
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal);
            button.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal);
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    var theme : String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    private var emojiChoices = "🎃👻🤡👺👾💩🦇🕷🤖"
    private var emoji = [Card:String]()

    private func emoji(for card: Card) -> String {
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }
}


extension Int {
    var arc4random: Int {
        if (self > 0) {
            return Int(arc4random_uniform(UInt32(self)))
        } else if (self < 0) {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

