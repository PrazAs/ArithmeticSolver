//
//  ArithmeticSolverViewModel.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/15/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import Foundation
import ReactiveCocoa

class ArithmeticSolverViewModel: NSObject {
    var expression: String = ""
    
    private let mathSolver = MathSolver()
    
    func solveExpressionSignal() -> RACSignal {
        let expression = self.expression
        
        return RACSignal.createSignal { subscriber in
            if !expression.isEmpty {
                let solution = self.mathSolver.solve(expression)
                
                subscriber.sendNext(solution)
                subscriber.sendCompleted()
            } else {
                let emptyExpressionError = NSError(domain: "com.Tabtor.ArithmeticSolver.ArithmeticSolverViewModel", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Expression is empty."
                ])
                
                subscriber.sendError(emptyExpressionError)
            }
            
            return nil
        }
    }
}
