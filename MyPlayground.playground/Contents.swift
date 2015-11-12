//: Playground - noun: a place where people can play

import UIKit

class A: NSObject {
    
}

A.isKindOfClass(NSObject)

struct MASK_COSTANT {
    static let PhySicsBody = UInt32(1000)
    static let Ball = UInt32(1)
    static let Flag = UInt32(2)
}

MASK_COSTANT.Ball | MASK_COSTANT.PhySicsBody
MASK_COSTANT.Flag | MASK_COSTANT.PhySicsBody
MASK_COSTANT.Flag | MASK_COSTANT.Flag

var str = "Hello, playground"
