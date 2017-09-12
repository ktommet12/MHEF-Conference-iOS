//
//  ImageButton.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 8/29/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ImageButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = self.imageView {
            imageView.frame.origin.x = (self.bounds.size.width - imageView.frame.size.width) / 2.0
            imageView.frame.origin.y = 0.0
        }
        if let titleLabel = self.titleLabel {
            titleLabel.frame.origin.x = (self.bounds.size.width - titleLabel.frame.size.width) / 2.0
            titleLabel.frame.origin.y = self.bounds.size.height - titleLabel.frame.size.height - 7.0
        }
    }
}
