//
//  CreatePostViewController.swift
//  iOS-Final-Project
//
//  Created by Xcode User on 2019-04-15.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import UserNotifications

//Author: Laurence Chong
class CreatePostViewController: UIViewController {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var authUI:FUIAuth?

    @IBOutlet var btnSubmit:UIButton!
    @IBOutlet var txtTopic:UITextField!
    @IBOutlet var txtSubject:UITextField!
    @IBOutlet var txtBody:UITextView!
    
    //Submits a post
    @IBAction func btnSubmit(sender:UIButton){
        let topic = txtTopic.text!.replacingOccurrences(of: ".", with: ",")
        let subject = txtSubject.text!.replacingOccurrences(of: ".", with: ",")
        let body = txtBody.text!.replacingOccurrences(of: ".", with: ",")
        let userArr = Auth.auth().currentUser?.email?.components(separatedBy: "@")
        let user = userArr![0].replacingOccurrences(of: ".", with: ",")
        
        //Adding Threads
                mainDelegate.ref?.child("threads").childByAutoId()
                    .setValue(["topic":"\(topic)",
                               "subject":"\(subject)",
                               "body":"\(body)",
                               "date":"\(Date())",
                               "poster":"\(user)"])
        
        //Clear controllers
        txtTopic.text = ""
        txtSubject.text = ""
        txtBody.text = ""
        
        //Notify User
        let alertController = UIAlertController(title: "Success!", message: "\(user) has successfully posted something", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSubmit.layer.cornerRadius = 16
        btnSubmit.layer.borderWidth = 1.0
        btnSubmit.layer.borderColor = UIColor.blue.cgColor
        notification()
    }
    
    func notification(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in}
        
        let content = UNMutableNotificationContent()
        content.title = "Procrastinating?"
        content.body = "Procrastinate in the app instead"
        
        let date = Date().addingTimeInterval(5)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (Error) in}
    }
}
