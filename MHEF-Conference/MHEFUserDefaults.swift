//
//  MHEFUserDefaults.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 9/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

class MHEFUserDefaults{
    var defaults = UserDefaults.standard
    
    init(){}
    func add(forKey: String, data: String){
        self.defaults.set(data, forKey: forKey)
        self.defaults.synchronize()
    }
    func get(key forKey: String)->String?{
        let test = self.defaults.string(forKey: forKey)
        return test
    }
    func get(forKey: String)-> Any?{
        self.defaults.synchronize()
        return self.defaults.object(forKey: forKey)
    }
    func delete(forKey: String){
        self.defaults.removeObject(forKey: forKey)
        self.defaults.synchronize()
    }
}
