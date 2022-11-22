//
//  ViewController.swift
//  MatchEmScene
//
//  Created by Guest User on 9/21/22.
//

import UIKit

class GameSceneViewController: UIViewController {


    @IBAction func unwindToPrev(unwindSegue: UIStoryboardSegue) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as? NavigationViewController
        navVC?.gameVC = self
    }
    
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBAction func buttonPress(_ sender: Any) {
        print("press")
    }
    
    
    @IBOutlet weak var GameViewLabel: UILabel!
    
    @IBAction func startButton(_ sender: UIButton) {
        startGameRunning()
        pauseButton.isEnabled = true
        pauseButton.alpha = 1.0
        sender.removeFromSuperview()
    }
    private let rectSizeMin:CGFloat = 50.0, rectSizeMax:CGFloat = 150.0
    
    private var rectanglesDict:[UIButton: UIButton] = [:]
    private var newRectTimeInterval:Double = 1.2
    private var timerInterval:Double = 1.0
    private var rectTimer:Timer?
    
    private var restart:UIButton?
    
    
    private var startGame:Bool = false
    
    private var timeRemainingTimer:Timer?
    public var totalTime:Double = 12
    private var timePassed:Double = 0 {
        didSet{GameViewLabel?.text = gameInfo}
    }
    
    private var pairsMatched:Int = 0 {
        didSet{GameViewLabel?.text = gameInfo}
    }
    private var numPairsAdded:Int = 0 {
        didSet{GameViewLabel?.text = gameInfo}
    }
    private var gameInfo:String {
        let temp:Int = Int((totalTime-timePassed).rounded())
        let labeltext = "Num pairs matched: \(pairsMatched) \n Num pairs added: \(numPairsAdded) \n Time left: \(temp)"
        return labeltext
    }
    
    private var currentlySelected:UIButton? = nil
    private func startGameRunning() {
        timeRemainingTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(GameSceneViewController.updateMainTimer), userInfo: nil, repeats: true)
        rectTimer = Timer.scheduledTimer(timeInterval: newRectTimeInterval, target: self, selector: #selector(GameSceneViewController.CreateRectangle), userInfo: nil, repeats: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        pauseButton.alpha = 0.0
        // Do any additional setup after loading the view.
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func updateMainTimer() {
        timePassed += timerInterval
        if(timePassed>=totalTime) {
            timeRemainingTimer?.invalidate()
            CreateRectangle()
        }
    }
    @objc private func CreateRectangle() {
        //timePassed += newRectTimeInterval
        if(timePassed<totalTime) {
            let ScreenSize = self.view.bounds
            let width = CGFloat.random(in: rectSizeMin...rectSizeMax)
            let height = CGFloat.random(in: rectSizeMin...rectSizeMax)
            //let tempX:CGFloat = ScreenSize.width-width
            //let tempY:CGFloat = ScreenSize.height-height
            var xPos = CGFloat.random(in: 0.0...ScreenSize.width)
            var yPos = CGFloat.random(in: 0.0...ScreenSize.height)
            if(xPos+width>=ScreenSize.width) {
                xPos-=width
            }
            if(yPos+width>=ScreenSize.height) {
                yPos-=height
            }
            let red = CGFloat.random(in: 0.0...1.0)
            let blue = CGFloat.random(in: 0.0...1.0)
            let green = CGFloat.random(in: 0.0...1.0)
            let rectFrame1 = CGRect(x: xPos, y: yPos, width: width, height: height)
            xPos = CGFloat.random(in: 0.0...ScreenSize.width)
            yPos = CGFloat.random(in: 0.0...ScreenSize.height)
            if(xPos+width>=ScreenSize.width) {
                xPos-=width
            }
            if(yPos+width>=ScreenSize.height) {
                yPos-=height
            }
            let rectFrame2 = CGRect(x: xPos, y: yPos, width: width, height: height)
            let button1: UIButton = UIButton(frame: rectFrame1)
            let button2: UIButton = UIButton(frame: rectFrame2)
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            button1.backgroundColor = color
            button2.backgroundColor = color
            rectanglesDict[button1] = button2
            self.view.addSubview(button1)
            self.view.addSubview(button2)
            button1.addTarget(self, action: #selector(self.handleTouch(sender:)),for: .touchUpInside)
            button2.addTarget(self, action: #selector(self.handleTouch(sender:)),for: .touchUpInside)
            numPairsAdded+=1
        }
        else {
            for temp in rectanglesDict {
                temp.key.removeFromSuperview()
                temp.value.removeFromSuperview()
            }
            print("restart")
            let ScreenSize = self.view.bounds
            timePassed = 12
            timeRemainingTimer?.invalidate()
            rectTimer?.invalidate()
            startGame = false
            let restartRect = CGRect(x: 139, y: 409, width: 137, height: 78)
            let restartButton:UIButton = UIButton(frame: restartRect)
            restartButton.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
            restartButton.setTitle("Restart", for: .normal)
            self.view.addSubview(restartButton)
            restartButton.addTarget(self, action: #selector(self.handleTouch(sender:)),for: .touchUpInside)
            self.view.bringSubviewToFront(restartButton)
            restart = restartButton
        }
        view.bringSubviewToFront(GameViewLabel)
    }
    @objc private func handleTouch(sender: UIButton) {
        if(timeRemainingTimer?.isValid == true) {
            if(currentlySelected == nil) {
            currentlySelected = sender
            sender.setTitle("👍", for: .normal)
            }
            else {
                for temp in rectanglesDict {
                    if (temp.key == currentlySelected) {
                        if(temp.value == sender) {
                            removeRect(rect: temp.key)
                            currentlySelected = nil
                            temp.key.removeFromSuperview()
                            removeRect(rect: sender)
                            pairsMatched+=1
                            sender.removeFromSuperview()
                            rectanglesDict.removeValue(forKey: temp.key)
                            return
                        }
                    }
                    else if (temp.key == sender) {
                        if(temp.value == currentlySelected) {
                            removeRect(rect: temp.value)
                            currentlySelected = nil
                            temp.value.removeFromSuperview()
                            removeRect(rect: sender)
                            pairsMatched+=1
                            sender.removeFromSuperview()
                            rectanglesDict.removeValue(forKey: sender)
                            return
                        }
                    }
                    
                }
                currentlySelected?.setTitle("", for: .normal)
                currentlySelected = nil
            }
            //sender.removeFromSuperview()
            //numRectsTouched+=1
        }
        else {
            if(sender == restart) {
                restart?.removeFromSuperview()
                restart = nil
                rectanglesDict.removeAll()
                timePassed = 0.0
                pairsMatched = 0
                numPairsAdded = 0
                startGameRunning()
            }
        }
    }
    func removeRect(rect: UIButton) {
            let anim = UIViewPropertyAnimator(duration: 2.0, curve: .linear, animations: nil)
            anim.addAnimations {
                rect.alpha = 0.0
            }
            anim.startAnimation()
        }
}

