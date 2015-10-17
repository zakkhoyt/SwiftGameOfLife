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
    var x: Int
    var y: Int
    var age: Int

    
    // Mark: Public class methods
    class func keyFor(x: Int, y: Int) -> String {
        return "x:\(x) y:\(y)"
    }

    // MARK: Public methods
    init(x: Int, y: Int){
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
