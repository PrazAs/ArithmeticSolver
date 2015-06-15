//
//  StringExtensions.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/15/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import Foundation

extension String {
    func isDigit() -> Bool {
        return toInt() != nil
    }
}