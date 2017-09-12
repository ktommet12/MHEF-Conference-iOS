//
//  TalkSpeakerTableCell.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class TalkSpeakerTableCell: UITableViewCell {

    @IBOutlet weak var imgSpeakerImg: UIImageView!
    @IBOutlet weak var txtSpeakerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
