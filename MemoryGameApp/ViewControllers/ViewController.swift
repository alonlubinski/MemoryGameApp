//
//  ViewController.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var main_BTN_start: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonClicked(_ sender: Any) { // Open the game controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "gameVC")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
}

