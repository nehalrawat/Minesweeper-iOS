//
//  Box.swift
//  Minesweeper
//
//  Created by Nehal Rawat on 03/12/15.
//  Copyright © 2015 Nehal Rawat. All rights reserved.
//

import Foundation

class Box:NSObject {
    let row: Int
    let col: Int
    
    var minesNearby = 0
    var mineLoc = false
    var turnedOver = false
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    
    }
    
}