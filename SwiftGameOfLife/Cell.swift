//
//  Cell.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

final class Cell: NSObject {
    
    // MARK: Private memeber variables
    var x: UInt
    var y: UInt
    var age: UInt

    
    // MARK: Public class methods
    class func keyFor(x: UInt, y: UInt) -> String {
        return "x:\(x) y:\(y)"
    }

    // MARK: Public methods
    init(x: UInt, y: UInt){
        self.x = x
        self.y = y
        self.age = 1
        super.init()
    }

    func colorFromAge() -> UIColor {
        switch age{
        case 0...4:
            return UIColor.lightGrayColor()
        case 5...10:
            return UIColor.whiteColor()
        default:
            return UIColor.clearColor()
        }
    }
    
    func key() -> String {
        return "x:\(x) y:\(y)"
    }

    
    func cellDescription() -> String {
        return "x:\(x) y:\(y) age:\(age)"
    }
}
