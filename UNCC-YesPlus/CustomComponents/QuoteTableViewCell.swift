//
//  QuoteTableViewCell.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 7/8/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
