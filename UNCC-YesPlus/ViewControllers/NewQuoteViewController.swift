//
//  NewQuoteViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/9/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase

class NewQuoteViewController: UIViewController {

    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorTextField: UITextField!
    let rootref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if validateTextFields(){
            let newQuoteReference = rootref.child("allQuotes").childByAutoId()
            let quoteObject = [
                "quote": quoteTextView.text,
                "author": authorTextField.text ?? "Sri Sri Ravi Shankar",
                "key" : newQuoteReference.key
            ] as [String:Any]
            newQuoteReference.setValue(quoteObject) { (error, dbRef) in
                if error == nil{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            let alertController = UIAlertController(title: "Empty Fields", message: "Please enter quote and author name before saving.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func validateTextFields() -> Bool {
        var validation = false
        if quoteTextView.text != ""  {
            if authorTextField.text != ""{
                validation = true
            }
        }
        return validation
    }
    
}
