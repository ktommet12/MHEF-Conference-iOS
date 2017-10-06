//
//  ConferenceRoom.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 9/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct ConferenceRoom{
    let room: String, subRoom: String, fullRoomString: String
    init(r: String, sr: String){
        room = r
        subRoom = sr
        fullRoomString = room + " - " + subRoom
    }
}
