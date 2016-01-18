//
//  ViewController.swift
//  PushApp
//
//  Created by MTLab on 18/01/16.
//  Copyright © 2016 dare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.alpha = 0
        label.setTextWithTypeAnimation("Check events", characterInterval: 0.08)
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
            UIView.animateWithDuration(1.9) { () -> Void in
                self.label.alpha = 1
                self.label.alpha = 1
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UILabel {
    
    func setTextWithTypeAnimation(typedText: String, characterInterval: NSTimeInterval = 0.25) {
        text = ""
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
            for character in typedText.characters {
                dispatch_async(dispatch_get_main_queue()) {
                    self.text = self.text! + String(character)
                }
                NSThread.sleepForTimeInterval(characterInterval)
            }
        }
    }
    
}
