//
//  NavigationViewController.swift
//  MatchEmNav
//
//  Created by Guest User on 11/21/22.
//

import UIKit

class NavigationViewController: UIViewController {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var colorWellVal: UIColorWell!
    var gameVC:GameSceneViewController?
    
    @IBOutlet weak var colorWellLabel: UILabel!
    
    @objc func updateColorWell(_ sender: Any) {
        gameVC?.modulateButtonColor = colorWellVal?.selectedColor ?? .white
        var r:CGFloat = 1.0
        var g:CGFloat = 1.0
        var b:CGFloat = 1.0
        var a:CGFloat = 1.0
        colorWellVal.selectedColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
        colorWellLabel.text = "Modulate Color Value: (\(Int(r*255)), \(Int(g*255)), \(Int(b*255)))"
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
        colorWellVal.selectedColor = gameVC?.modulateButtonColor
        gameDurationValue?.value = gameVC!.totalTime
        gameSpeedVal.value = Float(gameVC!.newRectTimeInterval/1.2)
        
        gameSpeedLabel.text = "Game Speed: \(gameSpeedVal.value)"
        let temp:Int = Int(gameDurationValue.value)
        gameDurationLabel?.text = "Game Duration: \(temp)s"
        
        var r:CGFloat = 1.0
        var g:CGFloat = 1.0
        var b:CGFloat = 1.0
        var a:CGFloat = 1.0
        colorWellVal.selectedColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
        colorWellLabel.text = "Modulate Color Value: (\(Int(r*255)), \(Int(g*255)), \(Int(b*255)))"
        
        highScoreLabel.text = "High Scores:\n\nScore 1:\t\(gameVC?.highestScores?.score1 ?? 0)\n\nScore 2:\t\(gameVC?.highestScores?.score2 ?? 0)\n\nScore 3:\t\(gameVC?.highestScores?.score3 ?? 0)"
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    
}
