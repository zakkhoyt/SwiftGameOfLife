//
//  Generation.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

final class Generation: NSObject {
    
    // MARK: Private member variables
    private var width: Int
    private var height: Int
    private var livingCells: Set<Cell>

    // MARK: public methods
    init(width: Int, height: Int, livingCells: Set<Cell>) {
        self.width = width
        self.height = height
        self.livingCells = livingCells
        super.init()
    }
    func processGeneration() -> Generation {
        return self;
    }

    // MARK: private methods
    private func passesRule1(cell: Cell) -> Bool {
        return false
    }
    
    private func passesRule2(cell: Cell) -> Bool {
        return false
    }

    private func passesRule3(cell: Cell) -> Bool {
        return false
    }

    private func passesRule4(cell: Cell) -> Bool {
        return false
    }

    private func passesRule5(cell: Cell) -> Bool {
        return false
    }
    
    
    
    
}
