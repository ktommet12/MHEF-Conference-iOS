//
//  ServerErrorController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 8/29/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ServerErrorController: UIViewController, DBWorkerDelegate {
    let dbWorker = DBWorker()
    private var conference: Conference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load the conference
        dbWorker.delegate = self

        
    }
    @IBAction func retryServerDownload(_ sender: Any) {
        self.view.makeToast("Loading Conference Info.......", duration: 20.0,position: .top)
        dbWorker.getConferenceContents()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLandingFromErrorScreen"{
            let vc = segue.destination as! ConferenceController
            vc.currentConference = conference
        }
    }
    func didFinishTask(returnedJSON: [String : Any]?, wasASuccess: Bool) {
        print("Finished Contacting DB")
        
        //sends you to the main conference landing screen only if the database download was a success
        if wasASuccess == true{
            DispatchQueue.main.async {
                self.conference = Conference(jsonContents: returnedJSON!)
                self.performSegue(withIdentifier: "goToLandingFromErrorScreen", sender: nil)
            }
        }
    }
}
