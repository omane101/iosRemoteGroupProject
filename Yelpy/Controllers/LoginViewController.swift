//
//  LoginViewController.swift
//  Yelpy
//
//  Created by Ahmed Moussa on 11/25/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

   
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bordersShadow()
        let usernameImage = UIImage(named: "mail")
        addLeftImageTo(TetxField: username, andImage: usernameImage!)
        let passwordImage = UIImage(named: "password")
        addLeftImageTo(TetxField: password, andImage: passwordImage!)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        
    }
    
    
    // Text fields effects
    
    func bordersShadow () {
        //Basic texfield Setup
           username.borderStyle = .none
           password.borderStyle = .none
           username.backgroundColor = UIColor.white
           password.backgroundColor = UIColor.white
       
        // Use anycolor that give you a 2d look.

           //To apply corner radius
           username.layer.cornerRadius = username.frame.size.height / 5
          password.layer.cornerRadius = password.frame.size.height
/ 5
        
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 5
          
           //To apply border
           username.layer.borderWidth = 0.75
           username.layer.borderColor = UIColor.gray.cgColor
           password.layer.borderWidth = 0.75
           password.layer.borderColor = UIColor.gray.cgColor
           loginButton.layer.borderWidth = 0.75
           //loginButton.layer.borderColor = UIColor.white.cgColor
        
           //To apply Shadow
           username.layer.shadowOpacity = 1
           username.layer.shadowRadius = 5.0
           username.layer.shadowOffset = CGSize.zero // Use any CGSize
           username.layer.shadowColor = UIColor.gray.cgColor
        
        
        password.layer.shadowOpacity = 1
        password.layer.shadowRadius = 5.0
        password.layer.shadowOffset = CGSize.zero // Use any CGSize
        password.layer.shadowColor = UIColor.gray.cgColor
        
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowRadius = 5.0
        loginButton.layer.shadowOffset = CGSize.zero // Use any CGSize
        loginButton.layer.shadowColor = UIColor.black.cgColor

        //To apply padding
            let userpadding : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: username.frame.height))
            username.leftView = userpadding
            username.leftViewMode = UITextField.ViewMode.always
        
        let passpadding : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: password.frame.height))
        password.leftView = passpadding
        password.leftViewMode = UITextField.ViewMode.always
        
        

    }
    
    // add icon for email and password fields
    
    func addLeftImageTo(TetxField: UITextField, andImage img: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.width))
        leftImageView.image = img
        TetxField.leftView = leftImageView
        
        
    }

    func errorHandling() {
        let alert = UIAlertController(title: "Invalid Login", message: "Incorrect username or password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    func success() {
        /*
        let alert = UIAlertController(title: "Thank You", message: "User successfull logged in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        */
    }
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    
    @IBAction func onLoginPress(_ sender: Any) {
        let _username = username.text!
        let _password = password.text!
        if (_username == "" || _password == "") {
            errorHandling()
        } else {
            Auth.auth().signIn(withEmail: username.text!, password: password.text!) { [self](result, error) in
                if let error = error {
                    print("Error:\(error.localizedDescription)")
                    self.errorHandling()
                } else {
                    print("User Logged in Successfully")
                    self.username.text = ""
                    self.password.text = ""
                    self.success()
                    
                  //  self.performSegue(withIdentifier: "Login", sender: self)
                    
                }
            }
        }
        
    }
    
}
