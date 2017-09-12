//
//  RoundButton.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet{
            self.layer.cornerRadius = cornerRadius
            self.titleLabel?.textAlignment = NSTextAlignment.center
        }
    }

}
