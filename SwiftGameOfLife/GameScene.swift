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
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    private func drawScene() {
        for gridLine in gridLineNodes{
            gridLine.removeFromParent()
        }

        for cellNode in cellNodes{
            cellNode.removeFromParent()
        }

        drawCells()
        drawGrid()
    }
    
    
    private func drawGrid() {
        
        
        let ySpacing: CGFloat = CGFloat(frame.size.height / CGFloat(yCells))
        for y in 0...yCells{
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 0, CGFloat(y) * ySpacing)
            CGPathAddLineToPoint(path, nil, frame.size.width, CGFloat(y) * ySpacing)
            let line = SKShapeNode(path: path)
            line.strokeColor = UIColor.greenColor()
            self.addChild(line)
            gridLineNodes.append(line)
        }
        
        let xSpacing: CGFloat = CGFloat(frame.size.width / CGFloat(xCells))
        for x in 0...xCells{
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, CGFloat(x) * xSpacing, 0)
            CGPathAddLineToPoint(path, nil, CGFloat(x) * xSpacing, frame.size.height)
            let line = SKShapeNode(path: path)
            line.strokeColor = UIColor.greenColor()
            self.addChild(line)
            gridLineNodes.append(line)
        }
    }
    
    private func drawCells(){
        let ySpacing: CGFloat = CGFloat(frame.size.height / CGFloat(yCells))
        let xSpacing: CGFloat = CGFloat(frame.size.width / CGFloat(xCells))
        for cell: Cell in (game?.currentGeneration.livingCells)!.values {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, CGFloat(cell.x) * xSpacing, CGFloat(cell.y) * ySpacing)
            CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing + xSpacing, CGFloat(cell.y) * ySpacing)
            CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing + xSpacing, CGFloat(cell.y) * ySpacing + ySpacing)
            CGPathAddLineToPoint(path, nil, CGFloat(cell.x) * xSpacing, CGFloat(cell.y) * ySpacing + ySpacing)
            let cellNode = SKShapeNode(path: path)
            cellNode.fillColor = UIColor.redColor()
            self.addChild(cellNode)
            cellNodes.append(cellNode)
            
        }
    }
    
}
