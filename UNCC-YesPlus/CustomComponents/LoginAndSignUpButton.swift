//
//  LoginAndSignUpButton.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/2/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class LoginAndSignUpButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor(displayP3Red: 151, green: 151, blue: 151, alpha: 100).cgColor
        self.layer.borderWidth = 2
    }
}
