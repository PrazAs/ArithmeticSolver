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
        return RACSignal.createSignal { subscriber in
            let solution = self.mathSolver.solve(self.expression)
            
            subscriber.sendNext(solution)
            subscriber.sendCompleted()
            
            return nil
        }
    }
}
