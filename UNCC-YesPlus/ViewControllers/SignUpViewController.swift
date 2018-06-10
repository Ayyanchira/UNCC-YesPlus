//
//  SignUpViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/20/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let yesplusImageView = UIImageView(image: #imageLiteral(resourceName: "YesPlusImage"), highlightedImage: #imageLiteral(resourceName: "YesPlusImage"))
        yesplusImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = yesplusImageView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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