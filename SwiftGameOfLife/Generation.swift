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
    var livingCells: Dictionary<String, Cell>
    
    // MARK: public methods
    init(width: Int, height: Int, livingCells: Dictionary<String, Cell>) {
        self.width = width
        self.height = height
        self.livingCells = livingCells
        super.init()
    }
    
    func processGeneration() -> Generation {
        let nextGen = Generation(width: width, height: height, livingCells: Dictionary())
        for x in 0..<width {
            for y in 0..<height {
                let key = Cell.keyFor(x, y: y)
                let livingCell = livingCells[key]
                if livingCell != nil {
                    // Cell is alive. Check if it should die
                    if passesRule1(livingCell!) && passesRule2(livingCell!) && passesRule3(livingCell!) {
                        // Cell lives to next generation
                        nextGen.livingCells[key] = livingCell
                    } else {
                        // Cell dies
                    }
                } else {
                    // Cell is dead. Check if it should come to life
                    let deadCell = Cell(x: x, y: y)
                    if passesRule4(deadCell) {
                        // Cell comes to life for next generation
                        nextGen.livingCells[key] = deadCell
                    } else {
                        // Cell remains dead
                    }
                }
            }
            
        }
        return nextGen;
    }
    
    func printGeneration(){
        // TODO print grid of 0|1 to console
    }

    // MARK: private methods
    private func getNeighborFromCell(cell: Cell, index: Int) -> Cell? {
        var x = cell.x
        var y = cell.y

        // 0,1,2
        // 3,x,4
        // 5,6,7
        switch index{
        case 0:
            x-=1
            y-=1
        case 1:
            y-=1
        case 2:
            x+=1
            y-=1
        case 3:
            x-=1
        case 4:
            x+=1
        case 5:
            x-=1
            y+=1
        case 6:
            y+=1
        case 7:
            x+=1
            y+=1
        default:
            return nil
        }
        let key = Cell.keyFor(x, y: y)
        let cell = livingCells[key]
        return cell
    }
    
    
    
    private func getNeighboringCells(cell: Cell) -> [Cell] {
        var neighbors = Array<Cell>()
        for index in 0..<8 {
            if let cell = getNeighborFromCell(cell, index: index){
                neighbors.append(cell)
            }
        }
        return neighbors;
    }
    
    

    // Any live cell with fewer than two live neighbours dies, as if by needs caused by underpopulation.
    private func passesRule1(cell: Cell) -> Bool {
        let neighbors = getNeighboringCells(cell)
        if neighbors.count < 2 {
            return false
        }
        return true
    }
    
    // Any live cell with more than three live neighbours dies, as if by overcrowding.
    private func passesRule2(cell: Cell) -> Bool {
        let neighbors = getNeighboringCells(cell)
        if neighbors.count > 3 {
            return false
        }
        return true

    }

    // Any live cell with two or three live neighbours lives, unchanged, to the next generation.
    private func passesRule3(cell: Cell) -> Bool {
        let neighbors = getNeighboringCells(cell)
        if neighbors.count == 2 || neighbors.count == 3 {
            return true
        }
        return false
    }
    
    // Any dead cell with exactly three live neighbours cells will come to life.
    private func passesRule4(cell: Cell) -> Bool {
        let neighbors = getNeighboringCells(cell)
        if neighbors.count == 3 {
            return true
        }
        return false
    }

    private func passesRule5(cell: Cell) -> Bool {
        return false
    }
    
    
    
    
}
