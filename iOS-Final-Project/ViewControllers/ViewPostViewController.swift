//
//  ViewPostViewController.swift
//  iOS-Final-Project
//
//  Created by Xcode User on 2019-04-15.
//  Copyright © 2019 Xcode User. All rights reserved.
//

//Author: Giriraj Bhagat
import UIKit
import UserNotifications

//View Post VC
class ViewPostViewController: UIViewController {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var lblTopic:UILabel!
    @IBOutlet var lblSubject:UILabel!
    @IBOutlet var lblBody:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var lblPoster:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Displays the post that is selected from the table view
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        lblTopic.text = mainDelegate.threads[mainDelegate.intSelected].topic
        lblSubject.text = mainDelegate.threads[mainDelegate.intSelected].subject
        lblBody.text = mainDelegate.threads[mainDelegate.intSelected].body
        lblDate.text = mainDelegate.threads[mainDelegate.intSelected].date
        lblPoster.text = mainDelegate.threads[mainDelegate.intSelected].poster
        notification()
    }
    
    //Roberts Functionality
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
