//
//  ViewController.swift
//  PushApp
//
//  Created by MTLab on 18/01/16.
//  Copyright © 2016 dare. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    let usernameTxtField = UITextField()
    let passTxtField = UITextField()
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image: UIImage = UIImage(named: "nature")!
        self.view.alpha = 0.2
        self.view.backgroundColor = UIColor(patternImage: image)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        view.heightAnchor.constraintEqualToConstant(self.view.frame.size.height * 0.4).active = true
        stackView.addArrangedSubview(view)
        
//        usernameTxtField.placeholder = "username"
        usernameTxtField.backgroundColor = UIColor(red: 194/255, green: 79/255, blue: 209/255, alpha: 0.6)
//        usernameTxtField.textColor = UIColor.greenColor()
        
        let attr = [NSForegroundColorAttributeName:UIColor.blackColor()]
        usernameTxtField.attributedPlaceholder = NSAttributedString.init(string: "user", attributes: attr)
        usernameTxtField.textAlignment = NSTextAlignment.Center
        usernameTxtField.heightAnchor.constraintEqualToConstant(self.view.frame.size.height * 0.1).active = true
        
//        let bottomBorder = CALayer()
//        bottomBorder.frame = CGRectMake(0.0, usernameTxtField.frame.size.height - 1, usernameTxtField.frame.size.width, 1.0);
//        bottomBorder.backgroundColor = UIColor.blackColor().CGColor
//        usernameTxtField.layer.addSublayer(bottomBorder)
        usernameTxtField.addTarget(self, action: "onEditingChanged", forControlEvents: UIControlEvents.EditingChanged)
        stackView.addArrangedSubview(usernameTxtField)
        
    
//        passTxtField.placeholder = "*******"
        passTxtField.secureTextEntry = true
        passTxtField.backgroundColor = UIColor(red: 194/255, green: 79/255, blue: 209/255, alpha: 0.6)
        
        passTxtField.attributedPlaceholder = NSAttributedString.init(string: "*******", attributes: attr)
        passTxtField.textAlignment = NSTextAlignment.Center
        passTxtField.heightAnchor.constraintEqualToConstant(self.view.frame.size.height * 0.1).active = true
        
//        let bottomBorder = CALayer()
//        bottomBorder.frame = CGRectMake(0.0, passTxtField.frame.size.height - 1, passTxtField.frame.size.width, 1.0);
//        bottomBorder.backgroundColor = UIColor.blackColor().CGColor
//        passTxtField.layer.addSublayer(bottomBorder)
        
        
        passTxtField.addTarget(self, action: "onEditingChanged", forControlEvents: UIControlEvents.EditingChanged)
        stackView.addArrangedSubview(passTxtField)
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.clearColor()
        view2.heightAnchor.constraintEqualToConstant(self.view.frame.size.height * 0.4).active = true
        stackView.addArrangedSubview(view2)
        
        UIView.animateWithDuration(5) { () -> Void in
            self.view.alpha = 1.0
        }

    }

    @IBAction private func onEditingChanged()
    {
        if(usernameTxtField.text?.caseInsensitiveCompare("user") == NSComparisonResult.OrderedSame && passTxtField.text?.caseInsensitiveCompare("pass") == NSComparisonResult.OrderedSame)
        {
            performSegueWithIdentifier("loginSegue", sender: self)
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
