//
//  Game.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class Game: NSObject {

    // MARK: Public member vars
    var renderGenerationHandler:((Generation)->Void)?
    
    // MARK: Private member vars
    var width: UInt
    var height: UInt
    var currentGeneration: Generation
    var nextGeneration: Generation? = nil
    var generationCounter: UInt = 0
    var abort: Bool = false
    
    var rule5: Bool = false
    var hideGrid: Bool = false
    
    
    init(width: UInt, height: UInt, currentGeneration: Generation){
        self.width = width
        self.height = height
        self.currentGeneration = currentGeneration
        self.generationCounter = 1
        super.init()
    }
    
    func startWithRenderHander(handler: ((Generation)->Void)){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
//            for _: Int in 0...100 {
            while true {
                if(self.abort == true){
                    break
                }
                
                // Process the currentGen into the next Gen
                self.currentGeneration = self.currentGeneration.processGeneration()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    handler(self.currentGeneration)
                })
            }
        }
    }
    
    func stop(){
        abort = true
    }
    
    func evolveOnceWithRenderHander(handler: ((Generation)->Void)){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            // Process the currentGen into the next Gen
            self.currentGeneration = self.currentGeneration.processGeneration()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                handler(self.currentGeneration)
            })
        }
    }
    
}
