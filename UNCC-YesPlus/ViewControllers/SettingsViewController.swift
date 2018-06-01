//
//  SettingsViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 6/1/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var settingsTableView: UITableView!
    
    let options = ["Push Notification", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //PRAGMA MARK: Table View delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
}
