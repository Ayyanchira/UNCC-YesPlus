//
//  ManualRegisterViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/6/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ManualRegisterViewController: UIViewController {
    @IBOutlet weak var firstnameTextField: UsernameTextField!
    @IBOutlet weak var lastNameTextField: UsernameTextField!
    @IBOutlet weak var birthDateTextField: UsernameTextField!
    @IBOutlet weak var emailTextField: UsernameTextField!
    @IBOutlet weak var confirmPasswordTextField: UsernameTextField!
    @IBOutlet weak var passwordTextField: UsernameTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: LoginAndSignUpButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func registerButtonPressed(_ sender: Any) {
        let validationResult = validateTextFields()
        if (validationResult.keys.first)!{
            print("Lets register him")
            //Register a new user in firebase
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if (error != nil){
                    self.displayAlertWith(string: "Error in registering user")
                    print(error?.localizedDescription ?? "No description found")
                }else{
                    self.displayAlertWith(string: "User Registration Successful")
                    print("user created with username \(user.debugDescription)")
                    //store uuid in userdefaults
                    UserDefaults.standard.set(user?.uid, forKey: "uuid")
                    let rootreference = Database.database().reference()
                    let userReference = rootreference.child("iOSUsers").child(user!.uid)
                    let user = [
                        "firstName":self.firstnameTextField.text!,
                        "lastName":self.lastNameTextField.text!,
                        "email":self.emailTextField.text ?? "No Email",
                        "id": user?.uid ?? "No UID",
                        "isPushEnabled" : true,
                        "deviceID" : 123123,
                        "birthDate" : self.birthDateTextField.text
                        ] as [String : Any]
                    userReference.setValue(user)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }else{
            displayAlertWith(string: validationResult.values.first!)
        }
    }
    
    //Show alert with custom message and Ok button
    func displayAlertWith(string :String)  {
        let alertVC = UIAlertController(title: "Error", message:string , preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    //Validation of all the text fields
    func validateTextFields() -> [Bool:String] {
        if (firstnameTextField.text == "") || (lastNameTextField.text == "") || (birthDateTextField.text == "") || (passwordTextField.text == "") || (confirmPasswordTextField.text == ""){
            return [false : "Please fill alll the fields"]
        }
        if passwordTextField.text != confirmPasswordTextField.text{
            return [false : "Passwords do not match"]
        }
        return [true : "Successfull"]
    }
}
