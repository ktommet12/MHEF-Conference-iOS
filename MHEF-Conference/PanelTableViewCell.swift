//
//  PanelTableViewCell.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class PanelTableViewCell: UITableViewCell {

    @IBOutlet weak var txtPanelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
