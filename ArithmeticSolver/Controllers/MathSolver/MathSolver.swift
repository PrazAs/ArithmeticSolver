//
//  MathSolver.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/12/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import Foundation

private func combineDigits(expression: String) -> [String] {
    let scalars = expression.unicodeScalars
    // Reduce the scalars to an array of non-empty strings
    let components = reduce(scalars, []) { $0 + ["\($1)"] }
        .filter { !($0.isEmpty || $0 == " ") }
    
    // An array to hold each component
    var combinedComponents: [String] = []
    
    // A string to hold the pending number
    var numberBuffer: String = ""
    
    // Iterate through each component
    for component in components {
        // TODO: Parse negative numbers (if the component is a "-", and follows a non-digit)
        // TODO: Parse decimal numbers (if the component is a ".", preceeded by some digit, and followed by some digit)
        
        // If the component is a digit...
        if component.isDigit() {
            // ...add it to the number
            numberBuffer += component
        } else {
            // If `numberBuffer` is not empty...
            if !numberBuffer.isEmpty {
                // Insert the number before the non-digit
                combinedComponents.append(numberBuffer)
                // Reset the number buffer
                numberBuffer = ""
            }
            
            // Append the component as is
            combinedComponents.append(component)
        }
    }
    
    // Flush the buffer...
    if !numberBuffer.isEmpty {
        // Insert the last number
        combinedComponents.append(numberBuffer)
        numberBuffer = ""
    }
    
    return combinedComponents
}

class MathSolver {
    // The operators available to be used
    let operators: [String: Operator] = [
        "^": exponentialOperator,
        "/": divisionOperator,
        "*": multiplicationOperator,
        "+": additionOperator,
        "-": subtractionOperator
    ]
    
    /**
        Solves an expression and returns a Solution
        
        :param: expression The expression to be solved.
        :param: postfix Whether or not the expression is provided in postfix notation.
    
        :returns: Solution for the expression.
     */
    func solve(expression: String, postfix: Bool? = false) -> Solution {
        let postfixExpression = (postfix!) ? parsePostfix(expression) : parseInfix(expression)
        return solvePostfix(postfixExpression)
    }
    
    // Splits an expression into an array with each index representing a component
    private func expressionComponents(expression: String) -> [String] {
        return combineDigits(expression)
    }
    
    /**
        Parses an infix expression into an array of postfix expression components.
    
        :param: infixExpression A string representing an expression in infix notation.
    
        :returns: An array of strings representing each component in the postfix notation expression.
     */
    private func parseInfix(infixExpression: String) -> [String] {
        let infixComponents = expressionComponents(infixExpression)
        return infixToPostfix(infixComponents)
    }
    
    /**
        Parses a postfix expression into an array of components.
    
        :param: postfixExpression A string representing an expression in postfix notation.
    
        :returns: An array of strings representing each component in the expression.
     */
    private func parsePostfix(postfixExpression: String) -> [String] {
        return expressionComponents(postfixExpression)
    }
    
    /**
        Solves a postfix expression, returning a solution.
    
        :param: postfixExpression The expression components to solve, in postfix notation.
    
        :returns: Solution for the expression.
     */
    private func solvePostfix(postfixExpression: [String]) -> Solution {
        var operations: [Operation] = []
        var stack: [Float] = []
        
        let components = postfixExpression.map { (string: String) -> Any in
            if let integer = string.toInt() {
                return Float(integer)
            }
            
            if let `operator` = self.operators[string] {
                return `operator`
            }
            
            return string
        }
        
        for token in components {
            if let token = token as? Float {
                stack.append(token)
            } else if let token = token as? Operator {
                let rhs = stack.removeLast()
                let lhs = stack.removeLast()
                
                let operation = Operation(lhs: lhs, rhs: rhs, `operator`: token)
                let solution = operation.solve()
                
                stack.append(solution)
                operations.append(operation)
            }
        }
        
        let answer = operations.last!.solve()
        return Solution(steps: operations, answer: answer)
    }
    
    /**
        Transforms an infix expression to postfix.
    
        :param: tokens An array of strings, where each string represents a token (digit or operator) in an infix expression.
        :returns: An array of strings, where each string represents a token (digit or operator) in a postfix expression.
     */
    private func infixToPostfix(tokens: [String]) -> [String] {
        var output: [String] = []
        var operatorStack: [String] = []
        
        for token in tokens {
            switch token {
            case "(":
                operatorStack += [token]
            case ")":
                while !operatorStack.isEmpty {
                    let lastOperator = operatorStack.removeLast()
                    
                    if lastOperator == "(" {
                        break
                    } else {
                        output += [lastOperator]
                    }
                }
            default:
                // If the token is an operator...
                if let newOperator = operators[token] {
                    for `operator` in operatorStack.reverse() {
                        if let recentOperator = operators[`operator`] {
                            if !(newOperator.precedence > recentOperator.precedence || (newOperator.precedence == recentOperator.precedence && newOperator.associativity == .Right)) {
                                output += [operatorStack.removeLast()]
                                continue
                            }
                        }
                        
                        break
                    }
                    
                    operatorStack += [token]
                } else {
                    output += [token]
                }
            }
        }
        
        return output + operatorStack.reverse()
    }
}
