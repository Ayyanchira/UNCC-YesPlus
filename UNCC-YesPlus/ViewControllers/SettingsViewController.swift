//
//  SettingsViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 6/1/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingsTableView: UITableView!
    let options = ["Push Notification","Admin Access", "Logout"]
    
    func setupRemoteConfigDefaults() {
        RemoteConfig.remoteConfig().setDefaults(fromPlist: "Info")
    }
    
    func fetchRemoteConfig() {
        // FIXME: Dont put this code in production
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0, completionHandler: { [unowned self] (status, error) in
            guard error == nil else{
                print("Some error in fetching remote configuration")
                return
            }
            print("Great....")
            RemoteConfig.remoteConfig().activateFetched()
            self.displayAdminCode()
        })
    }
    
    func updateAdminCodeFromCloud() {
        let adminPasscode = RemoteConfig.remoteConfig().configValue(forKey: "AdminCode").stringValue ?? "JaiGurudev"
        if let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist"){
            var pListValues = NSMutableDictionary(contentsOfFile: plistPath)
            pListValues?.setValue(adminPasscode, forKey: "AdminCode")
//            pListValues?.setObject(adminPasscode, forKey: "AdminCode" as NSCopying)
            pListValues?.write(toFile: plistPath, atomically: true)
        }
       print("passcode obtained from server is \(adminPasscode)")
    }
    
    func displayAdminCode() {
        if let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist"){
            var pListValues = NSDictionary(contentsOfFile: plistPath)
            let adminCode = pListValues!["AdminCode"] as! String
            print("Admin code is \(adminCode)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRemoteConfigDefaults()
        displayAdminCode()
        fetchRemoteConfig()
        updateAdminCodeFromCloud()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: .settingRefresh, object: nil)
//        displayAdminCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupRemoteConfigDefaults()
    }
    
    //PRAGMA MARK: Table View delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingsTableViewCell
        switch indexPath.row {
        case 0:
            cell.settingMenuLabel.text = "Push Notification"
            
        case 1:
            cell.settingMenuLabel.text = "Admin Access"
            
        case 2:
            cell.settingMenuLabel.text = "Logout"
            cell.settingMenuLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.settingSwitch.isHidden = true
            cell.selectionStyle = .default
        default:
            print("Table view error. Please check settings table view code...")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Notification setting tapped")
        case 1:
            //load admin loading passcode view
            print("Provide admin access")
        case 2:
            UserDefaults.standard.removeObject(forKey: "uuid")
            do {
                try Auth.auth().signOut()
            } catch let signoutError as NSError {
                print(signoutError.localizedDescription)
            }
            self.dismiss(animated: true, completion: nil)
        default:
            print("default case executed")
        }
    }
    
    @objc func refreshTableView() {
        settingsTableView.reloadData()
    }
}
