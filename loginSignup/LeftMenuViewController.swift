//
//  SlideMenuViewController.swift
//  loginSignup
//
//  Created by apple on 11/27/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case home = 0
    case prefrence
    case resetPassword
    case logout
 
}

protocol LeftMenuProtocol : class {
    func selectMenuItems(_ menu: LeftMenu)
}


class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet var bgImg: UIImageView!
    @IBOutlet var newsIconImg: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    var mainViewController: UIViewController!
    var logingViewController: UIViewController!
    var homeViewController: UIViewController!
    
    
    var menus = ["Home","Prefrence","ResetPassword", "Logout" ]
    var images = ["home","preference", "changpassword", "logout" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        self.tableView.tableFooterView = UIView()
        newsIconImg.layer.cornerRadius = newsIconImg.frame.size.width/2

    }

    
    func selectMenuItems(_ menu: LeftMenu) {
        switch menu {
        case .home:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.homeViewController = storyboard.instantiateViewController(withIdentifier: "DetailNewsViewController") as! DetailNewsViewController
            self.homeViewController = UINavigationController(rootViewController: homeViewController)
            self.slideMenuController()?.changeMainViewController(self.homeViewController, close: true)
            
        case .prefrence:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.mainViewController = UINavigationController(rootViewController: mainViewController)
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
            
        case .resetPassword: break

        case .logout:
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = loginVC  
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row){
            self.selectMenuItems(menu)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
            let cell = tableView.dequeueReusableCell(withIdentifier: "leftMenuCell") as! LeftViewControllerCell
                   cell.leftControllerLable.text = menus[indexPath.row]
                   cell.leftControllerImg.image = UIImage(named: images[indexPath.row])
            
                    return cell
        }
        
    

}
