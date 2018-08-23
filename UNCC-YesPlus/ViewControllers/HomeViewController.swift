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
    @IBOutlet var addButton: UIBarButtonItem!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddButton()
        //Loading title image
        let yesplusImageView = UIImageView(image: #imageLiteral(resourceName: "YesPlusImage"), highlightedImage: #imageLiteral(resourceName: "YesPlusImage"))
        yesplusImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = yesplusImageView
        
        //Setting Events as selected by default
        tabNavigation.selectedItem = tabNavigation.items?.first
    }

    fileprivate func setupAddButton() {
        if appDelegate.isAdmin{
            addButton.isEnabled = true
        }else{
            addButton.isEnabled = false
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        eventsView.isHidden = true
        quotesView.isHidden = true
        settingsView.isHidden = true
        if(item.title == "Quotes"){
            quotesView.isHidden = false
            self.navigationItem.rightBarButtonItem = addButton
            NotificationCenter.default.post(name: .quoteRefresh, object: nil)
            setupAddButton()
        }
        if item.title == "Events" {
            eventsView.isHidden = false
            self.navigationItem.rightBarButtonItem = addButton
            NotificationCenter.default.post(name: .eventRefresh, object: nil)
            setupAddButton()
        }
        if item.title == "Settings" {
            settingsView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            NotificationCenter.default.post(name: .settingRefresh, object: nil)
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
    static let eventRefresh = Notification.Name("EventRefresh")
    static let quoteRefresh = Notification.Name("QuoteRefresh")
    static let settingRefresh = Notification.Name("SettingRefresh")
}
