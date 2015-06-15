//
//  RACSignalExtensions.swift
//  PresentRooms
//
//  Created by Justin Makaila on 5/14/15.
//  Copyright (c) 2015 Present, Inc. All rights reserved.
//

import Foundation
import ReactiveCocoa

extension RACSignal {
    class func rac_return(value: AnyObject!) -> RACSignal {
        return RACSignal.createSignal { subscriber in
            subscriber.sendNext(value)
            subscriber.sendCompleted()
            
            return nil
        }
    }
    
    class func rac_if(boolSignal: RACSignal, then trueSignal: RACSignal, rac_else falseSignal: RACSignal) -> RACSignal {
        let signal = boolSignal
            .mapAs { (value: NSNumber) -> RACSignal in
                return value.boolValue ? trueSignal : falseSignal
            }
            .switchToLatest()
        
        signal.name = "+rac_if: \(boolSignal), then: \(trueSignal), else: \(falseSignal)"
        
        return signal
    }
    
    func doNextAs<T: AnyObject>(block: (T) -> Void) -> RACSignal! {
        return doNext { (value: AnyObject!) in
            if let casted = value as? T {
                block(casted)
            }
        }
    }
    
    func subscribeNextAs<T>(nextClosure: (T) -> Void) -> Void {
        self.subscribeNext { (next: AnyObject!) -> () in
            if let nextAsT = next as? T {
                nextClosure(nextAsT)
            }
        }
    }
    
    func subscribeNextAs<T>(nextClosure: (T) -> Void, error: (NSError!) -> Void) {
        self.subscribeNext({ (next: AnyObject!) -> () in
            let nextAsT = next as! T
            nextClosure(nextAsT)
            },
            error: error)
    }
    
    func subscribeNextAs<T>(nextClosure: (T) -> Void, error: (NSError!) -> Void, completed: Void -> Void) {
        self.subscribeNext({ (next: AnyObject!) -> () in
            let nextAsT = next as! T
            nextClosure(nextAsT)
            },
            error: error,
            completed: completed)
    }
}