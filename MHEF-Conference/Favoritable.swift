//
//  Favoritable.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 9/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

protocol FavoritesDelegate{
    func toggleFavorite(talk: ConferenceTalk);
}
