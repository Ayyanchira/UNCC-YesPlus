//
//  EventDetailTableViewCell.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/22/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: EventCellView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
