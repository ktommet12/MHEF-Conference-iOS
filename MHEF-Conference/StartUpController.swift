//
//  StartUpController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 6/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Toast_Swift


class StartUpController: UIViewController, DBWorkerDelegate {
    var conference: Conference!

    @IBOutlet weak var lblVersionNum: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        
        lblVersionNum.text = version

        // Do any additional setup after loading the view.
        
        self.view.makeToast("Loading Conference Info.......", duration: 20.0,position: .top)
        
        //load the conference 
        let dBWorker = DBWorker()
        dBWorker.delegate = self
        dBWorker.getConferenceContents()
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLanding"{
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
                self.performSegue(withIdentifier: "goToLanding", sender: nil)
            }
        }
        else{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "goToServerErrorScreen", sender: nil)
            }
        }
    }
}
