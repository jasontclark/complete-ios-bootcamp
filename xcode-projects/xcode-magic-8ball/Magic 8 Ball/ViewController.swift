//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Jay Clark on 1/18/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var ballArray : [String] = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    var randomBallNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        randomBallNumber = Int(arc4random_uniform(5))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askButtonPressed(_ sender: Any) {
        randomBallNumber = Int(arc4random_uniform(5))
        print(randomBallNumber)
    }
    
}

