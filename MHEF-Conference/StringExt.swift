//
//  StringExt.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 6/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

extension String{
    //trims any leading/trailing whitespace from the string
    func trim()->String{
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    //takes the string and converts it into a string that can be used to find the pic asset associated with it
    func ToPicString()->String{
        var nameArr = self.components(separatedBy: " ")
        
        var results = "";
        for i in 0 ..< nameArr.capacity{
            results += nameArr[i].lowercased()
            if(i != (nameArr.capacity - 1)){
                results += "_"
            }
        }
        
        return results;
    }
}
