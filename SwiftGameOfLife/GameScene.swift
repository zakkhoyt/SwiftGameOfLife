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
                    let index = getCellIndexAtPoint(point)
                    let key = Cell.keyFor(index.x, y: index.y)
                    game?.currentGeneration.livingCells[key] = nil
                    drawScene()
//                    if let cell = game?.currentGeneration.livingCells[key] {
//                        
//                    }
                }
            }
            
            if found == false {
                let index = getCellIndexAtPoint(point)
                // TODO: bring cell to life
                print("no living cell found x:\(index.x) y:\(index.y)")
                let cell = Cell(x: index.x, y: index.y)
                game?.currentGeneration.livingCells[cell.key()] = cell
                drawScene()
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
    
    func drawScene() {
        // Clean up first
        for gridLine in gridLineNodes{
            gridLine.removeFromParent()
        }
        for cellNode in cellNodes{
            cellNode.removeFromParent()
        }

        // Draw new nodes
        drawCells()
        
        // Draw grid lines
        if game?.hideGrid == false {
            drawGrid()
        }
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
        
        if game?.currentGeneration.livingCells.count > 0 {
            for cell: Cell in (game?.currentGeneration.livingCells)!.values {
                // Make a rect and add a sprite to it
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, CGFloat(cell.x) * xSpacing, CGFloat(cell.y) * ySpacing)
                CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing + xSpacing, CGFloat(cell.y) * ySpacing)
                CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing + xSpacing, CGFloat(cell.y) * ySpacing + ySpacing)
                CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing, CGFloat(cell.y) * ySpacing + ySpacing)
                let cellNode = SKShapeNode(path: path)
                cellNode.name = "cell " + cell.key()
                cellNode.fillColor = UIColor.redColor()
                cellNode.strokeColor = UIColor.cyanColor()
                self.addChild(cellNode)
                cellNodes.append(cellNode)
                
                let spriteNode = SKSpriteNode(imageNamed: "Spaceship")
                spriteNode.position = CGPointMake(CGRectGetMidX(cellNode.frame), CGRectGetMidY(cellNode.frame))
                spriteNode.size = CGSizeMake(xSpacing, ySpacing)
                spriteNode.name = "cell " + cell.key()
                //self.addChild(spriteNode)
                cellNode.addChild(spriteNode)

                
                
                
                /* Draw just the spaceship node */
//                let cellNode = SKSpriteNode(imageNamed: "Spaceship")
//                cellNode.position = CGPointMake(CGFloat(cell.x) * xSpacing + xSpacing / 2.0, CGFloat(cell.y) * ySpacing + ySpacing / 2.0)
//                cellNode.size = CGSizeMake(xSpacing, ySpacing)
//                cellNode.name = "cell " + cell.key()
//                self.addChild(cellNode)
//                cellNodes.append(cellNode)
                
            }
        }
    }
    
}
