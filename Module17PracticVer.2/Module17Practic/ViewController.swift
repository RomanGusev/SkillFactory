//
//  ViewController.swift
//  Module17Practic
//
//  Created by Roman Gusev on 22.12.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var calculateDisplay: UILabel!
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var operationSymbol = ""
    var firstSymbolZero = false
    var dotUsed = false
    var transformDigit: Double {
        get {
            return Double(calculateDisplay.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                calculateDisplay.text = "\(valueArray[0])"
            } else {
                calculateDisplay.text = "\(newValue)"
            }
            firstSymbolZero = false
        }
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        if firstSymbolZero {
            calculateDisplay.text = calculateDisplay.text! + number
    } else {
        calculateDisplay.text = number
        firstSymbolZero = true
        }
    }
       
    
    @IBAction func buttons(_ sender: UIButton) {
        operationSymbol = sender.currentTitle!
        firstNumber = transformDigit
        //print(firstNumber, secondNumber)
        firstSymbolZero = false
        dotUsed = false
    }
    
    func resultNumber(operation: (Double, Double) -> Double) {
        transformDigit = operation(firstNumber, secondNumber)
        firstSymbolZero = false
    }
    
    @IBAction func result(_ sender: UIButton) {
        if firstSymbolZero {
            secondNumber = transformDigit
        }
        
        dotUsed = false
        
        switch operationSymbol {
        case "+": resultNumber{$0 + $1}
        case "-": resultNumber{$0 - $1}
        case "÷": resultNumber{$0 / $1}
        case "×": resultNumber{$0 * $1}
        default: break
        }
    }
    
    @IBAction func Clear(_ sender: UIButton) {
        firstNumber = 0
        secondNumber = 0
        transformDigit = 0
        calculateDisplay.text = "0"
        firstSymbolZero = false
        dotUsed = false
        operationSymbol = ""
    }
    
    @IBAction func plusMinus(_ sender: UIButton) {
        transformDigit = -transformDigit
    }
    
    @IBAction func dot(_ sender: UIButton) {
        if firstSymbolZero && !dotUsed {
            calculateDisplay.text = calculateDisplay.text! + "."
            dotUsed = true
        } else if !firstSymbolZero && !dotUsed {
            calculateDisplay.text = "0."
        }
    }
    
    @IBAction func procent(_ sender: UIButton) {
        if firstNumber == 0 {
            transformDigit = transformDigit / 100
        } else {
            secondNumber = firstNumber / 100 * transformDigit
        }
    }
    
    @IBAction func squareRoot(_ sender: UIButton) {
        transformDigit = sqrt(transformDigit)
    }
    
}

