//
//  ConferenceController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 6/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ConferenceController: UIViewController {
    
    //Views that are acting like buttons
    @IBOutlet weak var scheduleViewBtn: UIView!
    @IBOutlet weak var syllabusBtn: UIView!
    @IBOutlet weak var favoritesViewBtn: UIView!
    @IBOutlet weak var speakersViewBtn: UIView!
    @IBOutlet weak var mapsViewBtn: UIView!
    @IBOutlet weak var twitterViewBtn: UIView!
    @IBOutlet weak var parkingInfoViewBtn: UIView!
    @IBOutlet weak var aboutViewBtn: UIView!
    @IBOutlet weak var registerViewBtn: UIView!
    
    var currentConference: Conference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppUtility.lockOrientation(.portrait)
        
        //creating Gesture Recognizers for Each View "Button" so that it goes to it associated Page when clicked
        let tapOnScheduleButton = UITapGestureRecognizer(target: self, action: #selector(self.goToSchedule))
        self.scheduleViewBtn.addGestureRecognizer(tapOnScheduleButton)
        
        let tapRegisterButton = UITapGestureRecognizer(target: self, action: #selector(self.goToBuyTickets))
        self.registerViewBtn.addGestureRecognizer(tapRegisterButton)
        
        let tapFavoritesBtn = UITapGestureRecognizer(target: self, action: #selector(self.goToFavorites))
        self.favoritesViewBtn.addGestureRecognizer(tapFavoritesBtn)
        
        let tapViewSpeakersBtn = UITapGestureRecognizer(target: self, action: #selector(self.goToViewAllSpeakers))
        self.speakersViewBtn.addGestureRecognizer(tapViewSpeakersBtn)
        
        let tapParkingBtn = UITapGestureRecognizer(target: self, action: #selector(self.goToParkingInfo))
        self.parkingInfoViewBtn.addGestureRecognizer(tapParkingBtn)
        
        let tapSyllabusBtn = UITapGestureRecognizer(target: self, action: #selector(self.goToSyllabus))
        self.syllabusBtn.addGestureRecognizer(tapSyllabusBtn)
        
        let tapAboutBtn = UITapGestureRecognizer(target: self, action: #selector(self.goToAbout))
        self.aboutViewBtn.addGestureRecognizer(tapAboutBtn)
        
        let tapTwitterBtn = UITapGestureRecognizer(target: self, action: #selector(self.goToTwitter))
        self.twitterViewBtn.addGestureRecognizer(tapTwitterBtn)
        
        let tapMapsBtn = UITapGestureRecognizer(target: self, action: #selector(self.goToMaps))
        self.mapsViewBtn.addGestureRecognizer(tapMapsBtn)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "btnViewAllSpeakersSegue"{
            let vc = segue.destination as! ViewAllSpeakersController
            vc.currentConference = currentConference
        }
        else if segue.identifier == "showBuyTicketsSegue"{
            let vc = segue.destination as! WebViewController
            vc.urlString = AppConfig.EVO_BUY_TICKETS_URL
            vc.isPDF = false
        }
        else if segue.identifier == "showConferenceSchedule"{
            let vc = segue.destination as! ScheduleController
            vc.isScheduleSelected = true
            vc.currentConference = currentConference
        }
        else if segue.identifier == "goToSyllabus"{
            let vc = segue.destination as! WebViewController
            vc.urlString = currentConference.getSyllabusUrl()
            vc.isPDF = true
        }
        else if segue.identifier == "goToFavorites"{
            let vc = segue.destination as! ScheduleController
            vc.isFavoritesSelected = true
            vc.currentConference = currentConference
        }
        else if segue.identifier == "goToAbout"{
            let vc = segue.destination as! AboutController
            vc.currentConference = currentConference
        }
        else if segue.identifier == "goToMapsList"{
            let vc = segue.destination as! MapListTableViewController
            vc.mapItems = currentConference.getRoomKeys()
        }
    }
    @IBAction func unwindToLandingSegue(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? ScheduleController{
            currentConference = sourceViewController.currentConference
        }
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    func goToSyllabus(){
        performSegue(withIdentifier: "goToSyllabus", sender: self)
    }
    func goToFavorites(){
        performSegue(withIdentifier: "goToFavorites", sender: self)
    }
    func goToParkingInfo(){
        performSegue(withIdentifier: "goToParking", sender: self)
    }
    func goToViewAllSpeakers(){
        performSegue(withIdentifier: "btnViewAllSpeakersSegue", sender: self)
    }
    func goToSchedule(){
        performSegue(withIdentifier: "showConferenceSchedule", sender: self)
    }
    func goToAbout(){
        performSegue(withIdentifier: "goToAbout", sender: self)
    }
    func goToBuyTickets(){
        performSegue(withIdentifier: "showBuyTicketsSegue", sender: self)
    }
    func goToMainWebsite(){
        performSegue(withIdentifier: "goToMainWebsite", sender: self)
    }
    func goToTwitter(){
        performSegue(withIdentifier: "goToTwitter", sender: self)
    }
    func goToMaps(){
        performSegue(withIdentifier: "goToMapsList", sender: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        //AppUtility.lockOrientation(.portrait)
    }
}
