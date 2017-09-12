//
//  Speaker.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 6/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

class Speaker{
    private var _fullName: String, _shortName: String, _bio: String
    private let _speakerID: Int
    
    init(shortName: String, fullName: String, bio: String){
        self._fullName = fullName
        self._shortName = shortName
        self._bio = bio
        self._speakerID = Int(arc4random_uniform(1000))
    }
    init(){
        self._fullName = ""
        self._shortName = ""
        self._bio = ""
        self._speakerID = -1
    }
    
    func getFullName()->String{
        return self._fullName;
    }
    func getShortName()->String{
        return self._shortName
    }
    func getSpeakerId()->Int{
        return self._speakerID
    }
    func getSpeakerBio()->String{
        return self._bio
    }
}
