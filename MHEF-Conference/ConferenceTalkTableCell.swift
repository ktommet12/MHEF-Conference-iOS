//
//  ConferenceTalkTableCell.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ConferenceTalkTableCell: UITableViewCell {
    @IBOutlet weak var txtTalkRoom: UILabel!

    @IBOutlet weak var txtSpeakerName: UILabel!
    @IBOutlet weak var txtTimeSlot: UILabel!
    @IBOutlet weak var txtTalkTitle: UILabel!
    
    @IBOutlet weak var btnAddToFavorites: UIButton!
    var talk: ConferenceTalk!
    
    var delegate: FavoritesDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func GoToMap(_ sender: Any) {
        print("Go To Map")
    }
    @IBAction func AddTalkToFavorites(_ sender: Any) {
        self.delegate.toggleFavorite(talk: self.talk);
        checkFavorite()
    }
    func checkFavorite(){
        if self.talk.isTalkFavorited(){
            btnAddToFavorites.setTitle("Remove From Favorites", for: .normal)
        }else{
            btnAddToFavorites.setTitle("Add To Favorites", for: .normal)
        }
    }
}
