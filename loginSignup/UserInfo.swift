//
//  userInfo.swift
//  loginSignup
//
//  Created by apple on 10/24/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let emailSignUp:String?
    let passwordSignUp:String?
    let nameSignUp:String?
    var selectedSource:[String]?
    
    
//    let isLoggedIn:Bool
//    let ageSignUp:String
}
