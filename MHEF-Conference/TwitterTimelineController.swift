//
//  TwitterTimelineController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/10/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterTimelineController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient();
        self.dataSource = TWTRUserTimelineDataSource(screenName: "ericksonFound", apiClient: TWTRAPIClient())
        
        
        
        
        
        //self.dataSource = TWTRListTimelineDataSource(listSlug: "surfing", listOwnerScreenName: "ericksonfound", apiClient: client)

    
    }

}
