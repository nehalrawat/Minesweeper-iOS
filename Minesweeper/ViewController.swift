//
//  ViewController.swift
//  Minesweeper
//
//  Created by Nehal Rawat on 03/12/15.
//  Copyright © 2015 Nehal Rawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var squareButtons:[SqButton] = []
    var moves:Int = 0
    var timeTaken:Int = 0
    var oneSecondTimer:NSTimer?
    let sizeOfBoard:Int = 12
    var board:Matrix

    override func viewDidLoad() {
        super.viewDidLoad()
        self.boardCreation()
        self.startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pressToStartNewGame() {
        print("START NEW GAME")
        self.startNewGame()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        self.board = Matrix(size: sizeOfBoard)
        super.init(coder: aDecoder)!
    }
    
    func pressButton(sender: SqButton) {
        if(sender.square.turnedOver == false) {
            sender.square.turnedOver = true
            sender.setTitle("\(sender.textOfSquare())", forState: .Normal)
            self.moves = self.moves + 1
            self.movesLabel.text = "Moves: \(moves)"
            
        }
        
        if sender.square.mineLoc {
            self.selectedMine()
        }
        
        if (sender.textOfSquare() == "") {
            var squareArray: [Box] = board.surroundingSquares(sender.square)
            for x in 0 ..< squareArray.count {
                if (squareArray[x].minesNearby == 0) {
                    squareArray[x].turnedOver = true
                    let button: SqButton = squareToSquareButton(squareArray[x])
                    button.setTitle("\(sender.textOfSquare())", forState: .Normal)
                }
            }
        }
        
        if (self.wonGame()) {
            self.gameIsWon()
        }
    }
    
    func squareToSquareButton(square : Box) -> SqButton{
        var squareButton: SqButton = squareButtons[0]
        for x in 0 ..< squareButtons.count {
            squareButton = squareButtons[x]
            if (squareButton.square == square) {
                return squareButton
            }
        }
        return squareButton
    }
    
    func boardRestart() {
        self.board.boardRestart()
        for squareButton in self.squareButtons {
            squareButton.setTitle("🔳", forState: .Normal)
        }
    }
    
    func startNewGame() {
        self.endThisGame()
        self.boardRestart()
        self.timeTaken = 0
        self.timeLabel.text = "Time: \(timeTaken)"
        self.moves = 0
        self.movesLabel.text = "Moves: \(moves)"
        self.oneSecondTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("oneSecond"), userInfo: nil, repeats: true)
    }
    
    func selectedMine() {
        self.endThisGame()
        let alertView = UIAlertController(title: "YOU LOST!", message: "You tapped on a mine.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "New Game", style: .Default) {
            _ in self.startNewGame()
        }
        alertView.addAction(action)
        self.presentViewController(alertView, animated: true) {}
    }
    
    func gameIsWon() {
        let alertView = UIAlertController(title: "GOOD JOB!", message: "You won!!!!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "New Game", style: .Default) {
            _ in self.startNewGame()
        }
        alertView.addAction(action)
        self.presentViewController(alertView, animated: true) {}
    }
    
    func wonGame() -> Bool {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                let square = board.totalSquares[row][col]
                if (square.turnedOver == false) {
                    if (!square.mineLoc) {
                    return false
                    }
                }
            }
        }
        return true
    }
    
    func oneSecond() {
        self.timeTaken++
        self.timeLabel.text = "Time: \(timeTaken)"
    }
    
    func endThisGame() {
        self.oneSecondTimer?.invalidate()
        self.oneSecondTimer = nil
    }
    
    func boardCreation() {
        
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                let square = board.totalSquares[row][col]
                let squareSize:CGFloat = self.boardView.frame.height / CGFloat(sizeOfBoard)
                let squareButton = SqButton(squareModel: square, sizeOfSquare: squareSize, marginOfSquare: 2);
                squareButton.addTarget(self, action: "pressButton:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(squareButton)
                self.squareButtons.append(squareButton)
            }
        }
    }

}

