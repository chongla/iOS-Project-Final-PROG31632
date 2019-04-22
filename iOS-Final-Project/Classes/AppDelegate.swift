//
//  AppDelegate.swift
//  iOS-Final-Project
//
//  Created by Xcode User on 2019-04-04.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit
import SQLite3
import Firebase
import FirebaseUI

//Modified By: Riya Shah
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    var ref : DatabaseReference?
    var forcePlayOnce: Bool = false
    var intSelected: Int = 0
    var threads: [Thread] = []
    var window: UIWindow?
    
    //A function to fill up the tableView with the array of Thread object using SiteCell's framework layout
    func retrieveThreadsData(){
        ref?.child("threads").observe(.childAdded, with:{ (snapshot) in
            if let threadDictionary =  snapshot.value as? [String:Any]{
                let data: Thread = Thread.init()
                let topic = threadDictionary["topic"] as? String
                let subject = threadDictionary["subject"] as? String
                let body = threadDictionary["body"] as? String
                let poster = threadDictionary["poster"] as? String
                let date = threadDictionary["date"] as? String
                
                data.initWithData(topic: topic!, subject: subject!, body: body!, date: date!, poster: poster!)
                self.threads.append(data)
            }
        })
    }

    
    
    
    //SQLITE -----------------------
    // Initially used this but, didn't see a reason to implement this now that we're using firebase
    
    
    //    var databaseName: String? = "Procrastify.db"
    //    var databasePath: String?
//    func login(loginUsername user:String, loginPassword pass:String) -> Bool{
//        var db : OpaquePointer? = nil
//        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
//            print("Successfully opened connection to database path \( self.databasePath)")
//            var queryStatement : OpaquePointer? = nil
//            var queryStatementString : String = "select * from Account where Username=? AND Password=?"
//
//            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//                sqlite3_bind_text(queryStatement, 1, user, -1, nil)
//                sqlite3_bind_text(queryStatement, 2, pass, -1, nil)
//
//                if sqlite3_step(queryStatement) == SQLITE_ROW{
//                    let id:Int = Int(sqlite3_column_int(queryStatement, 0))
//                    let cusername = sqlite3_column_text(queryStatement, 1)
//                    let cpassword = sqlite3_column_text(queryStatement, 2)
//                    let cemail = sqlite3_column_text(queryStatement, 3)
//                    let cfirstName = sqlite3_column_text(queryStatement, 4)
//                    let clastName = sqlite3_column_text(queryStatement, 5)
//                    let cDetails = sqlite3_column_text(queryStatement, 6)
//
//                    let username = String(cString:cusername!)
//                    let password = String(cString:cpassword!)
//                    let email = String(cString:cemail!)
//                    let firstName = String(cString:cfirstName!)
//                    let lastName = String(cString:clastName!)
//                    let details = String(cString:cDetails!)
//
//                    let data: Account = Account.init()
//                    data.initWithAccount(accId: id, accUsername: username, accPassword: password, accEmail: email, accFirstName: firstName, accLastName: lastName, accDetails: details)
//                    account.append(data)
//
//                    print("Successfully logged in")
//                    return true;
//                } else {
//                    print("failed to login")
//                    return false;
//                }
//            } else {
//                print("unable to open db")
//                return false;
//            }
//        } else {
//            return false;
//        }
//        sqlite3_close(db)
//    }
//
//    func readDataFromDatabase(){
//        account.removeAll()
//        var db : OpaquePointer? = nil
//        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
//            print("Successfully opened connection to database path \( self.databasePath)")
//            var queryStatement : OpaquePointer? = nil
//            var queryStatementString : String = "select * from Account"
//
//            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//                while sqlite3_step(queryStatement) == SQLITE_ROW{
//                let id:Int = Int(sqlite3_column_int(queryStatement, 0))
//                let cusername = sqlite3_column_text(queryStatement, 1)
//                let cpassword = sqlite3_column_text(queryStatement, 2)
//                let cemail = sqlite3_column_text(queryStatement, 3)
//                let cfirstName = sqlite3_column_text(queryStatement, 4)
//                let clastName = sqlite3_column_text(queryStatement, 5)
//                let cDetails = sqlite3_column_text(queryStatement, 6)
//
//                let username = String(cString:cusername!)
//                let password = String(cString:cpassword!)
//                let email = String(cString:cemail!)
//                let firstName = String(cString:cfirstName!)
//                let lastName = String(cString:clastName!)
//                let details = String(cString:cDetails!)
//
//                let data: Account = Account.init()
//                data.initWithAccount(accId: id, accUsername: username, accPassword: password, accEmail: email, accFirstName: firstName, accLastName: lastName, accDetails: details)
//                account.append(data)
//
//                print("Query Result:")
//                print("\(id) | \(username) | \(password)")
//
//                }
//                sqlite3_finalize(queryStatement)
//
//            } else {
//                print("SELECT statement could not be prepared")
//            }
//
//        } else {
//            print("unable to open db")
//        }
//        sqlite3_close(db)
//    }
//
//    func checkAndCreateDatabase(){
//        var success = false
//        let fileManager = FileManager.default
//        success = fileManager.fileExists(atPath: databasePath!)
//
//        if success{
//            return
//        }
//
//        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
//
//        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
//
//    }
//
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ref = Database.database().reference()
        retrieveThreadsData()
        
// Override point for customization after application launch.   sqlite things-----
//        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//
//        let documentsDir = documentPaths[0]
//        databasePath = documentsDir.appending("/" + databaseName!)
//
//        checkAndCreateDatabase()
//        readDataFromDatabase()
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        return false
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

