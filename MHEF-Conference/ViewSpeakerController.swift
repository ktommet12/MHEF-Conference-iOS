//
//  ViewSpeakerController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ViewSpeakerController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnGoHome: UIButton!
    @IBOutlet weak var tblSpeakerPanels: UITableView!
    @IBOutlet weak var txtSpeakerBio: UILabel!
    @IBOutlet weak var txtSpeakerName: UILabel!
    @IBOutlet weak var imgSpeakerPic: UIImageView!
    
    var currentSpeaker:Speaker!
    var currentConference: Conference!
    var selectedTalk: ConferenceTalk!
    
    var talksBySpeaker: [ConferenceTalk]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imgSpeakerPic.image = UIImage(named: currentSpeaker.getShortName().ToPicString())
        txtSpeakerName.text = currentSpeaker.getFullName()
        txtSpeakerBio.text = currentSpeaker.getSpeakerBio()
        
        talksBySpeaker = currentConference.getAllTalks(bySpeaker: currentSpeaker)
        
        tblSpeakerPanels.delegate = self
        tblSpeakerPanels.dataSource = self
        
        tblSpeakerPanels.estimatedRowHeight = 50.0
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(selectedTalk)
        if segue.identifier == "speakerViewToSpecificTalk"{
            let vc = segue.destination as! ViewTalkController
            vc.talk = selectedTalk
            vc.currentConference = currentConference
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talksBySpeaker.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //handle when the user selects a panel row, take them to the schedule with the specific talk
        selectedTalk = talksBySpeaker[indexPath.row]
        
        performSegue(withIdentifier: "speakerViewToSpecificTalk", sender: self)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSpeakerPanels.dequeueReusableCell(withIdentifier: "panel_cell") as! PanelTableViewCell
        
        let currentTalk = talksBySpeaker[indexPath.row]
        
        cell.txtPanelTitle.text = currentTalk.getShortTitle()
        
        return cell
    }

    //unwind back to the ViewAllSpeakerController
    @IBAction func goBackToSpeakerList(_ sender: Any) {}

}
