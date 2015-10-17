//
//  Game.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class Game: NSObject {

    // Mark Public member vars
    var renderGenerationHandler:((Generation)->Void)?
    
    // MARK: Private member vars
    let width: Int
    let height: Int
    var currentGeneration: Generation
    var nextGeneration: Generation? = nil
    
    
    
    init(width: Int, height: Int, currentGeneration: Generation){
        self.width = width
        self.height = height
        self.currentGeneration = currentGeneration
        super.init()
    }
    
    func start(){
        
        // Control how many generations we are rendering
        for _: Int in 0...100 {
            // Process the currentGen into the next Gen
            currentGeneration = currentGeneration.processGeneration()
            
            
            // Let listener know it's time to render
            if let handler = renderGenerationHandler {
                handler(currentGeneration)
            }
        }
    }
    
    func stop(){
        
    }
}
