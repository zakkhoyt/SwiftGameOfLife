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
            print("game has been passed")
        }
    }
    
    var xCells: UInt32 = 1{
        didSet{
            yCells = UInt32(CGFloat(xCells) * self.frame.size.height / self.frame.size.width)
            print("x: \(xCells) y: \(yCells))")
            drawGrid()
        }
    }
    var yCells: UInt32 = 1
    
    var gridLines: [SKNode] = []

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
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
    
    
    func drawGrid() {
        for gridLine in gridLines{
            gridLine.removeFromParent()
        }
        
        let xSpacing: CGFloat = CGFloat(frame.size.width / CGFloat(xCells))
        let ySpacing: CGFloat = CGFloat(frame.size.height / CGFloat(yCells))
        
        for y in 0...yCells{
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 0, CGFloat(y) * ySpacing)
            CGPathAddLineToPoint(path, nil, frame.size.width, CGFloat(y) * ySpacing)
            let line = SKShapeNode(path: path)
            line.strokeColor = UIColor.greenColor()
            self.addChild(line)
            gridLines.append(line)
        }
        
        for x in 0...xCells{
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, CGFloat(x) * xSpacing, 0)
            CGPathAddLineToPoint(path, nil, CGFloat(x) * xSpacing, frame.size.height)
            let line = SKShapeNode(path: path)
            line.strokeColor = UIColor.greenColor()
            self.addChild(line)
            gridLines.append(line)
        }
    }
    
}
