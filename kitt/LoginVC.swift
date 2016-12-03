//
//  LoginVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

@IBDesignable
class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: AnimatedButton!

    @IBAction func loginButtonAction(_ sender: UIButton) {
        
        if username.text != nil && username.text != "" && password.text != nil && password.text != "" {
            
            Model.instance.login(username: username.text, password: password.text, success: { 
                self.performSegue(withIdentifier: "toCarSelection", sender: sender)
            }, failure: { (error) in
                self.showAlert(title: "Error", message: error.localizedDescription())
            })
            
        } else {
            showAlert(title: "Error", message: "Please fill in your name and password")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == username {
            password.becomeFirstResponder()
        } else if textField == password {
            loginButtonAction(loginButton)
        }
        
        return true
    }

    func configureUI() {
        loginButton.layer.cornerRadius = 5.0
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.borderWidth = 1.0
        loginButton.clipsToBounds = true
        
        
        username.attributedPlaceholder = NSAttributedString(string:"Username", attributes:[NSForegroundColorAttributeName: Colors.lightWhite])
        password.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSForegroundColorAttributeName: Colors.lightWhite])
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureUI()
    }
    
}
