//
//  FileLoader.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/13/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FileLoader{
    init(){}
    static func loadJsonFile()->JSON{
        let path = Bundle.main.path(forResource: "speakerBios", ofType: "json")
        
        let content = NSData(contentsOfFile: path! )
        
        let speakers = JSON(content)
        
        
        return speakers
    }
//    static func loadPDF()->Data{
//       return nil
//    }
}
