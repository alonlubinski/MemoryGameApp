//
//  CardCell.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/24/21.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    var card:Card?
    
    func setCard(card:Card){ // Set the card and the hidden image
        self.card = card
        frontImage.image = UIImage(named: card.image)
    }
    
    func flip(flipped:Bool){ // Flip the card according to boolean value that represent if the card is flipped already
        if(flipped){
            UIView.transition(from: frontImage, to: backImage, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: backImage, to: frontImage, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
       
    }

    
}
