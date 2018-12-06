//
//  UserSingleton.swift
//  loginSignup
//
//  Created by apple on 12/4/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

class UserData {
    
    static let shared = UserData()
    var userInformation:User?
    private init(){}

    func userInfo() -> User?  {
        let userEmail =  UserDefaults.standard.string(forKey: "loggedUserEmail")
        for personInfo in DataSave().getData(){
            if (personInfo.emailSignUp == userEmail){
                userInformation = personInfo
                return personInfo
            }
        
        }
        return nil
    }
    
    
    
    
    
    
    
}











//class LocationManager{
//
//    static let shared = LocationManager()
//
//    var locationGranted: Bool?
//    //Initializer access level change now
//    private init(){}
//
//    func requestForLocation(){
//        //Code Process
//        locationGranted = true
//        print("Location granted")
//    }
//
//}
////Access class function in a single line
//LocationManager.shared.requestForLocation()
