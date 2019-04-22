//ViewController
//This ViewController is the landing page of the app. This will display an option for the user: Login or Register. If Logging in, they will have an option to login with their google account. If register, they will be asked for email and password.
//Author: Riya Shah, External Functionality Used: Firebase Authentication
import UIKit
import FirebaseUI
import Firebase
import UserNotifications
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate, FUIAuthDelegate{
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var authUI:FUIAuth?
    var soundPlayer: AVAudioPlayer?
    @IBOutlet var txtUsername:UITextField!
    @IBOutlet var txtPassword:UITextField!
    @IBOutlet var btnLogin:UIButton!
    @IBOutlet var btnRegister:UIButton!
    
    //Segue back to this ViewController from others.
    @IBAction func unwindToIndexVC(sender: UIStoryboardSegue){}
    
    //This button action event is handled by the button: btnLogin, it will authenticate the user and log the user in.
    @IBAction func testLogin(sender:UIButton){
        //Check to see if previous session was not logged off
        if Auth.auth().currentUser == nil {
            if let authVC = authUI?.authViewController(){
                //Presents authentication view controller that handles the login.
                present(authVC, animated: true, completion: nil)
            }
            
            //If the user is already authenticated, proceed.
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: "toHomeViewController", sender: nil)
            }
        } else { // proceed if the user was not logged off
            self.performSegue(withIdentifier: "toHomeViewController", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification()  //Send notification
        initializeControlsInView() //initialize button style
        playSound() //When launched the first time, there should be a sound
      
        //for authentication
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        let providers :[FUIAuthProvider] = [FUIGoogleAuth(), FUIEmailAuth()]
        authUI?.providers = providers
        
        //Disabled if a user is not logged off
        if Auth.auth().currentUser != nil {
            btnRegister.isEnabled = false
        }
    }
    
    //Function to handle authentication
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error == nil {
            self.performSegue(withIdentifier: "toHomeViewController", sender: nil)
        }
    }
    
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return textField.resignFirstResponder()
//    }
    
    func playSound(){
        let soundURL = Bundle.main.path(forResource: "windowXPsound", ofType: "mp3")
        let url = URL(fileURLWithPath: soundURL!)
        soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        soundPlayer?.currentTime = 0
        soundPlayer?.volume = 30
        soundPlayer?.numberOfLoops = 0
        
        if mainDelegate.forcePlayOnce == false {
            soundPlayer?.play()
            mainDelegate.forcePlayOnce = true
        }
    
    }
    
    func initializeControlsInView(){
        //UITextField Controllers
        txtUsername.layer.cornerRadius = 16
        txtUsername.layer.borderWidth = 1
        txtUsername.layer.borderColor = UIColor.green.cgColor
        txtPassword.layer.cornerRadius = 16
        txtPassword.layer.borderWidth = 1
        txtPassword.layer.borderColor = UIColor.green.cgColor
        
        //UIButton Controllers
        btnLogin.layer.cornerRadius = 16
        btnLogin.layer.borderWidth = 1.0
        btnLogin.layer.borderColor = UIColor.blue.cgColor
        btnRegister.layer.cornerRadius = 16
        btnRegister.layer.borderWidth = 1
        btnRegister.layer.borderColor = UIColor.blue.cgColor
    }
    
    
    //Notification function
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

