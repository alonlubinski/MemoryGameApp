//
//  CardManager.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/24/21.
//

import Foundation

class CardManager {
    
    func getCardsArray() -> [Card] { // Generate shuffled cards array
        var cardsArray = [Card]()
        for i in 1...8 {
            let card = Card()
            card.image = "card\(i)"
            cardsArray.append(card)
            let card2 = card.copy()
            cardsArray.append(card2)
        }
        cardsArray.shuffle()
        return cardsArray
    }
    
}
