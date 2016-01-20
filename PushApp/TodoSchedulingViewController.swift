//
//  TodoSchedulingViewController.swift
//  PushApp
//
//  Created by MTLab on 20/01/16.
//  Copyright © 2016 dare. All rights reserved.
//

import UIKit

class TodoSchedulingViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func savePressed(sender: UIButton) {
        
        let todoItem = TodoItem(deadline: deadlinePicker.date, title: titleField.text!, UUID: NSUUID().UUIDString)
        TodoList.sharedInstance.addItem(todoItem)
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
}
