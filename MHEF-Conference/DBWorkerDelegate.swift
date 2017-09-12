//
//  DBWorkerDelegate.swift
//  MHEF-Conference
//
//  Created by admin on 5/15/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

protocol DBWorkerDelegate : class{
    func didFinishTask(returnedJSON: [String: Any]?, wasASuccess: Bool);
}
