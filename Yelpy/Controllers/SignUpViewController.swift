//
//  SignUpViewController.swift
//  Yelpy
//
//  Created by Ahmed Moussa on 11/26/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import Firebase





class SignUpViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bordersShadow()
        // add the left Image in the username field
        let usernameImage = UIImage(named: "mail")
        addLeftImageTo(TetxField: username, andImage: usernameImage!)
        
        // add the left Image in the password field
        let passwordImage = UIImage(named: "password")
        addLeftImageTo(TetxField: password, andImage: passwordImage!)    }
    
    
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
        
        signupButton.layer.cornerRadius = signupButton.frame.size.height / 5
          
           //To apply border
           username.layer.borderWidth = 0.75
           username.layer.borderColor = UIColor.gray.cgColor
           password.layer.borderWidth = 0.75
           password.layer.borderColor = UIColor.gray.cgColor
           signupButton.layer.borderWidth = 0.75
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
        
        signupButton.layer.shadowOpacity = 1
        signupButton.layer.shadowRadius = 5.0
        signupButton.layer.shadowOffset = CGSize.zero // Use any CGSize
        signupButton.layer.shadowColor = UIColor.black.cgColor

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
        let alert = UIAlertController(title: "Invalid Information", message: "Incorrect username or password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onSignupPress(_ sender: Any) {
        
        let _username = username.text!
        let _password = password.text!
        if (_username == "" || _password == "") {
            errorHandling()
        } else {
            Auth.auth().createUser(withEmail: _username, password: _password) {(result, error) in
                if let error =  error {
                    print("Failed to sig up", error.localizedDescription)
                    return
                }
                    print("User register successufully")
                
                    
                
            }
        }
        
    }
    
   
 
}

