//
//  GameController.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/22/21.
//

import UIKit

class GameController: UIViewController {

    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var cardsArray = [Card]()
    var cardsManager = CardManager()
    var firstIndex:IndexPath?
    var secondIndext:IndexPath?
    var movesCounter:Int = 0
    var timerCounter:Int = 0
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        
        startGame()
    }
    
    @objc func timerTick() { // The timer call this function every 1 sec
        let hours = timerCounter / 3600
        let minutes = timerCounter / 60 % 60
        let seconds = timerCounter % 60
        timerLabel.text = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        timerCounter += 1
    }
    
    func checkForWin() -> Bool{ // Return if all the cards are matched (other words - if the game ends)
        for card in cardsArray{
            if(!card.isMatched){
                return false
            }
        }
        return true
    }
    
    func showEndDialog() { // Show end dialog
        let dialog = UIAlertController(title: "Congratsulation", message: "Congratsulation! You Won!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }
        
        let replayAction = UIAlertAction(title: "Play Again", style: .default) { UIAlertAction in
            self.clearGameBoard()
            self.startGame()
        }
        
        dialog.addAction(okAction)
        dialog.addAction(replayAction)
        
        present(dialog, animated: true, completion: nil)
    }
    
    func startGame() { // Function that starts the game (generate cards array and start the timer)
        cardsArray = cardsManager.getCardsArray()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        gameCollectionView.reloadData()
    }
    
    func clearGameBoard() { // Function that resets the collection view and other data for a new game
        cardsArray.removeAll()
        movesCounter = 0
        movesLabel.text = "Moves \(movesCounter)"
        timerCounter = 0
        for cell in gameCollectionView.visibleCells as! [CardCell]{
            cell.flip(flipped: true)
            cell.frontImage.alpha = 1.0
        }
        firstIndex = nil
        secondIndext = nil
    }
    
}

extension GameController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCell
        let card = cardsArray[indexPath.row]
        cell.setCard(card: card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        let card = cardsArray[indexPath.row]
        if(card.isHidden){
            cell.flip(flipped: false)
            card.isHidden = false;
            if(firstIndex == nil){ // Check if firstIndex is nil -> if true so this is the first card
                firstIndex = indexPath
            } else { // This is the second card
                secondIndext = indexPath
                movesCounter += 1
                movesLabel.text = "Moves: \(movesCounter)"
                let card1 = cardsArray[firstIndex!.row]
                let cell1 = collectionView.cellForItem(at: firstIndex!) as! CardCell
                let card2 = cardsArray[secondIndext!.row]
                if(card1.image == card2.image){
                    card1.isMatched = true
                    card2.isMatched = true
                    cell.frontImage.alpha = 0.6
                    cell1.frontImage.alpha = 0.6
                    if(checkForWin()){ // If the game is over
                        timer?.invalidate() // Stop timer
                        showEndDialog()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { // Delay for showing both cards and then flip
                        cell.flip(flipped: true)
                        cell1.flip(flipped: true)
                        card1.isHidden = true
                        card2.isHidden = true
                    }
                    
                }
                firstIndex = nil
                secondIndext = nil
            }
        }
    }
    

}

extension GameController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(view.frame.width) - 50
        let widthPerItem = width / 4
        var res = CGSize(width: widthPerItem, height: widthPerItem)
        res.height = (collectionViewLayout.collectionView!.visibleSize.height / 4 - CGFloat(25))
        return res
    }
}

