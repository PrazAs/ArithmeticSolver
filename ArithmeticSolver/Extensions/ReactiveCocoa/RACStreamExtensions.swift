//
//  RACStreamExtensions.swift
//  PresentRooms
//
//  Created by Justin Makaila on 5/14/15.
//  Copyright (c) 2015 Present, Inc. All rights reserved.
//

import Foundation
import ReactiveCocoa

extension RACStream {
    func flattenMapAs<T>(block: (T) -> RACStream) -> Self {
        return flattenMap { (value: AnyObject!) in
            if let casted = value as? T {
                return block(casted)
            }
            
            return nil
        }
    }
    
    func mapAs<T,U: AnyObject>(block: (T) -> U) -> Self {
        return map { (value: AnyObject!) in
            if let casted = value as? T {
                return block(casted)
            }
            
            return nil
        }
    }
    
    func filterAs<T>(block: (T) -> Bool) -> Self {
        return filter { (value: AnyObject!) in
            if let casted = value as? T {
                return block(casted)
            }
            
            return false
        }
    }
}