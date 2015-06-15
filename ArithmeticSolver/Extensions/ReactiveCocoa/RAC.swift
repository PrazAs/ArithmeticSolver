//
//  RAC.swift
//  PresentRooms
//
//  Created by Justin Makaila on 5/14/15.
//  Copyright (c) 2015 Present, Inc. All rights reserved.
//

import Foundation
import ReactiveCocoa

struct RAC {
    var target: NSObject
    var keyPath: String
    var nilValue: AnyObject?
    
    init(_ target: NSObject, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    func assignSignal(signal: RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

infix operator  <~ {}
infix operator  ~> {}

func <~ (rac: RAC, signal: RACSignal) {
    rac.assignSignal(signal)
}

func ~> (signal: RACSignal, rac: RAC) {
    rac.assignSignal(signal)
}

func RACObserve(target: NSObject!, keyPath: String) -> RACSignal  {
    return target.rac_valuesForKeyPath(keyPath, observer: target)
}
