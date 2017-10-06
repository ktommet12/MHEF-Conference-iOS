//
//  ConferenceTalk.swift
//  MHEF-Conference
//
//  Created by admin on 5/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

class ConferenceTalk{
    private var _title: String,_shortTitle: String, _timeSlot: String, _description: String, _day: String;
    private var _shortNameString: String, _fullNameString: String
    private var _speakers: [Speaker]
    private var _talkCategory: TalkCategory
    private var _isTalkFavorited: Bool
    private var _id: Int;
    private var _room: ConferenceRoom
    
    init(title: String,shortTitle: String, time: String, room: ConferenceRoom, description: String, speakers: [Speaker], day: String, talkCat: TalkCategory){
        self._title = title;
        self._shortTitle = shortTitle;
        self._description = description;
        self._day = day;
        self._timeSlot = time;
        self._speakers = speakers;
        self._talkCategory = talkCat
        self._room = room
        self._fullNameString = "";
        self._shortNameString = "";
        self._isTalkFavorited = false;
        self._id = Int(arc4random_uniform(1000));     //assigns the talk a random num that will uniquely identify it throughout the life of the app
    }
    func getTitle()->String{
        return self._title;
    }
    func getShortTitle()->String{
        return self._shortTitle;
    }
    func getTimeSlot()->String{
        return self._timeSlot;
    }
    func getTalkId()->Int{
        return self._id;
    }
    func getTalkRoom()->ConferenceRoom{
        return self._room;
    }
    func getTalkDay()->String{
        return self._day
    }
    func getTalkCategory()->TalkCategory{
        return self._talkCategory
    }
    func getDescription()->String{
        return self._description
    }
    func setFullNameString(_ str: String){
        _fullNameString = str;
    }
    func setShortNameString(_ str: String){
        _shortNameString = str;
    }
    func getSpeakerByName(name: String)->Speaker{
        for speaker in _speakers{
            if speaker.getFullName() == name{
                return speaker;
            }
        }
        return Speaker()
    }
    func getSpeakerById(id: Int)->Speaker{
        for speaker in _speakers{
            if speaker.getSpeakerId() == id{
                return speaker;
            }
        }
        return Speaker()
    }
    func getAllSpeakers()->[Speaker]{
        return self._speakers
    }
    func toggleFavorite(){
        self._isTalkFavorited = !self._isTalkFavorited
        print("talk name: \(self._title) was \(self._isTalkFavorited ? "favorited" : "unfavorited")")
    }
    func isTalkFavorited()->Bool{
        return self._isTalkFavorited
    }
    func getNumSpeakers()->Int{
        return self._speakers.count
    }
}
