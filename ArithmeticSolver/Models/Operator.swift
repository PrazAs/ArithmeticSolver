//
//  Operator.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/12/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import Foundation

struct Operator: Printable {
    enum Associativity: String {
        case Left = "Left"
        case Right = "Right"
    }
    
    let precedence: Int
    let associativity: Associativity
    let symbol: String
    
    let function: (Float, Float) -> Float
}

extension Operator: Printable {
    var description: String {
        return symbol
    }
}

// MARK: - Commonly Used Operators

// Define the exponential operator
let exponentialOperator = Operator(precedence: 4, associativity: .Right, symbol: "^", function: { lhs, rhs in
    return pow(lhs, rhs)
})

// Define the division operator
let divisionOperator = Operator(precedence: 3, associativity: .Left, symbol: "/", function: { lhs, rhs in
    return lhs / rhs
})

// Define the multiplication operator
let multiplicationOperator = Operator(precedence: 3, associativity: .Left, symbol: "*", function: { lhs, rhs in
    return lhs * rhs
})

// Define the addition operator
let additionOperator = Operator(precedence: 2, associativity: .Left, symbol: "+", function: { lhs, rhs in
    return lhs + rhs
})

// Define the subtraction operator
let subtractionOperator = Operator(precedence: 2, associativity: .Left, symbol: "-", function: { lhs, rhs in
    return lhs - rhs
})
