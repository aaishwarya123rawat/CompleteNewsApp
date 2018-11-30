//
//  DataSve.swift
//  loginSignup
//
//  Created by apple on 10/24/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

class DataSave {
    
    func saveData(user: User) {
        let users = [user]
        let encoder = JSONEncoder()
        var userlist = getData()
        userlist.append(contentsOf: users)
        if let encoded = try? encoder.encode(userlist) {
            UserDefaults.standard.set(encoded, forKey: "savedUsers")
//            UserDefaults.standard.set(true, forKey: "isLoggedin")
            print("encoded:\(encoded)")
            print("users:\(userlist)")
            
        }
    }
    
     func getData() -> [User]  {
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "savedUsers") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode([User].self, from: savedPerson) {
                return loadedPerson
            }
        }
        return [User]()
    }
}
