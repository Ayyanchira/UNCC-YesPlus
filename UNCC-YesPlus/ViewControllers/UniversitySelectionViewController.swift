//
//  UniversitySelectionViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 6/1/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class UniversitySelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var universityPickerView: UIPickerView!
    
    var listOfUniversity = ["UNC Charlotte", "MIT", "USC","UNC Chappel hill" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        universityPickerView.delegate = self
        universityPickerView.dataSource = self
    }
    
    //PRAGMA MARK: Picker view delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfUniversity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfUniversity[row]
    }
    
    
}
