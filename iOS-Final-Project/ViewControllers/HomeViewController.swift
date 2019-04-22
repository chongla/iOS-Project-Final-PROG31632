//
//  HomeViewController.swift
//  iOS-Final-Project
//
//  Created by Xcode User on 2019-04-15.
//  Copyright © 2019 Xcode User. All rights reserved.
//

//Author: Robert Forest
import UIKit
import UserNotifications
import AVFoundation
import Firebase

private let refreshControl = UIRefreshControl()

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Segue to home/feed
    @IBAction func unwindToHomeVC(sender: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.threads.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.threads[rowNum].subject
        tableCell.secondaryLabel.text = mainDelegate.threads[rowNum].body
        tableCell.thirdLabel.text = "Posted by:" + mainDelegate.threads[rowNum].poster!
        //tableCell.myimageView.image = UIImage(named:mainDelegate.people[rowNum].avatarLink!)
        tableCell.accessoryType = .disclosureIndicator
        tableCell.backgroundColor = UIColor.clear
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainDelegate.intSelected = indexPath.row
        performSegue(withIdentifier: "toPost_vc", sender: nil)
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
