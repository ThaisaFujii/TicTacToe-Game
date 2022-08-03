//
//  ViewController.swift
//  TicTacToeGame
//
//  Created by Thaisa Fujii on 02/08/22.
// 7:15 min - https://www.youtube.com/watch?v=m6EH-JlCLsQ&list=PLnQbggnVfvo2wIr4kV1h6208xk1pPf2F0

import UIKit

class ViewController: UIViewController {
    enum Turn {
        case Nought
        case Cross
    }
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var square1: UIButton!
    @IBOutlet weak var square2: UIButton!
    @IBOutlet weak var square3: UIButton!
    @IBOutlet weak var square4: UIButton!
    @IBOutlet weak var square5: UIButton!
    @IBOutlet weak var square6: UIButton!
    @IBOutlet weak var square7: UIButton!
    @IBOutlet weak var square8: UIButton!
    @IBOutlet weak var square9: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        // Do any additional setup after loading the view.
    }
    
    func initBoard() {
        board.append(square1)
        board.append(square2)
        board.append(square3)
        board.append(square4)
        board.append(square5)
        board.append(square6)
        board.append(square7)
        board.append(square8)
        board.append(square9)
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS){
            crossesScore += 1
            resultAlert(title: "Crosses Win!")
            
        }
        if checkForVictory(NOUGHT){
            noughtsScore += 1
            resultAlert(title: "Noughts Win!")
            
        }
        
        if(fullBoard()) {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s: String) -> Bool{
        // horizontal victory
        if thisSymbol(square1, s) && thisSymbol(square2, s) && thisSymbol(square3, s) {
            return true
        }
        if thisSymbol(square4, s) && thisSymbol(square5, s) && thisSymbol(square6, s) {
            return true
        }
        if thisSymbol(square7, s) && thisSymbol(square8, s) && thisSymbol(square9, s) {
            return true
        }
        // vertical victory
        if thisSymbol(square1, s) && thisSymbol(square4, s) && thisSymbol(square7, s) {
            return true
        }
        if thisSymbol(square2, s) && thisSymbol(square5, s) && thisSymbol(square8, s) {
            return true
        }
        if thisSymbol(square3, s) && thisSymbol(square6, s) && thisSymbol(square9, s) {
            return true
        }
        // diagonal victory
        if thisSymbol(square1, s) && thisSymbol(square5, s) && thisSymbol(square9, s) {
            return true
        }
        if thisSymbol(square3, s) && thisSymbol(square5, s) && thisSymbol(square7, s) {
            return true
        }
            return false
    }
    
    func thisSymbol(_ button:  UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {(_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.Nought) {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        } else if(firstTurn == Turn.Cross) {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
        
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton){
        if(sender.title(for: . normal) == nil)
        {
            if(currentTurn == Turn.Nought){
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            // resetar
            sender.isEnabled = false
        }
    }
}

