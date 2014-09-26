//
//  Add.swift
//  ToDoApp
//
//  Created by aaron on 14-9-17.
//  Copyright (c) 2014年 The Technology Studio. All rights reserved.
//

import UIKit

protocol AddProtocal {
    func didCompleted(addObject: Add)
}


class Add: UIViewController {
    
    @IBOutlet var todo: UITextField!
    @IBOutlet var desc: KCTextView!
    @IBOutlet var time: UIDatePicker!
    @IBOutlet var completeBtn: UIButton!
    var delegate: AddProtocal?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        setup()
    }
    
    func setup() {
        completeBtn.layer.cornerRadius = 5.0
        todo.placeholder = "请输入待做项"
        desc.placeholder = "请输入详细描述。"
        todo.text = self.todo.text
        desc.text = self.desc.text
        time.date = self.time.date
        time.minimumDate = NSDate.date()
        
        if delegate? == nil {
            todo.textColor = UIColor.lightGrayColor()
            todo.userInteractionEnabled = false
            desc.textColor = UIColor.lightGrayColor()
            desc.userInteractionEnabled = false
            time.userInteractionEnabled = false
            completeBtn.setTitle("好", forState: UIControlState.Normal)
        }else {
            todo.textColor = UIColor.blackColor()
            todo.userInteractionEnabled = true
            desc.textColor = UIColor.blackColor()
            desc.userInteractionEnabled = true
            time.userInteractionEnabled = true
            completeBtn.setTitle("完成", forState: UIControlState.Normal)
        }
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:"hideKeyboard")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        swipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeGesture)
        
       
    }
    
    func hideKeyboard() {
        println("swipeGesture....")
        todo.resignFirstResponder()
        desc.resignFirstResponder()
    }
    
    func shakeAnimation(sender: AnyObject) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 1/6.0, 3/6.0, 5/6.0, 1]
        animation.duration = 0.4
        animation.additive = true
        sender.layer.addAnimation(animation, forKey: "shake")
    }
    
    
    
    @IBAction func completeTouch(sender: AnyObject) {
        if (countElements(todo.text) > 0){
            delegate?.didCompleted(self)
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            shakeAnimation(todo)
        }
    }
    @IBAction func editingDidEnd(sender: UITextField) {
        if (countElements(sender.text) == 0) {
           shakeAnimation(todo)
        }
        
    }
    
}


