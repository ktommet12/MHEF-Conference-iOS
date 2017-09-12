//
//  DBWorker.swift
//  MHEF-Conference
//
//  Created by admin on 5/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

class DBWorker{
    var delegate : DBWorkerDelegate!
    
    let session: URLSession = {
       let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    init(){}
    
    func getConferenceContents(){
        self.getConferenceContents(conference: .DEFAULT)
    }
    
    func getConferenceContents(conference: ConferenceType){
        var tempUrl = "";
        switch(conference){
        case .EVOLUTION:
            tempUrl = AppConfig.EVOLUTION_CONTENTS_URL;
        case .COUPLES:
            tempUrl = AppConfig.COUPLES_CONTENTS_URL;
        case .BRIEF:
            tempUrl = AppConfig.BRIEF_CONTENTS_URL;
        case .DEFAULT:
            tempUrl = AppConfig.EVOLUTION_CONTENTS_URL;
            break;
        }
        let url = URL(string: tempUrl)
        let urlRequest = URLRequest(url: url!)
        performTask(urlRequest: urlRequest)
    }
    
    private func performTask(urlRequest: URLRequest){
        let task = session.dataTask(with: urlRequest){
            (data, response, error) -> Void in
            
            if let jsonData = data{
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    let jsonResponse = jsonObject as? [String: Any]
                    self.delegate?.didFinishTask(returnedJSON: jsonResponse, wasASuccess: true)
                }catch let error{
                    print("Error Parsing Input Data from Server")
                    self.delegate?.didFinishTask(returnedJSON: nil, wasASuccess: false)
                }
            }else if let requestError = error{
                print("Error: \(error?.localizedDescription)")
                self.delegate?.didFinishTask(returnedJSON: nil, wasASuccess: false)
            }else{
                print("Unexpected Error")
                self.delegate?.didFinishTask(returnedJSON: nil, wasASuccess: false)
            }
            
        }
        task.resume();
    }
    
}
