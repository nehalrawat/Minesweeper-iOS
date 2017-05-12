//
//  SqButton.swift
//  Minesweeper
//
//  Created by Nehal Rawat on 03/12/15.
//  Copyright © 2015 Nehal Rawat. All rights reserved.
//

import UIKit

class SqButton : UIButton {

    let sizeOfSquare:CGFloat
    let marginOfSquare:CGFloat
    var square:Box
    
    init(squareModel:Box, sizeOfSquare:CGFloat, marginOfSquare:CGFloat) {
        
        self.square = squareModel
        self.sizeOfSquare = sizeOfSquare
        self.marginOfSquare = marginOfSquare
        let x = CGFloat(self.square.col) * (sizeOfSquare + marginOfSquare)
        let y = CGFloat(self.square.row) * (sizeOfSquare + marginOfSquare)
        let grid = CGRectMake(x, y, sizeOfSquare, sizeOfSquare)
        super.init(frame: grid)
}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textOfSquare() -> String {
        if (self.square.mineLoc == false) {
            if self.square.minesNearby == 0 {
                return ""
            }
            return "\(self.square.minesNearby)"
        }
        return "💣"
    }
    
}