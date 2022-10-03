//
//  CalculatorFunctions.swift
//  CalculatorV3
//
//  Created by HS on 3.10.2022.
//

import Foundation

// OPERATION FUNCTIONS
func sum<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
    firstNumber + secondNumber
}

func substract<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
    firstNumber - secondNumber
}

func multiply<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
    firstNumber * secondNumber
}

func divide<T: FloatingPoint>(firstNumber: T, secondNumber: T) -> T {
    firstNumber / secondNumber
}

func percentage(firstNumber:Double,secondNumber:Double)->Double{
    let firstNumber = firstNumber * secondNumber
    return firstNumber / 100.0
}

func root<T: FloatingPoint>(firstNumber: T, secondNumber: T) -> T {
    firstNumber.squareRoot()
}

func pow<T: BinaryInteger>(_ firstNumber: Double, _ secondNumber: Double) -> T {
    func expBySq(_ y: T, _ x: T, _ n: T) -> T {
        precondition(n >= 0)
        if n == 0 {
            return y
        } else if n == 1 {
            return y * x
        } else if n.isMultiple(of: 2) {
            return expBySq(y, x * x, n / 2)
        } else { // n is odd
            return expBySq(y * x, x * x, (n - 1) / 2)
        }
    }
    return T()
    }
