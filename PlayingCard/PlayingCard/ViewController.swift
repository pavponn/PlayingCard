//
//  ViewController.swift
//  PlayingCard
//
//  Created by Павел Пономарев on 04.02.2018.
//  Copyright © 2018 Pavel Ponomarev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left,.right]
            playingCardView.addGestureRecognizer(swipe)
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
   
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
             playingCardView.isFaceUp = !playingCardView.isFaceUp
        default:
            break;
        }
       
    }
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    var deck = PlayingCardDeck()
    override func viewDidLoad() {
        super.viewDidLoad()
    }



}

