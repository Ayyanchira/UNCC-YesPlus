//
//  EventCustomCellTableViewCell.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/2/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class EventCustomCellTableViewCell: UITableViewCell {

    @IBOutlet weak var eventDescription: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        eventDescription.textContainer.lineBreakMode = .byTruncatingTail
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
