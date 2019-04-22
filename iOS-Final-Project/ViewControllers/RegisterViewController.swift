import UIKit
import Firebase
import UserNotifications

//This ViewController is for handling account registration.
//Created by: Riya Shah External Fuctionality: Firebase 
class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfDatePicker: UITextField!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var swGender: UISwitch!
    
    //when btnRegister is pressed.
    @IBAction func btnRegister(sender: UIButton){
        if tfEmail.text!.count >= 8 && tfPassword.text!.count >= 8 {
            Auth.auth().createUser(withEmail: tfEmail.text!,
                                   password: tfPassword.text!,
                                   completion: {(user,error) in
                                    if error == nil {
                                        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
                                        
                                        //Insert account data into firebase
                                        mainDelegate.ref?.child("accounts")
                                            .child(self.tfEmail.text!.replacingOccurrences(of: ".", with: ","))
                                            .setValue(["email":"\(self.tfEmail.text!)",
                                                "name":"\(self.tfName.text!)",
                                                "phone-number": "\(self.tfPhone.text!)"])
                                        // Add more things into this Dctionary, Maybe? ^
                            
                                        do {
                                            //force to logout, and log back on the loginPage? Segue to Home?
                                            try Auth.auth().signOut()
                                            self.performSegue(withIdentifier: "backToIndex", sender: nil)
                                        } catch {}

                                    } else {
                                        print("failed to register")
                                        self.tfName.text = ""
                                        self.tfEmail.text = ""
                                        self.tfPhone.text = ""
                                        self.tfPassword.text = ""
                                        self.tfDatePicker.text=""
                                    }
            })
        } else {
            //alert this print
            print(" Please enter a valid email or password")
        }
    }
    
    // The datePicker which will be initialized when the user clicks on the text field
    let datePicker = UIDatePicker()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // when the state of the switch is changed, it will change the label to male or female accordingly
    @IBAction func stateChanged(switchState: UISwitch){
        if swGender.isOn {
            lblGender.text = "Male"
        } else {
            lblGender.text = "Female"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Uses the same notification if user left the app at this screen
        notification()
        // The max date is today
        datePicker.maximumDate = Date();


        if lblGender.text == "Male" {
            swGender.setOn(true, animated: true)
        } else {
            swGender.setOn(false, animated: true)
        }

        showDatePicker()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        tfDatePicker.inputAccessoryView = toolbar
        tfDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy"
        tfDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
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
