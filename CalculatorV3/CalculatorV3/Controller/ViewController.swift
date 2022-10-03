//
//  ViewController.swift
//  CalculatorV3
//
//  Created by HS on 3.10.2022.
//

import UIKit

final class ViewController: UIViewController {

    var didOperandButtonTapped = false
    
    var steps:String = ""
    
    var result: Double = .zero {
        didSet {
            displayLabel.text = "\(result)"
        }
    }
    
    var numbers = [Double]() {
        didSet {
            print(numbers)
        }
    }
    
    // A label to display current result of calculation.
    var displayValue: String? {
        get {
            displayLabel.text
        }
        set {
            guard let newValue = newValue else {
                return
            }
            if displayLabel.text == "0" {
                displayLabel.text! = newValue
            } else {
                displayLabel.text! += newValue
            }
        }
    }
    
    // A label to display all steps of the calculation.
  /*    var displayStepsValue: String? {
        get {
            displayStepsLabel.text
        }
        set {
            guard let newValue = newValue else {
                return
            }
            if displayStepsLabel.text == "0" {
                displayStepsLabel.text! = newValue
            } else {
                displayStepsLabel.text! += newValue
            }
        }
    } */
    
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // This button sets the digit button.
    @IBAction private func didTapDigitButton(_ sender: UIButton) {
        
            if didOperandButtonTapped {
                displayLabel.text = "0"
                didOperandButtonTapped = false
            }
            guard let currentTitle = sender.currentTitle else {
                return
            }
        
            displayValue = currentTitle
      //      addToSteps(value: "\(currentTitle)") //
    }
    
    @IBAction private func decimalButton(_ sender: UIButton) {
        if numbers.count > 1 {
            
            guard let firstNumber = numbers.popLast() else {
                return
            }
            
            let result = Double(firstNumber)
            self.result = result
        } else {
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            numbers.append(displayValueInDouble)
         //   addToSteps(value: ".")
        }
    }
    
    // All of the operations called here.

    @IBAction private func didTapOperandButton(_ sender: UIButton) {
        
            didOperandButtonTapped = true
            
            guard let currentTitle = sender.currentTitle else {
                return
            }
            switch currentTitle {
            case "x":
                if numbers.count > 1 {
                    
                    guard let firstNumber = numbers.popLast(),
                          let secondNumber = numbers.popLast() else {
                        return
                    }
                    
                    let result = multiply(firstNumber: firstNumber,
                                          secondNumber: secondNumber)
                    self.result = result
                } else {
                    guard let displayValueInDouble = Double(displayValue ?? "0") else {
                        return
                    }
                    numbers.append(displayValueInDouble)
             //       addToSteps(value: "x")
                }
                break
                
            case "/":
                if numbers.count > 1 {
                    
                    guard let firstNumber = numbers.popLast(),
                          let secondNumber = numbers.popLast() else {
                        return
                    }
                    
                    let result = divide(firstNumber: firstNumber,
                                        secondNumber: secondNumber)
                    self.result = result
                } else {
                    guard let displayValueInDouble = Double(displayValue ?? "0") else {
                        return
                    }
                    numbers.append(displayValueInDouble)
               //     addToSteps(value: "/")
                }
                break
                
            case "-":
                if numbers.count > 1 {
                    
                    guard let firstNumber = numbers.popLast(),
                          let secondNumber = numbers.popLast() else {
                        return
                    }
                    
                    let result = substract(firstNumber: firstNumber,
                                           secondNumber: secondNumber)
                    self.result = result
                } else {
                    guard let displayValueInDouble = Double(displayValue ?? "0") else {
                        return
                    }
                    numbers.append(displayValueInDouble)
                 //   addToSteps(value: "-")
                }
                break
                
            case "+":
                if numbers.count > 1 {
                    
                    guard let firstNumber = numbers.popLast(),
                          let secondNumber = numbers.popLast() else {
                        return
                    }
                    
                    let result = Darwin.pow(firstNumber, secondNumber)
                    self.result = result
                } else {
                    guard let displayValueInDouble = Double(displayValue ?? "0") else {
                        return
                    }
                    numbers.append(displayValueInDouble)
                //    addToSteps(value: "+")
                }
                
            case "%":
                if numbers.count > 1 {
                    
                    guard let firstNumber = numbers.popLast(),
                          let secondNumber = numbers.popLast() else {
                        return
                    }
                    
                    let result = percentage(firstNumber: firstNumber,
                                            secondNumber: secondNumber)
                    self.result = result
                } else {
                    guard let displayValueInDouble = Double(displayValue ?? "0") else {
                        return
                    }
                    numbers.append(displayValueInDouble)
               //     addToSteps(value: "%")
                }
                
            case "^":
                if numbers.count > 1 {
                    
                    guard let firstNumber = numbers.popLast(),
                          let secondNumber = numbers.popLast() else {
                        return
                    }
                    
                    let result = Darwin.pow(firstNumber,
                                            secondNumber)
                    self.result = result
                } else {
                    guard let displayValueInDouble = Double(displayValue ?? "0") else {
                        return
                    }
                    numbers.append(displayValueInDouble)
                //    addToSteps(value: "^")
                }
                
            case "√":
                if numbers.count > 1 {
                    
                    guard let firstNumber = numbers.popLast(),
                          let secondNumber = numbers.popLast() else {
                        return
                    }
                    
                    let result = root(firstNumber: firstNumber,
                                      secondNumber: secondNumber)
                    self.result = result
                } else {
                    guard let displayValueInDouble = Double(displayValue ?? "0") else {
                        return
                    }
                    numbers.append(displayValueInDouble)
                //    addToSteps(value: "√")
                }
                
            case "=":
                guard let displayValueInDouble = Double(displayValue ?? "0") else {
                    return
                }
                numbers.append(displayValueInDouble)
                
                if numbers.count > 1 {
                    
                    guard let firstNumber = numbers.popLast(),
                          let secondNumber = numbers.popLast() else {
                        return
                    }
                    
                    let result = sum(firstNumber: firstNumber,
                                     secondNumber: secondNumber)
                    self.result = result
                //    addToSteps(value: "=")
                }
                
            default:
                break
            }
    }
    
    @IBAction private func didTapClearButton(_ sender: UIButton) {
            displayValue = "0"
         //   displayStepsValue = "0"
    }
    
    // Adding every step of calculation to display label.
    func addToSteps(value: String)
    {
        steps = steps + value
     //   displayStepsLabel.text = steps
    }
    
    

    
}

