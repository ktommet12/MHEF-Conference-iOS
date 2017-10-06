//
//  ScheduleDayController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/16/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ScheduleDayController: UIViewController, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate, TabSwitcherDelegate, FavoritesDelegate {
    
    @IBOutlet weak var tableDayTalks: UITableView!
    var talkDayString: String!
    
    var selectedTalk: ConferenceTalk!
    
    var currentConference: Conference!
    
    var isFavoritesSelected: Bool = false
    
    
    //potential way to not have to copy currentConference for each Talk Day
    var currentDayTalks: [ConferenceTalk]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableDayTalks.delegate = self
        tableDayTalks.dataSource = self
        tableDayTalks.estimatedRowHeight = 250.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDayTalks.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Add functionality for when a talk row is selected
        
        selectedTalk = currentDayTalks[indexPath.row]
        
        
        performSegue(withIdentifier: "showSpecificTalk", sender: self)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableDayTalks.dequeueReusableCell(withIdentifier: "talk_cell", for: indexPath) as! ConferenceTalkTableCell
        
        let currentTalk: ConferenceTalk = currentDayTalks[indexPath.row]
        
        cell.delegate = self
        
        cell.txtTalkTitle.text = currentTalk.getTitle()
        cell.txtTimeSlot.text = currentTalk.getTimeSlot()
        cell.txtTalkRoom.text = currentTalk.getTalkRoom().fullRoomString
        
        cell.talk = currentTalk
        
        cell.checkFavorite()
        
        var speakers = currentTalk.getAllSpeakers()
        
        cell.txtSpeakerName.text = speakers[0].getFullName()
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSpecificTalk"{
            let vc = segue.destination as! ViewTalkController
            vc.talk = selectedTalk
            vc.currentConference = currentConference
        }
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo{
        return IndicatorInfo(title: talkDayString)
    }
    func didSwitchTab() {
        print("did Switch Tab" + talkDayString)
    }
    func toggleFavorite(talk: ConferenceTalk) {
        currentConference.toggleFavorite(title: talk.getTitle(), date: talk.getTalkDay())
        self.currentDayTalks = self.currentConference.getAllTalks(forDay: self.talkDayString, isFavorites: self.isFavoritesSelected)
        DispatchQueue.main.async {
            if self.isFavoritesSelected{
                
                self.tableDayTalks.reloadData()
            }
        }
    }

}
