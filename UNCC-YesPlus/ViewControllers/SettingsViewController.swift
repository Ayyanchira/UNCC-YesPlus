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
        //setupRemoteConfigDefaults()
        self.settingsTableView.reloadData()
    }
    
    
    func isAdmin() -> Bool {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        if appdelegate.isAdmin == true{
            return true
        }else{
            return false
        }
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
            cell.settingSwitch.tag = 0
            
        case 1:
            cell.settingMenuLabel.text = "Admin Access"
            cell.settingSwitch.tag = 1
            cell.settingSwitch.setOn(isAdmin(), animated: true)
        
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
    
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        if sender.tag == 0{
           //Switch for push notification
        }else if sender.tag == 1{
            print("Admin switch toggled")
            if sender.isOn{
                //TODO: Check everything here. And set false if passcode fails
                askForAdminPassword()
                //sender.setOn(false, animated: true)
            }else{
                //remove admin access
                UserDefaults.standard.set(false, forKey: "AdminAccess")
            }
        }
    }
    
    
    func askForAdminPassword(){
//        createPasscodeUI()
        //TODO: Present passcode entry view controller
        self.performSegue(withIdentifier: "enterPasscode", sender: nil)
    }
    
    //TODO: Remove below code which was supposed to show a pop up with custom passcode text field. Instead we are going to present a view for passcode entry
    func createPasscodeUI(){
        let passCodeView = UIView(frame: CGRect(x: self.view.frame.width/2 - 100, y: self.view.frame.height/2 - 150, width: 200, height: 300))
        passCodeView.backgroundColor = #colorLiteral(red: 0.1643057168, green: 0.167824924, blue: 0.2028948665, alpha: 0.9470527251)
        passCodeView.layer.cornerRadius = 15
        passCodeView.tag = 200
        passCodeView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passCodeView.layer.borderWidth = 2.5
        self.view.addSubview(passCodeView)
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
                UserDefaults.standard.set(false, forKey: "AdminAccess")
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
