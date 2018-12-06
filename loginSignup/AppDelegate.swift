//
//  AppDelegate.swift
//  loginSignup
//
//  Created by apple on 10/18/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    fileprivate func createMenuView() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
          appDelegate?.window?.rootViewController = navController
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "DetailNewsViewController") as! DetailNewsViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController

        let nvc: UINavigationController = UINavigationController(rootViewController: homeViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(red: 104/250.0, green: 159/250.0, blue: 56/250.0, alpha: 1.0)
        leftViewController.homeViewController = nvc
        
        let slideController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
//        slideController.automaticallyAdjustsScrollViewInsets = true
        slideController.delegate = homeViewController as? SlideMenuControllerDelegate
        self.window?.rootViewController = slideController
        self.window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
   
        let logedInState = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (logedInState == true) {
            let loggedUser = UserData.shared.userInfo()
            self.createMenuView()
            print("personInfo:\(String(describing: loggedUser))")
        }  
        else{
            let loginController =  storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
            appDelegate?.window?.rootViewController = loginController
        }
   
    
        return true
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

