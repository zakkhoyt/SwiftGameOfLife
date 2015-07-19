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
    private var x: Int
    private var y: Int
    private var age: Int
    
    // MARK: Public methods
    init(x: Int, y: Int){
        self.x = x
        self.y = y
        self.age = 0
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
    
    func cellDescription() -> String {
        return "x:\(x) y:\(y) age:\(age)"
    }
    
    func key() -> String {
        return "x:\(x) y:\(y)"
    }
}
