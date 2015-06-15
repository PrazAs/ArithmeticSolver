//
//  Operation.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/12/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import Foundation

class Operation: Printable {
    let lhs: Float
    let rhs: Float
    let `operator`: Operator
    
    init(lhs: Float, rhs: Float, `operator`: Operator) {
        self.lhs = lhs
        self.rhs = rhs
        self.`operator` = `operator`
    }
    
    func solve() -> Float {
        return `operator`.function(lhs, rhs)
    }
}

extension Operation: Printable {
    var description: String {
        return "\(lhs) \(`operator`) \(rhs)"
    }
}
