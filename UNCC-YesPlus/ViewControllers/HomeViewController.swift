//
//  HomeViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 3/16/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var quotesView: UIView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var tabNavigation: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading title image
        let yesplusImageView = UIImageView(image: #imageLiteral(resourceName: "YesPlusImage"), highlightedImage: #imageLiteral(resourceName: "YesPlusImage"))
        yesplusImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = yesplusImageView
        
        //Setting Events as selected by default
        tabNavigation.selectedItem = tabNavigation.items?.first
    }

    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "uuid")
        do {
            try Auth.auth().signOut()
        } catch let signoutError as NSError {
            print(signoutError.localizedDescription)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        eventsView.isHidden = true
        quotesView.isHidden = true
        settingsView.isHidden = true
        if(item.title == "Quotes"){
            quotesView.isHidden = false
        }
        if item.title == "Events" {
            eventsView.isHidden = false
        }
        if item.title == "Settings" {
            settingsView.isHidden = false
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Check which page is presented in the home page.
        if !eventsView.isHidden {
            NotificationCenter.default.post(name: .events, object: nil)
        }else if !quotesView.isHidden{
            NotificationCenter.default.post(name: .quotes, object: nil)
        }
    }
}


extension Notification.Name{
    static let events = Notification.Name("Events")
    static let quotes = Notification.Name("Quotes")
}
