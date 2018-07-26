//
//  EventActionsTableViewCell.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/22/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class EventActionsTableViewCell: UITableViewCell {

    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var tentativeButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
