//
//  ManualRegisterViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/6/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class ManualRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: LoginAndSignUpButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
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
