//
//  HomeViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 3/16/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    @IBOutlet weak var eventsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let yesplusImageView = UIImageView(image: #imageLiteral(resourceName: "YesPlusImage"), highlightedImage: #imageLiteral(resourceName: "YesPlusImage"))
        yesplusImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = yesplusImageView
    }

    // MARK : Table view implementation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //PRAGMA MARK: Table view delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customHomeCell") as! CustomHomeTableViewCell
        cell.thumbnail.image = #imageLiteral(resourceName: "Event")
        return cell
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
        if(item.title == "Quotes"){
            eventsView.isHidden = true
        }
        if item.title == "Events" {
            eventsView.isHidden = false
        }
        if item.title == "Settings" {
            eventsView.isHidden = true
        }
    }
}
