//
//  Conference.swift
//  MHEF-Conference
//
//  Created by admin on 5/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import SwiftyJSON


class Conference{
    private var _confName: String, _confShortTitle: String, _aboutErickson: String
    private var _dates: [String], _syllabusUrl: String
    private var _confType: ConferenceType
    private var _dayTalks: [String: [ConferenceTalk]]
    private var _allSpeakers = [Speaker]()
    private var _favoritedTalks = [String]()
    
    //private var _roomDataSet: [ConferenceRoom]
    
    private var sharedPrefs = MHEFUserDefaults()
    
    var speakerBios:JSON
    
    init(jsonContents: [String: Any]){
        
        speakerBios = FileLoader.loadJsonFile()
        
        //constructRoomDataSet()
        
        self._confName = (jsonContents["conference_full_name"] as? String)!
        self._aboutErickson = (jsonContents["about-erickson"] as? String)!
        self._confShortTitle = (jsonContents["conference_short_name"] as? String)!
        self._dates = (jsonContents["dates"] as! [String])
        self._syllabusUrl = jsonContents["syllabus-url"] as! String
        
        //TODO: get the favorites String from UserDefaults and Convert to Array
        if let stringFromDefaults = self.sharedPrefs.get(key: AppConfig.USER_DEFAULTS_KEY){
            self._favoritedTalks = stringFromDefaults.components(separatedBy: ",")
        }
        
    
        
        switch(self._confShortTitle){
            case "Evolution":
                self._confType = .EVOLUTION
            case "Brief":
                self._confType = .BRIEF
            case "Couples":
                self._confType = .COUPLES
            default:
                self._confType = .DEFAULT
        }
        let json = JSON(jsonContents)
        
        let days = json["days"]
        
        
        self._dayTalks = [String: [ConferenceTalk]]()
        
        for date in self._dates{
            var tempTalks =  days[date]["talks"]
            
            var dayTalks = [ConferenceTalk]()
            
            
            
            for talk in tempTalks{
                let title = talk.1["title"].string
                let timeSlot = talk.1["time_slot"].string
                let description = talk.1["description"].string
                let shortTitle = talk.1["short_title"].string
                let speakersFullNames = talk.1["speaker_name"].string
                let speakerNamesOnly = talk.1["speaker_name_only"].string
                let talkRoom = talk.1["room"].string
                let talkCategory = self.convertToTalkCategory(talk.1["talk_category"].string!)
                
                let fullNameArr = speakersFullNames?.components(separatedBy: ";")
                let shortNameArr = speakerNamesOnly?.components(separatedBy: ";")
                
                
                var speakers = [Speaker]()
                
                
                if fullNameArr != nil && shortNameArr != nil {
                    for index in 0..<fullNameArr!.count{
                        var test = (shortNameArr?[index].trim().ToPicString())!
                        var speakerBio = speakerBios[test].string
                        var x = 0
                        var newSpeaker: Speaker
                        if speakerBio != nil{
                            newSpeaker = Speaker(shortName: (shortNameArr?[index].trim())!, fullName: (fullNameArr?[index].trim())!, bio: speakerBio!)
                        }
                        else{
                            newSpeaker = Speaker(shortName: (shortNameArr?[index].trim())!, fullName: (fullNameArr?[index].trim())!, bio: "")
                        }
                        //adds the new Speaker to the talk
                        speakers.append(newSpeaker)
                        //adds the speaker to the backend list storing all the speakers for the talk, 
                        //unless they are already on that list
                        self.addSpeakerToList(newSpeaker)
                    }
                }
                
                let tempTalk = ConferenceTalk(title: title!,shortTitle: shortTitle!, time: timeSlot!, room: talkRoom!, description: description!, speakers: speakers, day: date, talkCat: talkCategory)
                
                tempTalk.setFullNameString(speakersFullNames!)
                tempTalk.setShortNameString(speakerNamesOnly!)
                
                dayTalks.append(tempTalk)
            }
            self._dayTalks[date] = dayTalks
        }
        self.setFavoritesFromPrefs()
        
    }
    func getConferenceDates()->[String]{
        return self._dates
    }
    func infoAboutErickson()->String{
        return self._aboutErickson
    }
    func getAllSpeakers()->[Speaker]{
        return self._allSpeakers
    }
    func getSyllabusUrl()->String{
        return self._syllabusUrl;
    }
    func getAllTalks(byFilters filter: [TalkCategory])->[ConferenceTalk]{
        return [ConferenceTalk]()
    }
    func toggleFavorite(title: String, date: String){
        let dayTalks = self._dayTalks[date]
        for talk in dayTalks!{
            if talk.getTitle() == title{
                talk.toggleFavorite()
                if talk.isTalkFavorited(){
                    self._favoritedTalks.append(talk.getTitle())
                }else{
                    if let index = self._favoritedTalks.index(of: talk.getTitle()){
                        self._favoritedTalks.remove(at: index)
                    }
                }
                self.sharedPrefs.add(forKey: AppConfig.USER_DEFAULTS_KEY, data: self._favoritedTalks.joined(separator: ","))

            }
        }
    }
    func getAllTalks(forDay day: String, isFavorites: Bool)->[ConferenceTalk]{
        var dayTalks = [ConferenceTalk]()
        if self._dayTalks[day] != nil{
            if isFavorites{
                for talk in self._dayTalks[day]!{
                    if talk.isTalkFavorited(){
                        dayTalks.append(talk)
                    }
                }
                return dayTalks
            }else{
                return self._dayTalks[day]!
            }
        }
        else{
            return dayTalks
        }
        
    }
    func getAllTalks(bySpeaker speaker: Speaker)->[ConferenceTalk]{
        var talks = [ConferenceTalk]()
        
        for date in self._dates{
            let dayTalks = self._dayTalks[date]
            
            if dayTalks != nil{
                for talk in dayTalks!{
                    let speakers = talk.getAllSpeakers()
                    for tempSpeaker in speakers{
                        if tempSpeaker.getFullName() == speaker.getFullName(){
                            talks.append(talk)
                        }
                    }
                }
            }
        }
        return talks
    }
    private func addSpeakerToList(_ speaker: Speaker){
        var alreadyInList = false
        for tempSpeaker in self._allSpeakers{
            if speaker.getFullName() == tempSpeaker.getFullName(){
                alreadyInList = true;
            }
        }
        if alreadyInList == false{
            self._allSpeakers.append(speaker)
        }
    }
    //converts a string to a TalkCategory, if string is not valid or not a recognized then it will return .default
    func convertToTalkCategory(_ cat: String)->TalkCategory{
        switch(cat.lowercased()){
            case "pc":
                return TalkCategory.PRE_CONFERENCE
            case "le":
                return TalkCategory.LAW_AND_ETHICS
            case "k":
                return TalkCategory.KEYNOTE
            case  "ws":
                return TalkCategory.WORKSHOP
            case "gd":
                return TalkCategory.GREAT_DEBATES
            case "cd":
                return TalkCategory.CLINICAL_DEMONSTRATION
            case "cdd":
                return TalkCategory.CLINICAL_DISCUSSANT
            case "tp":
                return TalkCategory.TOPICAL
            case "ch":
                return TalkCategory.CONVERSATION_HOUR
            case "sp":
                return TalkCategory.SPEECH
            case "spd":
                return TalkCategory.SPEECH_DISCUSSANT
            case "mc":
                return TalkCategory.MASTER_CLASS
            default:
                return TalkCategory.DEFAULT
        }
    }
    private func setFavoritesFromPrefs(){
        let dates = self._dates;
        for favoritedTalkTitle in self._favoritedTalks{
            for day in dates{
                for talk in self._dayTalks[day]!{
                    if talk.getTitle() == favoritedTalkTitle{
                        talk.toggleFavorite()
                    }
                }
            }
        }
    }
    private func constructRoomDataSet(){
        
    }
    
}
