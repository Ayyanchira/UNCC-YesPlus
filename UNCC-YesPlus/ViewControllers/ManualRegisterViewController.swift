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

class ManualRegisterViewController: UIViewController, UITextFieldDelegate{
    public var university:String?
    
    @IBOutlet weak var firstnameTextField: UsernameTextField!
    @IBOutlet weak var lastNameTextField: UsernameTextField!
    @IBOutlet weak var birthDateTextField: UsernameTextField!
    @IBOutlet weak var emailTextField: UsernameTextField!
    @IBOutlet weak var confirmPasswordTextField: UsernameTextField!
    @IBOutlet weak var passwordTextField: UsernameTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Selected university is \(university)")
        birthDateTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func registerButtonPressed(_ sender: Any) {
        let validationResult = validateTextFields()
        if (validationResult.keys.first)!{
            print("Lets register him")
            //Register a new user in firebase
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
                if (error != nil){
                    self.displayAlertWith(string: "Error in registering user")
                    print(error?.localizedDescription ?? "No description found")
                }else{
                    self.displayAlertWith(string: "User Registration Successful")
                    print("user created with username \(authResult.debugDescription)")
                    //store uuid in userdefaults
                    UserDefaults.standard.set(authResult?.user.uid, forKey: "uuid")
                    let rootreference = Database.database().reference()
                    let userReference = rootreference.child("iOSUsers").child(authResult!.user.uid)
                    let user = [
                        "firstName":self.firstnameTextField.text!,
                        "lastName":self.lastNameTextField.text!,
                        "email":self.emailTextField.text ?? "No Email",
                        "id": authResult?.user.uid ?? "No UID",
                        "isPushEnabled" : false,
                        "deviceID" : "",
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
            return [false : "Please fill all the fields"]
        }
        if passwordTextField.text != confirmPasswordTextField.text{
            return [false : "Passwords do not match"]
        }
        return [true : "Successfull"]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 199 {
            //show pop up with date picker
            showBirthDatePicker()
        }
    }
    
    func showBirthDatePicker() {
        
        let birthdateSelectorView = UIView(frame: CGRect(x: self.view.frame.width/10, y: self.view.frame.height/3, width: (self.view.frame.width/10) * 8, height: 200))
        birthdateSelectorView.backgroundColor = #colorLiteral(red: 0.1643057168, green: 0.167824924, blue: 0.2028948665, alpha: 0.9470527251)
        birthdateSelectorView.layer.cornerRadius = 15
        birthdateSelectorView.tag = 200
        
        //Border between Button and picker
        let borderSeperator = UIView(frame: CGRect(x: 0, y: birthdateSelectorView.frame.height-50, width: birthdateSelectorView.frame.width, height: 1))
        borderSeperator.layer.borderWidth = 2.5
        borderSeperator.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        birthdateSelectorView.addSubview(borderSeperator)
        
        //Birthday Picker
        let birthdatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: birthdateSelectorView.frame.width, height: birthdateSelectorView.frame.height-50))
        birthdatePicker.setValue(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), forKeyPath: "textColor")
        birthdatePicker.datePickerMode = .date
        birthdatePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        
        //Adding confimation button
        let okButton = UIButton(frame: CGRect(x: (birthdateSelectorView.frame.width/2)-50, y: birthdateSelectorView.frame.height-35, width: 100, height: 20))
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(self.okButtonClicked(sender:)), for: .touchUpInside)
        birthdateSelectorView.addSubview(okButton)
        
        
        birthdateSelectorView.addSubview(birthdatePicker)
        birthdateSelectorView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        birthdateSelectorView.layer.borderWidth = 2.5
        self.view.addSubview(birthdateSelectorView)
        
        DispatchQueue.main.async {
            self.birthDateTextField.resignFirstResponder()
        }
        
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let date = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        self.birthDateTextField.text = dateFormatter.string(from: date)
    }
    
    @objc func okButtonClicked(sender: UIButton!) {
        let subviewCollection = self.view.subviews
        for subview in subviewCollection{
            if subview.tag == 200{
                subview.removeFromSuperview()
            }
        }
        emailTextField.becomeFirstResponder()
    }
}
