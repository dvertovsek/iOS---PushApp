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
    }
    
    func allItems() -> [TodoItem] {
        
        var todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(todoDictionary.values)
        let todoItemssssss = items.map({item in
//            
//            print(item.valueForKey("deadline")!)
//            
//            return TodoItem(deadline: item("title") as! String,
//                title: item.valueForKey("title")! as! String,
//                UUID: item.valueForKey("UUID")! as! String)
        })
        let todoItems = [TodoItem]()
        return todoItems
        }
}