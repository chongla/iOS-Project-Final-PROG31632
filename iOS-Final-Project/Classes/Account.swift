//
//  Account.swift
//  iOS-Final-Project
//
//  Created by Xcode User on 2019-04-04.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

//Account/User object
//Author: Giriraj Bhagat
// wasnt able to use this object on time
class Account: NSObject {
    var id: Int?
    var username: String?
    var password: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var details: String?
//    var accountCreated: Date?
    
    func initWithAccount(accId i:Int,
                         accUsername accountUsername:String,
                         accPassword accountPassword:String,
                         accEmail accountEmail:String,
                         accFirstName accountFirstName:String,
                         accLastName accountLastName:String,
                         accDetails accountDetails:String){
        
        id = i
        username = accountUsername
        password = accountPassword
        email = accountEmail
        firstName = accountFirstName
        lastName = accountLastName
        details = accountDetails
    }

}
