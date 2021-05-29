//
//  Card.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/22/21.
//

import Foundation
import UIKit

class Card {
    
    var isHidden: Bool = true
    var isMatched: Bool = false
    var image: String = ""
    

    init() {
        
    }
    
    init(card: Card){
        self.isHidden = card.isHidden
        self.isMatched = card.isMatched
        self.image = card.image
    }

    func copy() -> Card { // Return copy of the card
        return Card(card: self)
    }
    
}

