//
//  ViewTalkController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/16/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ViewTalkController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblSpeakerNames: UITableView!
    @IBOutlet weak var txtTalkDescription: UILabel!
    @IBOutlet weak var txtTimeSLot: UILabel!
    @IBOutlet weak var txtTalkTitle: UILabel!
    
    //specific talk that was selected from the schedule view
    var talk: ConferenceTalk!
    var currentConference: Conference!
    
    var speakers: [Speaker]!
    
    var selectedSpeaker: Speaker! //speaker they select from the list at the bottom of View Talk Screen, this will
    //be used to determine which speaker to send to View Speaker Screen

    override func viewDidLoad() {
        super.viewDidLoad()
        
        speakers = talk.getAllSpeakers()
        
        txtTalkTitle.text = talk.getTitle()
        txtTimeSLot.text = talk.getTimeSlot()
        txtTalkDescription.text = talk.getDescription()
        
        tblSpeakerNames.delegate = self
        tblSpeakerNames.dataSource = self
        tblSpeakerNames.estimatedRowHeight = 50.0
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpecificTalktoSpeakerView"{
            let vc = segue.destination as! ViewSpeakerController
            vc.currentSpeaker = selectedSpeaker
            vc.currentConference = currentConference
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSpeaker = speakers[indexPath.row]
        
        performSegue(withIdentifier: "SpecificTalktoSpeakerView", sender: self)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSpeakerNames.dequeueReusableCell(withIdentifier: "speaker_cell") as! TalkSpeakerTableCell
        
        let currentSpeaker = speakers[indexPath.row]
        
        cell.txtSpeakerName.text = currentSpeaker.getFullName()
        cell.imgSpeakerImg.image = UIImage(named: currentSpeaker.getShortName().ToPicString())
        
        return cell
    }
    @IBAction func goToMap(_ sender: Any) {
    }

    @IBAction func AddTalkToFavorites(_ sender: Any) {
    }
}
