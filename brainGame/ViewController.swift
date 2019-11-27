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
        }
    }
    
    func IncreaseDiffculty() {
        if score  > 50 {
            timerCount = 5
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

