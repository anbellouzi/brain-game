//
//  ViewController.swift
//  brainGame
//
//  Created by Anas on 11/25/19.
//  Copyright © 2019 Anas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: UIView!
    @IBOutlet weak var meaningLabel: UILabel!
    
    @IBOutlet weak var colorTextLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var upsideImageView: UIImageView!
    
    @IBOutlet weak var upImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var score: Int = 0
    var highScore: Int = 0
    var timerCount: Int = 10
    var message: String = "Game Over!"
    
    let colors: [String:UIColor] = ["red": .red,
                                    "green": .green,
                                    "yellow": .yellow,
                                    "purple": .purple,
                                    "orange": .orange,
                                    "blue": .blue,
                                    "brown": .brown,
                                    "gray": .gray]

    var currentColor: UIColor = UIColor.white
    var currentText: String = ""
    
    // view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide navbar 
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        // Show the navigation bar on other view controllers
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//    }

    // loads the view
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        refreshGame()
        runTimer()
    }
    
    // pass high score to result view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEndGame" {
            if let resultViewController = segue.destination as? resultViewController {
                    resultViewController.highScore = self.highScore
                    resultViewController.message = self.message
                
            }
        }
    }
    
   
    
    // style for user view
    func setupScene() {
        meaningLabel.layer.masksToBounds = true
        colorTextLabel.layer.masksToBounds = true
        meaningLabel.layer.cornerRadius = 20
        colorTextLabel.layer.cornerRadius = 20
        yesButton.layer.cornerRadius = 5
        noButton.layer.cornerRadius = 5
        yesButton.backgroundColor = UIColor.init(displayP3Red: 30, green: 30, blue: 30, alpha: 0.4)
        noButton.backgroundColor = UIColor.init(displayP3Red: 30, green: 30, blue: 30, alpha: 0.4)
        scoreLabel.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.2)
        scoreLabel.textColor = UIColor(white: 1, alpha: 0.5)
        timerLabel.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.2)
        timerLabel.textColor = UIColor(white: 1, alpha: 0.5)
        sceneView.backgroundColor = UIColor(patternImage: UIImage(named: "viewBg.jpg")!)
        upsideImageView.image = upsideImageView.image?.withRenderingMode(.alwaysTemplate)
        upImageView.image = upImageView.image?.withRenderingMode(.alwaysTemplate)
    }
    
    func runTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timerCount -= 1
            self.timerLabel.text = "Time  "+String(self.timerCount)+""
            
            if self.timerCount == 0 {
                self.timerCount = 0
                timer.invalidate()
                self.message = "Time is Up!"
                self.performSegue(withIdentifier: "showEndGame", sender: self)
                
            }
            if self.timerCount < 5 {
                self.messageLabel.text = ""
                self.messageLabel.font = UIFont.systemFont(ofSize: 35)
                self.animate(time: "0:"+String(self.timerCount))
                self.messageLabel.textColor = self.colors.randomElement()?.value
            }
        }
    }
    
    func animate(time: String) {
     // Fade out to set the text
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.messageLabel.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in

                //Once the label is completely invisible, set the text and fade it back in
                self.messageLabel.text = time

                // Fade in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.messageLabel.alpha = 1.0
                    }, completion: nil)
        })
    }
    
    func IncreaseDiffculty() {
        if (score  > 50) && (score <= 100){
            timerCount = 8
        }
        else if (score > 100) && (score <= 150){
            timerCount = 6
        }
        else if (score > 150) && (score <= 200){
            timerCount = 4
        }
        else if (score > 200) && (score < 250){
            timerCount = 2
        }
        else {
            timerCount = 10
        }
    }
    
    // controls current game attributes
    func refreshGame(){
        IncreaseDiffculty()
        currentText = colors.randomElement()!.key
        currentColor = colors.randomElement()!.value
        let randomColor = colors.randomElement()?.key
        
        meaningLabel.text = randomColor
        colorTextLabel.text = currentText
        meaningLabel.textColor = currentColor
        
        upsideImageView.tintColor = colors.randomElement()!.value
        upImageView.tintColor = colors[currentText]
        
        if (score <= -1) {
            score = 0
            scoreLabel.text = "HighScore   "+String(highScore)+""
            self.timerCount = 0
            performSegue(withIdentifier: "showEndGame", sender: self)
            
        } else {
            scoreLabel.text = "Score  "+String(score)+""
        }
    }
    
    // yes button
    @IBAction func yesActionButtton(_ sender: Any) {
        if(colors[currentText] == currentColor) {
            score += 10
            highScore += 10
        }
        else {
            score -= 20
        }
        
        refreshGame()
        
    }
    
    // no button
    @IBAction func noActionButton(_ sender: Any) {
        if(colors[currentText] != currentColor) {
            score += 10
            highScore += 10
        }
        else {
            score -= 20
        }
        refreshGame()
    }
}

