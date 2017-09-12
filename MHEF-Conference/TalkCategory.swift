//
//  TalkCategory.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 6/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

enum TalkCategory: String{
    case WORKSHOP, KEYNOTE, DIALOGUE, PRE_CONFERENCE, LAW_AND_ETHICS, GREAT_DEBATES, CLINICAL_DEMONSTRATION, CLINICAL_DISCUSSANT, TOPICAL, CONVERSATION_HOUR, SPEECH, SPEECH_DISCUSSANT, MASTER_CLASS, DEFAULT;
    
    static let AllValues = ["Workshop", "Keynote", "Dialogue", "Pre-Conference", "Law & Ethics", "Great Debates", "Clinical Demonstration", "Clinical Discussant", "Topical Panel", "Conversation Hour", "Speech", "Speech With Discussant", "Master Class", "Choose A Category to Filter"];
}
