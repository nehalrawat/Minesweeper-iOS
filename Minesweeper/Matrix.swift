//
//  Matrix.swift
//  Minesweeper
//
//  Created by Nehal Rawat on 03/12/15.
//  Copyright © 2015 Nehal Rawat. All rights reserved.
//

import Foundation

class Matrix {
    
    var totalSquares:[[Box]] = []
    let size: Int
    
    init(size:Int) {
        self.size = size
        
        for row in 0 ..< size {
            var rowOfSquares:[Box] = []
            for col in 0 ..< size {
                let square = Box(row: row, col: col)
                rowOfSquares.append(square)
            }
            totalSquares.append(rowOfSquares)
        }
    }
    
    func boardRestart() {
        for row in 0 ..< size {
            for col in 0 ..< size {
                totalSquares[row][col].turnedOver = false
                self.mineLocOrNot(totalSquares[row][col])
            }
        }
        
        for row in 0 ..< size {
            for col in 0 ..< size {
                self.howManyMinesNearby(totalSquares[row][col])
            }
        }
    }
    
    func mineLocOrNot(square: Box) {
        square.mineLoc = ((arc4random()%9) == 1)
    }
    
    func howManyMinesNearby(square : Box) {
        
        var minesNearby = 0
        let surroundings = surroundingSquares(square)
        
        for squareNextDoor in surroundings {
            if !squareNextDoor.mineLoc {}
            else if squareNextDoor.mineLoc {
                minesNearby++
            }
        }
        square.minesNearby = minesNearby
    }
    
    func surroundingSquares(square : Box) -> [Box] {
        var surroundings:[Box] = []
        
        for x in -1...1 {
            for y in -1...1 {
                let optionalNeighbor:Box? = coordinateIdentifier(square.row+x, col: square.col+y)
                if let neighbor = optionalNeighbor {
                    surroundings.append(neighbor)
                }
            }
        }
        return surroundings
    }
    
    func coordinateIdentifier(row : Int, col : Int) -> Box? {
        if col >= 0 && col < self.size {
            if row >= 0 && row  < self.size {
                return totalSquares[row][col]
            }
        }
        return nil
    }
}








