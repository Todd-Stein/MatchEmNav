//
//  NavigationViewController.swift
//  MatchEmNav
//
//  Created by Guest User on 11/21/22.
//

import UIKit

class NavigationViewController: UIViewController {
    
 
    @IBOutlet weak var gameSpeedSlider: UISlider!
    
    @IBOutlet weak var RectangleColors: UIColorWell!
    

    @IBOutlet weak var timeText: UILabel!
    
    @IBOutlet weak var totalTimeValue: UIStepper!
    
    @IBAction func totalTimeStepper(_ sender: UIStepper) {
        timeText.text = "Time Length: \(sender.value)s"
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
