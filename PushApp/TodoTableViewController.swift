//
//  TodoTableViewController.swift
//  PushApp
//
//  Created by MTLab on 20/01/16.
//  Copyright © 2016 dare. All rights reserved.
//
import Foundation
import UIKit

class TodoTableViewController: UITableViewController {

    var todoItems: [TodoItem] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList", name: "TodoListShouldRefresh", object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }
    
    func refreshList(){
        todoItems = TodoList.sharedInstance.allItems()
        
        if todoItems.count >= 64
        {
            self.navigationItem.rightBarButtonItem!.enabled = false
        }
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath)
        let todoItem = todoItems[indexPath.row]
        cell.textLabel!.text = todoItem.title
        if(todoItem.isOverdue)
        {
            cell.detailTextLabel?.textColor = UIColor.redColor()
        }else{
            cell.detailTextLabel!.textColor = UIColor.blackColor()
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "'Due' MMM dd 'at' h:mm a"
        cell.detailTextLabel!.text = dateFormatter.stringFromDate(todoItem.deadline)
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
        {
            let item = todoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            TodoList.sharedInstance.removeItem(item)
            self.navigationItem.rightBarButtonItem!.enabled = true
        }
    }
    
}