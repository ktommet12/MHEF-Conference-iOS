//
//  AboutController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AboutController: UIViewController {
    
    @IBOutlet weak var txtAboutText: UITextView!
    
    var currentConference: Conference!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        txtAboutText.text = currentConference.infoAboutErickson()
        
        
        
        
    }

}
