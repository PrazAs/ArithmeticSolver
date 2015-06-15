//
//  Solution.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/12/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import Foundation

class Solution: NSObject {
    let steps: [Operation]
    let answer: Float
    
    init(steps: [Operation], answer: Float) {
        self.steps = steps
        self.answer = answer
        
        super.init()
    }
}
