//
//  WebContentViewController.swift
//  iOS-Final-Project
//
//  Created by Xcode User on 2019-04-15.
//  Copyright © 2019 Xcode User. All rights reserved.
//

//Author: Laurence Chong,
import UIKit
import WebKit
import UserNotifications

//View Controller - that displays a website that is telling definition of "Procrastify"
class WebContentViewController: UIViewController, WKNavigationDelegate {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var webView:WKWebView!
    @IBOutlet var activity:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize webview
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        let urlAddress = URL(string: "https://www.google.com/search?q=Procrastify")
        let url=URLRequest(url: urlAddress!)
        webView.load(url)
        webView.navigationDelegate=self
        notification()
    }
    
    //webview functionality
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    //webview functionality
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }

    //Robert's functions
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
