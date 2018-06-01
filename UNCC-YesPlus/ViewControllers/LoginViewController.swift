//
//  LoginViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/6/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    
    @IBOutlet weak var emailTextField: UsernameTextField!
    @IBOutlet weak var passwordTextField: UsernameTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: LoginAndSignUpButton) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if error != nil{
                    let alertController = UIAlertController(title: "Log in failed", message: "Please enter valid email id and password. Or click on Create New Account to get started", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.show(alertController, sender: nil)
                }
                else{
                    let uuid = user?.uid
                    UserDefaults.standard.set(uuid, forKey: "uuid")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginSuccessfull", sender: nil)
                    }
                }
            })
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
