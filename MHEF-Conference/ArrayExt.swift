//
//  ArrayExt.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 9/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

extension Array{
    func toString()->String{
        var output: String = ""
        for talk in self{
            var temp  = talk as! ConferenceTalk
            output += temp.getTitle()
            if 
        }
        return output
    }
}
