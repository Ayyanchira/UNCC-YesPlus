//
//  EventDetailTableViewController.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/22/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Firebase

class EventDetailTableViewController: UITableViewController {

    enum userAttendance{
        case NotResponded
        case Accepted
        case Rejected
        case Tentative
    }
    let rootref = Database.database().reference()
    public var eventDetail:Event?
    
    let uid = UserDefaults.standard.value(forKey: "uuid") as? String
    var userStatusUpdated:userAttendance = userAttendance.NotResponded
    var userStatus:userAttendance{
        if userStatusUpdated != .NotResponded{
            return userStatusUpdated
        }
        var userFound = userAttendance.NotResponded
        if (eventDetail?.acceptedInvites != nil){
            for userKey in (eventDetail?.acceptedInvites)! {
                if (userKey == uid){
                    userFound = userAttendance.Accepted
                }
            }
        }
        if (eventDetail?.rejectedInvites != nil){
            for userKey in (eventDetail?.rejectedInvites)! {
                if (userKey == uid){
                    userFound = userAttendance.Rejected
                }
            }
        }
        if (eventDetail?.tentativeInvites != nil){
            for userKey in (eventDetail?.tentativeInvites)! {
                if (userKey == uid){
                    userFound = userAttendance.Tentative
                }
            }
        }
        return userFound
    }
    
    @IBOutlet weak var acceptButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        if indexPath.row == 0{
            let eventDescriptioncell:EventDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "eventDescription", for: indexPath) as! EventDetailTableViewCell
            eventDescriptioncell.titleLabel.text = eventDetail?.title
            eventDescriptioncell.eventDescription.text = eventDetail?.eventDescription
            eventDescriptioncell.eventDateLabel.text = (eventDetail?.fromDate)! + " to " + (eventDetail?.toDate)!
            eventDescriptioncell.eventTimeLabel.text = (eventDetail?.fromTime)! + " to " + (eventDetail?.toTime)!
            eventDescriptioncell.locationLabel.text = eventDetail?.location
            eventDescriptioncell.isUserInteractionEnabled = false
            return eventDescriptioncell
        }else if indexPath.row == 1{
            let eventActionCell:EventActionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "eventActions", for: indexPath) as! EventActionsTableViewCell
            switch userStatus{
                case .Accepted:
                    eventActionCell.acceptButton.isSelected = true
                    //disabling other buttons
                    eventActionCell.rejectButton.isEnabled = false
                    eventActionCell.tentativeButton.isEnabled = false
                case .Rejected:
                    eventActionCell.rejectButton.isSelected = true
                    //disabling other buttons
                    eventActionCell.acceptButton.isEnabled = false
                    eventActionCell.tentativeButton.isEnabled = false
                case .Tentative:
                    eventActionCell.tentativeButton.isSelected = true
                    //disabling other buttons
                    eventActionCell.rejectButton.isEnabled = false
                    eventActionCell.acceptButton.isEnabled = false
                case .NotResponded:
                    print("No cell selected")
            }
            return eventActionCell
            
        }else if (indexPath.row == 2){
            switch userStatus{
            case .NotResponded:
                cell.textLabel?.text = "Please respond to the event"
            case .Accepted:
                cell.textLabel?.text = "Hooray! You have accepted the invite"
            case .Rejected:
                cell.textLabel?.text = "Oh! It seems are busy"
            case .Tentative:
                cell.textLabel?.text = "Marked as Tentative"
            }
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            return cell
        }
        

        // Configure the cell...

        return cell
    }
 
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        let acceptedListReference = self.rootref.child("allEvents").child((eventDetail?.eventKey)!).child("accepted")
        sendInviteResponseTo(listReference: acceptedListReference, with: "accept")
    }
    
    @IBAction func tentativeButtonPressed(_ sender: UIButton) {
        let rejectedListReference = self.rootref.child("allEvents").child((eventDetail?.eventKey)!).child("tentative")
        sendInviteResponseTo(listReference: rejectedListReference, with: "tentative")
    }
    
    @IBAction func declineButtonPressed(_ sender: UIButton) {
        let tentativeListReference = self.rootref.child("allEvents").child((eventDetail?.eventKey)!).child("rejected")
        sendInviteResponseTo(listReference: tentativeListReference, with: "reject")
    }
    
    func sendInviteResponseTo(listReference:DatabaseReference,with context:String) {
        let uidReference = listReference.child(uid!)
        uidReference.setValue(uid) { (error, dbref) in
            if error == nil{
                if context == "accept"{
                    self.userStatusUpdated = .Accepted
                }else if context == "reject"{
                    self.userStatusUpdated = .Rejected
                }else if context == "tentative"{
                    self.userStatusUpdated = .Tentative
                }
                self.tableView.reloadData()
            }else{
                print(error?.localizedDescription ?? "Error occured while marking the attendance")
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 142
        }else{
            return tableView.rowHeight
        }
    }

}
