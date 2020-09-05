//
//  ViewController.swift
//  Clicker
//
//  Created by Abhinav Gupta on 4/23/20.
//  Copyright © 2020 Abhinav Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //UI Elements
    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var counterButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //Variables for the Timer
    var seconds = 15
    var timer = Timer()
    var isTimerRunning = false
    
    //Variables for scorekeeping
    var counter = 0
    var highscore = 0
    
    //Hide the UI elements and set background to darkmode
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark
        timerLabel.isHidden = true
        counterButton.isHidden = true
        counterButton.isEnabled = false
        scoreLabel.isHidden = true
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    //Starts the timer and shows button that will be tapped
    @objc func runTimer() {
        timerLabel.text = "Time left: \(seconds)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        counterButton.isHidden = false
        counterButton.isEnabled = true
    }
    
    //Keeps track of timer runnning down
    @objc func updateTimer() {
        if seconds > 0 {
            seconds -= 1
            timerLabel.text = "Time left: \(seconds)"
        } else if seconds == 0 {
            resetGame()
        }
    }

    //Resets variables and UI elements shown
    func resetGame() {
        timer.invalidate()
        timerLabel.isHidden = true
        clickButton.isHidden = false
        clickButton.isEnabled = true
        counterButton.isHidden = true
        counterButton.isEnabled = false
        setHigh()
        seconds = 15
    }
    
    //Sets the new high score
    func setHigh() {
        if counter > highscore {
            highscore = counter
        }
        scoreLabel.isHidden = false
        scoreLabel.text = "Highscore: \(highscore)"
    }
    
    //Givs notices and brings up necessay buttons
    func playGame() {
        self.timerLabel.text = "Click fast when you see \"Go!\""
        self.timerLabel.isHidden = false
        clickButton.isHidden = true
        self.clickButton.isEnabled = false
        
        
        perform(#selector(runTimer), with:nil, afterDelay: 2)
    }

    //Gives response to inital button to start game
    @IBAction func popUp(_ sender: UIButton) {
        if clickButton.backgroundColor == UIColor.red {
            clickButton.backgroundColor = UIColor.blue
        } else {
            clickButton.backgroundColor = UIColor.red
        }
        
        let alertController = UIAlertController(
            title: "Read Below:",
            message: "Do you wanna play a game?",
            preferredStyle: UIAlertController.Style.alert
        )
        
        let cancelAction = UIAlertAction(title: "Nah", style: UIAlertAction.Style.cancel)
        let okayAction = UIAlertAction(title: "Sure", style: UIAlertAction.Style.default, handler: {action in self.playGame()})
        
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        
        self.present(alertController, animated:true, completion:nil)
        }
    
    @IBAction func addCounter(_sender: UIButton) {
        counter += 1
    }
}


