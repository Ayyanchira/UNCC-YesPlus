//
//  UsernameTextField.swift
//  UNCC-YesPlus
//
//  Created by Akshay Ayyanchira on 5/2/18.
//  Copyright © 2018 Akshay Ayyanchira. All rights reserved.
//

import UIKit

@IBDesignable
class UsernameTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor(displayP3Red: 151, green: 151, blue: 151, alpha: 100).cgColor
        self.layer.borderWidth = 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 12)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds:bounds)
    }
}

