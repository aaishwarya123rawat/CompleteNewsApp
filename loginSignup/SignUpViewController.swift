//
//  ViewController.swift
//  loginSignup
//
//  Created by apple on 10/18/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailSignUp: UITextField!
    @IBOutlet weak var passwordSignUp: UITextField!
    @IBOutlet weak var confirmPasswordSignUp: UITextField!
    @IBOutlet weak var nameSignUp: UITextField!
    @IBOutlet weak var ageSignUp: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true
        setLeftSIDEImage(TextField: emailSignUp, ImageName: "email-1")
        setLeftSIDEImage(TextField: passwordSignUp, ImageName: "pw")
        setLeftSIDEImage(TextField: nameSignUp, ImageName: "us")
        setLeftSIDEImage(TextField: confirmPasswordSignUp, ImageName: "confirmPassword")
        
        
        let borderemail = CALayer()
        let widthemail = CGFloat(2.0)
        borderemail.borderColor = UIColor.darkGray.cgColor
       borderemail.frame = CGRect(x: 0, y: emailSignUp.frame.size.height - widthemail, width: emailSignUp.frame.size.width, height: emailSignUp.frame.size.height)
        borderemail.borderWidth = widthemail
        emailSignUp.layer.addSublayer(borderemail)
        emailSignUp.layer.masksToBounds = true
        
        let borderPassword = CALayer()
        let widthPassword = CGFloat(2.0)
        borderPassword.borderColor = UIColor.darkGray.cgColor
        borderPassword.frame = CGRect(x: 0, y: passwordSignUp.frame.size.height - widthPassword , width: passwordSignUp.frame.size.width, height: passwordSignUp.frame.size.height)
        borderPassword.borderWidth = widthPassword
        passwordSignUp.layer.addSublayer(borderPassword)
        passwordSignUp.layer.masksToBounds = true
        
        let borderConfirmPassword = CALayer()
        let widthConfirmPassword = CGFloat(2.0)
        borderConfirmPassword.borderColor = UIColor.darkGray.cgColor
       borderConfirmPassword.frame = CGRect(x: 0, y: confirmPasswordSignUp.frame.size.height - widthConfirmPassword, width: confirmPasswordSignUp.frame.size.width, height: confirmPasswordSignUp.frame.size.height)
        borderConfirmPassword.borderWidth = widthConfirmPassword
        confirmPasswordSignUp.layer.addSublayer(borderConfirmPassword)
        confirmPasswordSignUp.layer.masksToBounds = true
        
        let borderName = CALayer()
        let widthlName = CGFloat(2.0)
         borderName.borderColor = UIColor.darkGray.cgColor
         borderName.frame = CGRect(x: 0, y: nameSignUp.frame.size.height - widthlName, width: nameSignUp.frame.size.width, height: nameSignUp.frame.size.height)
         borderName.borderWidth = widthlName
        nameSignUp.layer.addSublayer( borderName)
        nameSignUp.layer.masksToBounds = true

    }
    
    
    
    @IBAction func backToMainViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func setLeftSIDEImage(TextField: UITextField, ImageName: String){
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
    

    
    @IBAction func signUp(_ sender: UIButton) {
        if nameSignUp.text != ""
            && emailSignUp.text != ""
            && (passwordSignUp.text?.count)! > 6
            && (confirmPasswordSignUp.text?.count)! > 6
            && passwordSignUp.text == confirmPasswordSignUp.text
//            && ageSignUp.text != ""
            {
            let username = nameSignUp.text!
            let email = emailSignUp.text!
            let password = passwordSignUp.text!
                _ = confirmPasswordSignUp.text!

                DataSave().saveData(user: User(emailSignUp: email, passwordSignUp: password, nameSignUp: username, selectedSource: nil ))
                let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let navController = UINavigationController(rootViewController: VC1)
                self.present(navController, animated:true, completion: nil)
                UserDefaults.standard.set(false, forKey: "isLoggedIn")

        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Please fill right details", preferredStyle: UIAlertController.Style.alert)
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
        }
        
    }
}
    


