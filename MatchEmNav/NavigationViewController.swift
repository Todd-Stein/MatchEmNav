//
//  NavigationViewController.swift
//  MatchEmNav
//
//  Created by Guest User on 11/21/22.
//

import UIKit

class NavigationViewController: UIViewController {
    
    @IBOutlet weak var colorWellVal: UIColorWell!
    var gameVC:GameSceneViewController?
    
    
    @objc func updateColorWell(_ sender: Any) {
        gameVC?.modulateButtonColor = colorWellVal?.selectedColor ?? .white
    }
    
    @IBAction func gameDurationUpdate(_ sender: Any) {
        let temp:Int = Int(gameDurationValue.value)
        gameDurationLabel?.text = "Game Duration: \(temp)s"
        gameVC?.totalTime = gameDurationValue.value
        gameVC?.startGame = false
    }
    @IBOutlet weak var gameDurationValue: UIStepper!
    @IBOutlet weak var gameSpeedLabel: UILabel!
    @IBOutlet weak var gameSpeedVal: UISlider!
    
    @IBOutlet weak var gameDurationLabel: UILabel!
    @IBAction func gameSpeedUpdate(_ sender: Any) {
        gameSpeedLabel?.text = "Game Speed: \(gameSpeedVal.value)"
        gameVC?.newRectTimeInterval = Double(1.2/gameSpeedVal.value)
        gameVC?.startGame = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        colorWellVal.addTarget(self, action: #selector(updateColorWell), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    
}
