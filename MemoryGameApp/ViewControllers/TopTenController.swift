//
//  TopTenController.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/29/21.
//

import UIKit

class TopTenController: UIViewController {

    @IBOutlet weak var tt_BTN_back: UIButton!
    var topTenManager = TopTenManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var highscores = topTenManager.getHighscores() as [Record]
        for i in 0...highscores.count - 1 {
            print("\(i+1). \(highscores[i].name) -  \(highscores[i].time)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
