//
//  LoginViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/6/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UsernameTextField!
    @IBOutlet weak var passwordTextField: UsernameTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if user is logged in
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            performSegue(withIdentifier: "loginSuccessfull", sender: nil)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: LoginAndSignUpButton) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (authResult, error) in
                if error != nil{
                    let alertController = UIAlertController(title: "Log in failed", message: "Please enter valid email id and password. Or click on Create New Account to get started", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.show(alertController, sender: nil)
                }
                else{
                    let uuid = authResult?.user.uid
                    UserDefaults.standard.set(uuid, forKey: "uuid")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginSuccessfull", sender: nil)
                    }
                }
            })
        }
    }
    
}
