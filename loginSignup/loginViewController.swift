//
//  LoginViewController.swift
//  loginSignup
//
//  Created by apple on 10/24/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import UIKit
import SlideMenuControllerSwift

class LoginViewController: UIViewController {
    
    var fetchData = DataSave()
//    var lo
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userimg: UIImageView!
    
    var activeTextField: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardObservers()
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        userimg.layer.cornerRadius = userimg.frame.size.width/2
        userimg.clipsToBounds = true
    
        let borderlogin = CALayer()
        let widthlogin = CGFloat(2.0)
        borderlogin.borderColor = UIColor.darkGray.cgColor
        borderlogin.frame = CGRect(x: 0, y: userEmail.frame.size.height - widthlogin, width: userEmail.frame.size.width, height: userEmail.frame.size.height)
        borderlogin.borderWidth = widthlogin
        userEmail.layer.addSublayer(borderlogin)
        userEmail.layer.masksToBounds = true
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: userPassword.frame.size.height - width, width: userPassword.frame.size.width, height: userPassword.frame.size.height)
        border.borderWidth = width
        userPassword.layer.addSublayer(border)
        userPassword.layer.masksToBounds = true
        
        SetLeftSIDEImage(TextField: userEmail, ImageName: "email-1")
        SetLeftSIDEImage(TextField: userPassword, ImageName: "pw")
        
        
    }

    func SetLeftSIDEImage(TextField: UITextField, ImageName: String){
        let leftImageView = UIImageView()
        let leftView = UIView()
        leftView.frame = CGRect(x: 5, y: 0, width: 50, height: 30)
        leftImageView.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
        TextField.leftViewMode = .always
        TextField.leftView = leftView
        
        let image = UIImage(named: ImageName)
        leftImageView.image = image
        leftView.addSubview(leftImageView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.frame.origin.y = -1 * keyboardHeight!
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.frame.origin.y = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func resignTextFieldFirstResponders() {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
    }
    
    func resignAllFirstResponders() {
        view.endEditing(true)
    }
   
    

    @IBAction func signUpUser(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    
    @IBAction func userLogin(_ sender: Any) {
        let email = userEmail.text
        let password = userPassword.text
        
        let userDetail = fetchData.getData()
        for loadedPerson in userDetail{
            if( email == loadedPerson.emailSignUp) && (password == loadedPerson.passwordSignUp){
                print("login")
                
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
//                UserDefaults.standard.synchronize()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController

                let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                
                leftViewController.mainViewController = nvc

                let slideMenuController =  SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
                
                slideMenuController.delegate = mainViewController
                
                self.view.window?.rootViewController = slideMenuController
                self.view.window?.makeKeyAndVisible()

                
//                let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                let navController = UINavigationController(rootViewController: VC1)
////              self.present(navController, animated:true, completion: nil)
//                self.view.window!.rootViewController = navController
                break
            }
            
            else{
                let alert = UIAlertController(title: "Alert", message: "Please fill the details", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                    }}))
        
                self.present(alert, animated: true, completion: nil)
                print("wrongDetail")
            
            }
            
        }
    }
}

