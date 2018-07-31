//
//  Event.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/9/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import Foundation

class Event: NSObject {
    var eventKey:String
    var title:String
    var eventDescription:String
    var fromDate:String
    var toDate:String
    var fromTime:String
    var toTime:String
    var location:String
    var university:String
    var acceptedInvites:[String]?
    var rejectedInvites:[String]?
    var tentativeInvites:[String]?
    
    init(eventKey:String, title:String, eventDescription:String, fromDate:String, fromTime:String, toDate:String, toTime:String, location:String, university:String) {
        self.eventKey = eventKey
        self.title = title
        self.eventDescription = eventDescription
        self.fromDate = fromDate
        self.fromTime = fromTime
        self.toDate = toDate
        self.toTime = toTime
        self.location = location
        self.university = university
    }
    
}
