//
//  Game.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class Game: NSObject {

    let width: Int
    let height: Int
    let currentGeneration: Generation
    var nextGeneration: Generation? = nil
    
    init(width: Int, height: Int, currentGeneration: Generation){
        self.width = width
        self.height = height
        self.currentGeneration = currentGeneration
        super.init()
    }
    
    
    
}
