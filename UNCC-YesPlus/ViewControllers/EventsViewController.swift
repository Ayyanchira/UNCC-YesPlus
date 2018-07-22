//
//  HomePageTableViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/2/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase

class EventsViewController: UITableViewController {

    let rootref = Database.database().reference()
    var events:[Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Enabling notification listeners
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToNewEventView), name: .events, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: .eventRefresh, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        //Fetch Events from firebase
        fetchEvents()
    }
    
    
    
    // MARK: - Firebase Calls
    func fetchEvents() {
        let dataref = self.rootref.child("allEvents")
        dataref.observeSingleEvent(of: DataEventType.value) { (snapshot) in
            print("Number of objects found : \(snapshot.childrenCount)")
            if let values = snapshot.value as? NSDictionary{
                self.events.removeAll()
                for key in values.allKeys{
                    let eventObject = values[key] as? [String:Any]
                    let eventKey = eventObject!["eId"] as! String
                    let eventTitle = eventObject!["eTitle"] as! String
                    let fromDate = eventObject!["eDate"] as! String
                    let fromTime = eventObject!["eStartTime"] as! String
                    let toDate = eventObject!["eDate"] as! String
                    let toTime = eventObject!["eEndTime"] as! String
                    let location = eventObject!["eDescription"] as! String
                    let university = eventObject!["eUniversity"] as! String
                    let eventDescription = eventObject!["eDescription"] as! String
                    let event = Event(eventKey: eventKey, title: eventTitle, eventDescription: eventDescription, fromDate: fromDate, fromTime: fromTime, toDate: toDate, toTime: toTime, location: location, university: university)
                    self.events.append(event)
                }
            }
            self.tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCustomCell", for: indexPath) as! EventCustomCellTableViewCell
        // Configure the cell...
        cell.eventTitle.text = events[indexPath.row].title
        cell.eventDescription.text = events[indexPath.row].eventDescription
        cell.eventDate.text = events[indexPath.row].fromDate
        cell.eventDuration.text = "From \(events[indexPath.row].fromTime) to \(events[indexPath.row].toTime)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "eventDetail", sender: nil)
    }

    //MARK:- Notified events
    @objc func navigateToNewEventView() {
        performSegue(withIdentifier: "NewEvent", sender: nil)
    }
    
    @objc func refreshTableView() {
        fetchEvents()
    }
}


