//
//  Thread.swift
//  iOS-Final-Project
//
//  Created by Xcode User on 2019-04-15.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

//Thread Object
//Author: Laurence Chong
class Thread: NSObject {
    var topic:String?
    var subject:String?
    var body:String?
    var date:String?
    var poster:String?
    
    func initWithData(topic t:String, subject s:String, body b:String, date d:String, poster p:String){
        topic = t
        subject = s
        body = b
        date = d
        poster = p
    }
}
