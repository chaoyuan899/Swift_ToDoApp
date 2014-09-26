//
//  Main.swift
//  ToDoApp
//
//  Created by aaron on 14-9-16.
//  Copyright (c) 2014年 The Technology Studio. All rights reserved.
//

import UIKit

class Main: UIViewController, UITableViewDataSource, UITableViewDelegate, AddProtocal {

    @IBOutlet var tableView: UITableView!
    let cellIdentifier = "Cell"

    var toDoData = [Add]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerCell()
    }
    
    func setup() {
        self.title = "To Do List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItem")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "firstAction:", name: "actionOnePressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "secondAction:", name: "actionTwoPressed", object: nil)
    }
    
    func registerCell() {
        var bundle: NSBundle = NSBundle.mainBundle()
        var nib: UINib = UINib(nibName: "Cell", bundle: bundle)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    
    func addItem() {
        let addVC: Add = Add(nibName: "Add", bundle: nil)
        addVC.delegate = self;
        self.presentViewController(addVC, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? Cell
        var str: String
        if (cell == nil) {
            let nibs:NSArray = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)
            cell = nibs.lastObject as? Cell
        }
        
        let addObject = toDoData[indexPath.row] as Add
        cell?.todoTitle.text = addObject.todo.text
        cell?.time.text = dateFormatter(addObject.time.date)
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let addVC = toDoData[indexPath.row] as Add
        addVC.delegate = nil
        self.presentViewController(addVC, animated: true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            toDoData.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
 
    func didCompleted(addObject: Add) {
  
        toDoData.append(addObject)
        toDoData.sort({ self.dateFormatter($0.time.date) < self.dateFormatter($1.time.date)})
        tableView.reloadData()
        
        var notification: UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Notification:\(addObject.todo.text)"
        notification.fireDate = addObject.time.date
        var dic:[String: NSDate] = ["fireDate":addObject.time.date]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

    }
    
    
    
    
    
    func dateFormatter(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: NSGregorianCalendar)
        let dateStr = formatter.stringFromDate(date)
        return dateStr
    }
    
    func firstAction(notification: NSNotification) {
        println("知道了")
    }
    
    func secondAction(notification: NSNotification) {
        println("去看看")
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

