//
//  ViewController.swift
//  ForceTouch
//
//  Created by ShinokiRyosei on 2016/03/05.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var onSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchOnOff(sender: UISwitch) {
        
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            if #available (iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
                    if onSwitch.on {
                        let force = touch.force/touch.maximumPossibleForce
                        label.text = "\(force*100)% force"
                    }else {
                        if touch.force >= touch.maximumPossibleForce {
                            label.text = "385+ grams"
                        }else {
                            let force = touch.force/touch.maximumPossibleForce
                            let grams = force * 385
                            label.text = "\(Int(grams)) grams"
                        }
                    }
                }
            }
        }
    }


}

