//
//  NavigationViewController.swift
//  MatchEmNav
//
//  Created by Guest User on 11/21/22.
//

import UIKit

class NavigationViewController: UIViewController {
    
    var gameVC:GameSceneViewController?
    
    @IBAction func gameDurationUpdate(_ sender: Any) {
        let temp:Int = Int(gameDurationValue.value)
        gameDurationLabel?.text = "Game Duration: \(temp)s"
        gameVC?.totalTime = gameDurationValue.value
    }
    @IBOutlet weak var gameDurationValue: UIStepper!
    @IBOutlet weak var gameSpeedLabel: UILabel!
    @IBOutlet weak var gameSpeedVal: UISlider!
    
    @IBOutlet weak var gameDurationLabel: UILabel!
    @IBAction func gameSpeedUpdate(_ sender: Any) {
        gameSpeedLabel?.text = "Game Speed: \(gameSpeedVal.value)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    
}
