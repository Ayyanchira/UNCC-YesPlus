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
    
    var acceptedInvites:[String] = []
    var rejectedInvites:[String] = []
    var tentativeInvites:[String] = []
    
    let rootref = Database.database().reference()
    public var eventDetail:Event?
    
    let uid = UserDefaults.standard.value(forKey: "uuid") as? String
    var userStatusUpdated:userAttendance?
    var userStatus:userAttendance{
        //user status updated status will take over the button higlighting and dishighlighting. This will reduce unnecessary fetch calls from firebase. It will be locally handled. The event details with its attendees will be fetched only in Events view controller.
        if userStatusUpdated != nil{
            return userStatusUpdated!
        }else{
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        loadAttendees()
    }

    
    func loadAttendees() {
        acceptedInvites = []
        rejectedInvites = []
        tentativeInvites = []
        let userReference = rootref.child("iOSUsers")
        userReference.observe(DataEventType.value) { (snapShot) in
            if let usersArray = snapShot.value as? NSDictionary{
                for key in usersArray.allKeys{
                    if let acceptedMembers = self.eventDetail?.acceptedInvites{
                        for acceptedMember in acceptedMembers{
                            if acceptedMember == key as! String{
                                let user = usersArray[key] as? [String:Any]
                                let firstname = user!["firstName"] as! String
                                let lastname = user!["lastName"] as! String
                                
                                self.acceptedInvites.append("\(firstname) \(lastname)")
                            }
                        }
                    }
                    
                    if let rejectedMembers = self.eventDetail?.rejectedInvites{
                        for rejectedMember in rejectedMembers{
                            if rejectedMember == key as! String{
                                let user = usersArray[key] as? [String:Any]
                                let firstname = user!["firstName"] as! String
                                let lastname = user!["lastName"] as! String
                                
                                self.rejectedInvites.append("\(firstname) \(lastname)")
                            }
                        }
                    }
                    
                    if let tentativeMembers = self.eventDetail?.tentativeInvites{
                        for tentativeMember in tentativeMembers{
                            if tentativeMember == key as! String{
                                let user = usersArray[key] as? [String:Any]
                                let firstname = user!["firstName"] as! String
                                let lastname = user!["lastName"] as! String
                                
                                self.tentativeInvites.append("\(firstname) \(lastname)")
                            }
                        }
                        self.tableView.reloadData()
                    }
                    
                }
            }
            
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //if not admin just 1
        
        //if admin return 4
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 3
        }else if section == 1{
            if acceptedInvites.count == 0 {
                return 1
            }
            return acceptedInvites.count
        }else if section == 2{
            if rejectedInvites.count == 0{
                return 1
            }
            return rejectedInvites.count
        }else{
            if tentativeInvites.count == 0{
                return 1
            }
            return tentativeInvites.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        if indexPath.section == 0{
            
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
                    eventActionCell.acceptButton.isEnabled = true
                    eventActionCell.rejectButton.isEnabled = true
                    eventActionCell.tentativeButton.isEnabled = true
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
        }else if indexPath.section == 1{
            if (acceptedInvites.count == 0){
                cell.textLabel?.text = "No records found"
            }else{
                cell.textLabel?.text = acceptedInvites[indexPath.row]
            }
            
        }else if indexPath.section == 2{
            if (rejectedInvites.count == 0){
                cell.textLabel?.text = "No records found"
            }else{
                cell.textLabel?.text = rejectedInvites[indexPath.row]
            }
            
        }else if indexPath.section == 3{
            if (tentativeInvites.count == 0){
                cell.textLabel?.text = "No records found"
            }else{
                cell.textLabel?.text = tentativeInvites[indexPath.row]
            }
            
        }
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.168627451, blue: 0.1921568627, alpha: 0)
        
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section > 0{
            return tableView.rowHeight
        }
        if indexPath.row == 1 {
            return 142
        }else{
            return tableView.rowHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Accepted"
            
        case 2:
            return "Rejected"
            
        case 3:
            return "Tentative"
        default:
            return nil
        }
    }
    
    //PRAGMA MARK:- Action button IBAction functions
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        let acceptedListReference = self.rootref.child("allEvents").child((eventDetail?.eventKey)!).child("accepted")
        if userStatus == .NotResponded{
            sendInviteResponseTo(listReference: acceptedListReference, with: "accept")
        }else{
            removeInviteReponseFrom(listReference: acceptedListReference.child(uid!), with: "accept")
        }
        
    }
    
    @IBAction func tentativeButtonPressed(_ sender: UIButton) {
        let tentativeListReference = self.rootref.child("allEvents").child((eventDetail?.eventKey)!).child("tentative")
        if userStatus == .NotResponded{
            sendInviteResponseTo(listReference: tentativeListReference, with: "tentative")
        }else{
            removeInviteReponseFrom(listReference: tentativeListReference.child(uid!), with: "tentative")
        }
        
    }
    
    @IBAction func declineButtonPressed(_ sender: UIButton) {
        let rejectedListReference = self.rootref.child("allEvents").child((eventDetail?.eventKey)!).child("rejected")
        if userStatus == .NotResponded{
            sendInviteResponseTo(listReference: rejectedListReference, with: "reject")
        }else{
            removeInviteReponseFrom(listReference: rejectedListReference.child(uid!), with: "reject")
        }
        
    }
    
    
    //PRAGMA MARK:-
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
                
                //TODO: Fetch the new data and update the table. Include table reloading in that function
//                self.tableView.reloadData()
                DispatchQueue.main.async {
                    self.fetchUpdatedEventDetail()
                }
            }else{
                print(error?.localizedDescription ?? "Error occured while marking the attendance")
            }
            
        }
    }
    
    
    func removeInviteReponseFrom(listReference:DatabaseReference, with context:String){
        listReference.removeValue { (error, dbref) in
            if error == nil{
                self.userStatusUpdated = .NotResponded
                //TODO: Fetch the new data and update the table
//                self.tableView.reloadData()
                DispatchQueue.main.async {
                    self.fetchUpdatedEventDetail()
                }
            }else{
                print(error?.localizedDescription ?? "Error while updating the firebase values")
            }
        }
    }
    
    func fetchUpdatedEventDetail() {
        let dataReference = self.rootref.child("allEvents").child((eventDetail?.eventKey)!)
        dataReference.observeSingleEvent(of: .value) { (dataSnapshot, message) in
            if message == nil{
                if let eventObject = dataSnapshot.value as? [String:Any]{
                    //let eventObject = values[key] as? [String:Any]
                    let eventKey = eventObject["eId"] as! String
                    let eventTitle = eventObject["eTitle"] as! String
                    let fromDate = eventObject["eDate"] as! String
                    let fromTime = eventObject["eStartTime"] as! String
                    let toDate = eventObject["eDate"] as! String
                    let toTime = eventObject["eEndTime"] as! String
                    let location = eventObject["eLocation"] as? String ?? "Not provided"
                    let university = eventObject["eUniversity"] as! String
                    let eventDescription = eventObject["eDescription"] as! String
                    let acceptedInvites = eventObject["accepted"] as? [String:String]
                    let rejectedInvites = eventObject["rejected"] as? [String:String]
                    let tentativeInvites = eventObject["tentative"] as? [String:String]
                    
                    let event = Event(eventKey: eventKey, title: eventTitle, eventDescription: eventDescription, fromDate: fromDate, fromTime: fromTime, toDate: toDate, toTime: toTime, location: location, university: university)
                    var acceptedKeys = [String]()
                    if(acceptedInvites != nil){
                        for value in (acceptedInvites?.values)!{
                            acceptedKeys.append(value)
                        }
                    }
                    var rejectedKeys = [String]()
                    if(rejectedInvites != nil){
                        for value in (rejectedInvites?.values)!{
                            rejectedKeys.append(value)
                        }
                    }
                    var tentativeKeys = [String]()
                    if(tentativeInvites != nil){
                        for value in (tentativeInvites?.values)!{
                            tentativeKeys.append(value)
                        }
                    }
                    event.acceptedInvites = acceptedKeys
                    event.rejectedInvites = rejectedKeys
                    event.tentativeInvites = tentativeKeys
                    self.eventDetail = event
                    
                    self.loadAttendees()
                    self.tableView.reloadData()
                    self.tableView.scrollToNearestSelectedRow(at: .bottom, animated: true)
                }
            }else{
                print("Some error occurred in refreshing the table...")
            }
        }
    }

}
