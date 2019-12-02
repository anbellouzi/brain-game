//
//  StartViewController.swift
//  brainGame
//
//  Created by Anas on 12/2/19.
//  Copyright © 2019 Anas. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "viewBg.jpg")!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwidToStart(segue:UIStoryboardSegue) {
           
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
