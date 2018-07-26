//
//  NewEventViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 6/25/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase

class NewEventViewController: UIViewController {

    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet var fromToButtons: [UIButton]!
    @IBOutlet weak var locationTextField: UITextField!
    let rootref = Database.database().reference()
    var currentButtonSelected:UIButton?
    
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
            showTimePickerFor(button: sender)
        }
    }
    
    func showDatePickerFor(button:UIButton) {
        
        //setting the button globally for other functionality to get access to
        currentButtonSelected = button
        
        //show date picker and replace the button title with date selected
        let eventDateSelectorView = UIView(frame: CGRect(x: self.view.frame.width/10, y: self.view.frame.height/3, width: (self.view.frame.width/10) * 8, height: 200))
        eventDateSelectorView.backgroundColor = #colorLiteral(red: 0.1643057168, green: 0.167824924, blue: 0.2028948665, alpha: 0.9470527251)
        eventDateSelectorView.layer.cornerRadius = 15
        eventDateSelectorView.tag = 200
        
        //Border between Button and picker
        let borderSeperator = UIView(frame: CGRect(x: 0, y: eventDateSelectorView.frame.height-50, width: eventDateSelectorView.frame.width, height: 1))
        borderSeperator.layer.borderWidth = 2.5
        borderSeperator.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        eventDateSelectorView.addSubview(borderSeperator)
        
        //Event Date Picker
        let eventDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: eventDateSelectorView.frame.width, height: eventDateSelectorView.frame.height-50))
        eventDatePicker.setValue(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), forKeyPath: "textColor")
        eventDatePicker.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        button.setTitle(dateFormatter.string(from: eventDatePicker.date), for: .normal)
        eventDatePicker.addTarget(self, action: #selector(datePickerDidChangeValue(sender:)), for: .valueChanged)
        //birthdatePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        
        //Adding confimation button
        let okButton = UIButton(frame: CGRect(x: (eventDateSelectorView.frame.width/2)-50, y: eventDateSelectorView.frame.height-35, width: 100, height: 20))
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(self.okButtonClicked(sender:)), for: .touchUpInside)
        eventDateSelectorView.addSubview(okButton)
        
        eventDateSelectorView.addSubview(eventDatePicker)
        eventDateSelectorView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        eventDateSelectorView.layer.borderWidth = 2.5
        self.view.addSubview(eventDateSelectorView)
    }
    
    func showTimePickerFor(button:UIButton) {
        //show time picker and replace button title with time selected
        
        //setting the button globally for other functionality to get access to
        currentButtonSelected = button
        
        //show date picker and replace the button title with date selected
        let eventDateSelectorView = UIView(frame: CGRect(x: self.view.frame.width/10, y: self.view.frame.height/3, width: (self.view.frame.width/10) * 8, height: 200))
        eventDateSelectorView.backgroundColor = #colorLiteral(red: 0.1643057168, green: 0.167824924, blue: 0.2028948665, alpha: 0.9470527251)
        eventDateSelectorView.layer.cornerRadius = 15
        eventDateSelectorView.tag = 200
        
        //Border between Button and picker
        let borderSeperator = UIView(frame: CGRect(x: 0, y: eventDateSelectorView.frame.height-50, width: eventDateSelectorView.frame.width, height: 1))
        borderSeperator.layer.borderWidth = 2.5
        borderSeperator.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        eventDateSelectorView.addSubview(borderSeperator)
        
        //Event Date Picker
        let eventTimePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: eventDateSelectorView.frame.width, height: eventDateSelectorView.frame.height-50))
        eventTimePicker.setValue(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), forKeyPath: "textColor")
        eventTimePicker.datePickerMode = .time
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        button.setTitle(dateFormatter.string(from: eventTimePicker.date), for: .normal)
        eventTimePicker.addTarget(self, action: #selector(timePickerDidChangeValue(sender:)), for: .valueChanged)
        
        
        //Adding confimation button
        let okButton = UIButton(frame: CGRect(x: (eventDateSelectorView.frame.width/2)-50, y: eventDateSelectorView.frame.height-35, width: 100, height: 20))
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(self.okButtonClicked(sender:)), for: .touchUpInside)
        eventDateSelectorView.addSubview(okButton)
        
        eventDateSelectorView.addSubview(eventTimePicker)
        eventDateSelectorView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        eventDateSelectorView.layer.borderWidth = 2.5
        self.view.addSubview(eventDateSelectorView)
    }
    
    @objc func okButtonClicked(sender: UIButton) {
        let subviewCollection = self.view.subviews
        for subview in subviewCollection{
            if subview.tag == 200{
                subview.removeFromSuperview()
            }
        }
    }
    
    @objc func datePickerDidChangeValue(sender:UIDatePicker) {
        let date = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        currentButtonSelected?.setTitle(dateFormatter.string(from: date), for: .normal)
    }
    
    @objc func timePickerDidChangeValue(sender:UIDatePicker) {
        let time = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        currentButtonSelected?.setTitle(dateFormatter.string(from: time), for: .normal)
    }
    
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        //Perform basic validation and then save to firebase
        var fromDate = ""
        var toDate:String = ""
        var fromTime:String = ""
        var toTime:String = ""
        for button in fromToButtons{
            switch button.tag{
            case 1:
                fromDate = (button.titleLabel?.text)!
                
            case 2:
                toDate = (button.titleLabel?.text)!
                
            case 3:
                fromTime = (button.titleLabel?.text)!
                
            case 4:
                toTime = (button.titleLabel?.text)!
                
            default:
                print("something went wrong")
            }
        }
        
        let eventReference = rootref.child("allEvents").childByAutoId()

        let eventObject = [
            "eTitle" : "\(eventTitleTextField.text ?? "Some Title")",
            "eDescription" : eventDescriptionTextView.text,
            "eDate" : fromDate,
            "eToDate" : toDate,
            "eId": eventReference.key,
            "eStartTime" : fromTime,
            "eEndTime" : toTime,
            "eLocation" : locationTextField.text ?? "Location not provided",
            "eUniversity" : "UNC Charlotte"
            ] as [String : Any]

        eventReference.setValue(eventObject) { (error, dbRef) in
            if error == nil{
                self.navigationController?.popViewController(animated: true)
            }else{
                print("Something went wrong while storing to firebase...")
            }
        }
    }
    
}
