//
//  ViewController.swift
//  brainGame
//
//  Created by Anas on 11/25/19.
//  Copyright © 2019 Anas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var colorTextLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0
    
    let colors: [String:UIColor] = ["red": UIColor.red, "green": UIColor.green, "yellow": UIColor.yellow, "purple": UIColor.purple, "orange": UIColor.orange]

    var currentColor: UIColor = UIColor.white
    var currentText: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshGame()
    }
    
    func refreshGame(){
        currentText = colors.randomElement()!.key
        currentColor = colors.randomElement()!.value
    
        
        colorTextLabel.text = currentText
        meaningLabel.textColor = currentColor
        meaningLabel.text = colors.randomElement()?.key
        
        
        scoreLabel.text = String(score)
    }
    
    
    @IBAction func yesActionButtton(_ sender: Any) {
        if(colors[currentText] == currentColor) {
            score += 1
        }
        else {
            score -= 1
        }
        refreshGame()
        
    }
    
    @IBAction func noActionButton(_ sender: Any) {
        
        if(colors[currentText] != currentColor) {
            score += 1
        }
        else {
            score -= 1
        }
        refreshGame()
        
    }
}

