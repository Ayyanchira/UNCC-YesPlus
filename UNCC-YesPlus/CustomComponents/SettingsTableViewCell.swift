//
//  SettingsTableViewCell.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/9/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var settingMenuLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
