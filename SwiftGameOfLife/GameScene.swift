//
//  GameScene.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var game: Game? = nil {
        didSet{
            xCells = (game?.width)!
            yCells = (game?.height)!
        }
    }
    
    var xCells: UInt = 1{
        didSet{
            yCells = UInt(CGFloat(xCells) * self.frame.size.height / self.frame.size.width)
            print("x: \(xCells) y: \(yCells))")
            drawScene()
        }
    }
    var yCells: UInt = 1
    
    var gridLineNodes: [SKNode] = []
    var cellNodes: [SKNode] = []

    override func didMoveToView(view: SKView) {
//        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let point = touch.locationInNode(self)
            let nodes = nodesAtPoint(point)
            
            var found = false
            for node in nodes {
                if node.name?.containsString("cell") == true {
                    print("tapped living cell " + node.name!)
                    found = true
                    // TODO: kill cell
                }
            }
            
            if found == false {
                let index = getCellIndexAtPoint(point)
                // TODO: bring cell to life
                print("no living cell found x:\(index.x) y:\(index.y)")
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }


    private func xSpacing() -> CGFloat {
        return CGFloat(frame.size.width / CGFloat(xCells))
    }

    private func ySpacing() -> CGFloat {
        return CGFloat(frame.size.height / CGFloat(yCells))
    }
    
    
    private func getCellIndexAtPoint(point: CGPoint) -> (x: UInt, y: UInt)  {
        let x = UInt(point.x / xSpacing())
        let y = UInt(point.y / ySpacing())
        return (x, y)
    }
    
    private func drawScene() {
        // Clean up first
        for gridLine in gridLineNodes{
            gridLine.removeFromParent()
        }
        for cellNode in cellNodes{
            cellNode.removeFromParent()
        }

        // Draw new nodes
        drawCells()
        drawGrid()
    }
    
    
    private func drawGrid() {
        let xSpacing = self.xSpacing()
        for x in 0...xCells{
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, CGFloat(x) * xSpacing, 0)
            CGPathAddLineToPoint(path, nil, CGFloat(x) * xSpacing, frame.size.height)
            let line = SKShapeNode(path: path)
            line.name = "line"
            line.strokeColor = UIColor.greenColor()
            self.addChild(line)
            gridLineNodes.append(line)
        }

        let ySpacing = self.ySpacing()
        for y in 0...yCells{
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 0, CGFloat(y) * ySpacing)
            CGPathAddLineToPoint(path, nil, frame.size.width, CGFloat(y) * ySpacing)
            let line = SKShapeNode(path: path)
            line.strokeColor = UIColor.greenColor()
            self.addChild(line)
            gridLineNodes.append(line)
        }
    }
    
    private func drawCells(){
        let xSpacing = self.xSpacing()
        let ySpacing = self.ySpacing()
        for cell: Cell in (game?.currentGeneration.livingCells)!.values {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, CGFloat(cell.x) * xSpacing, CGFloat(cell.y) * ySpacing)
            CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing + xSpacing, CGFloat(cell.y) * ySpacing)
            CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing + xSpacing, CGFloat(cell.y) * ySpacing + ySpacing)
            CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing, CGFloat(cell.y) * ySpacing + ySpacing)
            let cellNode = SKShapeNode(path: path)
            cellNode.name = "cell " + cell.key()
            cellNode.fillColor = UIColor.redColor()
            self.addChild(cellNode)
            cellNodes.append(cellNode)
            
        }
    }
    
}
