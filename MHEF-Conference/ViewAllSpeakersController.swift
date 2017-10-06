//
//  ViewAllSpeakersController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ViewAllSpeakersController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var speakerViewTable: UITableView!
    var speakers = [Speaker]()
    var currentConference: Conference!
    
    var selectedSpeaker: Speaker!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        speakerViewTable.delegate = self
        speakerViewTable.dataSource = self
        speakerViewTable.rowHeight = 95.0
        
        speakers = currentConference.getAllSpeakers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSpecificSpeaker"{
            let vc = segue.destination as! ViewSpeakerController
            vc.currentConference = currentConference
            vc.currentSpeaker = selectedSpeaker
        }
    }
    @IBAction func unwindToSpeakerList(segue: UIStoryboardSegue){}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections: ViewAllSpeakersController")
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = speakerViewTable.dequeueReusableCell(withIdentifier: "SpeakerCell", for: indexPath) as! SpeakerViewCell
        
        let speaker = speakers[indexPath.row]
        cell.txtSpeakerName.text = speaker.getFullName()
        if speaker.getFullName() == "TBA"{
            cell.imgSpeakerImg.image = UIImage(named: "placeholder-img")
        }else{
            cell.imgSpeakerImg.image = UIImage(named: speaker.getShortName().ToPicString())
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSpeaker = speakers[indexPath.row]

        performSegue(withIdentifier: "showSpecificSpeaker", sender: self)
    }
}
