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
    var score: Int = 0
    var highScore: Int = 0
    
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
    }
    
    // pass high score to result view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEndGame" {
            if let resultViewController = segue.destination as? resultViewController {
                    resultViewController.highScore = self.highScore
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
        sceneView.backgroundColor = UIColor(patternImage: UIImage(named: "viewBg.jpg")!)
        
        upsideImageView.image = upsideImageView.image?.withRenderingMode(.alwaysTemplate)
        upImageView.image = upImageView.image?.withRenderingMode(.alwaysTemplate)
        
        
    }

    // controls current game attributes
    func refreshGame(){
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
            scoreLabel.text = String(highScore)
            performSegue(withIdentifier: "showEndGame", sender: self)
            
        } else {
            scoreLabel.text = String(score)
        }
    }
    
    // yes button
    @IBAction func yesActionButtton(_ sender: Any) {
        if(colors[currentText] == currentColor) {
            score += 500
            highScore += 500
        }
        else {
            score -= 500
        }
        refreshGame()
        
    }
    
    // no button
    @IBAction func noActionButton(_ sender: Any) {
        if(colors[currentText] != currentColor) {
            score += 500
            highScore += 500
        }
        else {
            score -= 500
        }
        refreshGame()
    }
}

