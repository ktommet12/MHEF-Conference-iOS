//
//  SpeakerViewCell.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class SpeakerViewCell: UITableViewCell {

    @IBOutlet weak var txtSpeakerName: UILabel!
    @IBOutlet weak var imgSpeakerImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
