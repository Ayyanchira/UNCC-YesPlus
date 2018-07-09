//
//  Quote.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/9/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import Foundation

class Quote: NSObject {
    var quote:String
    var author:String
    
    init(quote:String, author:String) {
        self.quote = quote
        self.author = author
    }
}
