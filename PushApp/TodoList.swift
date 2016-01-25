import Foundation
import UIKit

class TodoList{

    private let ITEMS_KEY = "todoItems"
    
    class var sharedInstance: TodoList {
        struct Static{
            static let instance: TodoList = TodoList()
        }
        return Static.instance
    }
    
    func addItem(item:TodoItem){
        var todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary()
        
        todoDictionary[item.UUID] = ["deadline":item.deadline, "title":item.title,"UUID":item.UUID]
        NSUserDefaults.standardUserDefaults().setObject(todoDictionary, forKey: ITEMS_KEY)
        
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item \"\(item.title)\" is overdue"
        notification.alertAction = "open"
        notification.fireDate = item.deadline
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["UUID":item.UUID]
        notification.category = "TODO_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        self.setBadgeNumbers()
    }
    
    func allItems() -> [TodoItem] {
        
        let todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(todoDictionary.values)
        let todoItems = items.map({
            item in
            
        return TodoItem(deadline: item.valueForKey("deadline")! as! NSDate,
                        title: item.valueForKey("title")! as! String,
                        UUID: item.valueForKey("UUID")! as! String)
        }).sort({ (t1: TodoItem, t2: TodoItem) -> Bool in
            return t1.deadline.compare(t2.deadline) == NSComparisonResult.OrderedDescending
        })
        
        return todoItems
        }
    
    func removeItem(item: TodoItem)
    {
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications!{
            if(notification.userInfo!["UUID"] as! String == item.UUID)
            {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
        if var todoItems = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY)
        {
            todoItems.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(todoItems, forKey: ITEMS_KEY)
        }
        self.setBadgeNumbers()
    }
    
    func setBadgeNumbers(){
        let notifications = UIApplication.sharedApplication().scheduledLocalNotifications!
        let todoItems:[TodoItem] = self.allItems()
        for notification in notifications{
            let overdueItems = todoItems.filter({ (todoItem) -> Bool in
                return todoItem.deadline.compare(notification.fireDate!) != .OrderedDescending
            })
            UIApplication.sharedApplication().cancelLocalNotification(notification)
            notification.applicationIconBadgeNumber = overdueItems.count
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func scheduleReminderForItem(item:TodoItem)
    {
        let notification = UILocalNotification()
        
        notification.alertBody = "Reminder: Todo Item \"\(item.title)\" is overdue"
        notification.alertAction = "open"
        notification.fireDate = NSDate().dateByAddingTimeInterval(30*60)
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["title":item.title, "UUID":item.UUID]
        notification.category = "TODO_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}