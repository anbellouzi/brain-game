//
//  StartViewController.swift
//  brainGame
//
//  Created by Anas on 12/2/19.
//  Copyright © 2019 Anas. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    
    // hide navbar
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "viewBg.jpg")!)
        runAnimation()
        
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 20
        colorLabel.layer.masksToBounds = true
        colorLabel.layer.cornerRadius = 20
        playButton.layer.masksToBounds = true
        playButton.layer.cornerRadius = 20
        playButton.backgroundColor = UIColor.init(displayP3Red: 30, green: 30, blue: 30, alpha: 0.4)

        // Do any additional setup after loading the view.
    }
    
    // root view exit
    @IBAction func unwidToStart(segue:UIStoryboardSegue) {}


    
    
    var time = 0
    func runAnimation() {
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.welcomeLabel.alpha = 0.0
                }, completion: {
                    (finished: Bool) -> Void in

                    self.welcomeLabel.textColor = .random
                    self.colorLabel.textColor = .random
                    
                    self.time += 1
                    
                    if (self.time % 2 == 0) {
                        self.welcomeLabel.text = "Welcome To Brain Game"
                    }
                    else {
                        self.welcomeLabel.text = "Match"
                    }

                    // Fade in
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                        self.welcomeLabel.alpha = 1.0
                        }, completion: nil)
            })
        }
    }
    

}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
