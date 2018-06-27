//
//  NewEventViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 6/25/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {

    @IBOutlet var fromToButtons: [UIButton]!
    
    @IBOutlet weak var saveButton: LoginAndSignUpButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.width/2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectDateButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 || sender.tag == 2{
            showDatePickerFor(button: sender)
            //From date button selected
            //show the date picker and let the user select the date. Replace the button title with date and let the date be reselectable.
        }else if sender.tag == 3 || sender.tag == 4{
            //To date button selected
        }
    }
    
    func showDatePickerFor(button:UIButton) {
        //show date picker and replace the button title with date selected
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
        //birthdatePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        
        //Adding confimation button
        let okButton = UIButton(frame: CGRect(x: (birthdateSelectorView.frame.width/2)-50, y: birthdateSelectorView.frame.height-35, width: 100, height: 20))
        okButton.setTitle("OK", for: .normal)
        //okButton.addTarget(self, action: #selector(self.okButtonClicked(sender:)), for: .touchUpInside)
        birthdateSelectorView.addSubview(okButton)
        
        
        birthdateSelectorView.addSubview(birthdatePicker)
        birthdateSelectorView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        birthdateSelectorView.layer.borderWidth = 2.5
        self.view.addSubview(birthdateSelectorView)
        
        DispatchQueue.main.async {
            //self.birthDateTextField.resignFirstResponder()
        }
        
    }
    
    func showTimePickerFor(button:UIButton) {
        //show time picker and replace button title with time selected
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        //Perform basic validation and then save to firebase
    }
    
}
