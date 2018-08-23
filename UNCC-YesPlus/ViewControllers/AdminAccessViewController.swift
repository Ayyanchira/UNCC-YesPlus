//
//  AdminAccessViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 8/22/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase

class AdminAccessViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var passcodeTextField: UsernameTextField!
    let rootref = Database.database().reference()
    var passwordOnCloud:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passcodeTextField.delegate = self
        fetchAdminPasscode()
    }

    @IBAction func cancelButtonPressed(_ sender: LoginAndSignUpButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: LoginAndSignUpButton) {
        //TODO: Check firebase entry for passcode and match it with entered text field.
        //If they are same, update the Userdefaults parameter and go back
        //Once it goes back, viewwill appear should refresh the switch
        if let password = passwordOnCloud{
            if password == passcodeTextField.text{
                UserDefaults.standard.set(true, forKey: "AdminAccess")
                self.dismiss(animated: true, completion: nil)
            }else{
                print("Wrong Password entered")
                displayAlertWith(string: "Wrong Passcode")
            }
        }else{
            print("Failed to fetch passcode from server")
            displayAlertWith(string: "Please check internet connection")
        }
        
    }
    
    func fetchAdminPasscode() {
        let passCodeReference = rootref.child("AdminPasscode")
        passCodeReference.observe(.value) { (dataSnapshot) in
            if let passcode = dataSnapshot.value as? String{
                print("passcode is \(passcode)")
                self.passwordOnCloud = passcode
            }
        }
        
    }
    
    //Show alert with custom message and Ok button
    func displayAlertWith(string :String)  {
        let alertVC = UIAlertController(title: "Error", message:string , preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
}
