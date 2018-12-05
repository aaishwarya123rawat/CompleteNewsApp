//
//  DataSve.swift
//  loginSignup
//
//  Created by apple on 10/24/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

class DataSave {
    
    func saveData(user: User)   {
        let users = [user]
        var userlist = getData()
        let encoder = JSONEncoder()
        for oldUser in userlist{
            if (user.emailSignUp == oldUser.emailSignUp){
                
                
                
                
                let encoded = try? encoder.encode(users)
                UserDefaults.standard.set(encoded, forKey: "savedUsers");
                userlist.remove(at: 2)
                UserDefaults.standard.synchronize()
                break
            }
            else{
                _ = userlist.append(contentsOf: users)
                if let encoded = try? encoder.encode(userlist) {
                    UserDefaults.standard.set(encoded, forKey: "savedUsers")
                    print("encoded:\(encoded)")
                    print("users:\(userlist)")
                }
            }
        }
    }
    
    
    func saveSourceForSelectedUser(userSource: [String] ) {
      var usr = UserData.shared.userInformation
        usr?.selectedSource = userSource
        saveData(user: (usr!))
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
