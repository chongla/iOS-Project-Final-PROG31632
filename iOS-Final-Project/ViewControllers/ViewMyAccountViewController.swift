

import UIKit
import Firebase
import FirebaseUI
import UserNotifications

//Author: Laurence Chong
class ViewMyAccountViewController: UIViewController {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var authUI:FUIAuth?

    @IBOutlet var tfAddress:UITextField!
    @IBOutlet var tfPhone:UITextField!
    
    //Updates account in the database. Not fetching though.
    @IBAction func saveChanges(sender: UIButton){
        var email:String = (Auth.auth().currentUser?.email!)!
        var emailId:String = (Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: ","))!
        
        //Updating 
        mainDelegate.ref?.child("accounts/\(emailId)")
            .setValue(["email":"\(email)",
                "address":"\(self.tfAddress.text!)",
                "phone-number": "\(self.tfPhone.text!)"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification()
    }
    
    //Notification done by Robert.
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
