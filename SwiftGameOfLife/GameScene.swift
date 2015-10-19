//
//  GameScene.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Public variables
    var game: Game? = nil {
        didSet{
            xCells = (game?.width)!
            yCells = (game?.height)!
        }
    }
    
    // MARK: - Private variables
    private var xCells: UInt = 1{
        didSet{
            yCells = UInt(CGFloat(xCells) * self.frame.size.height / self.frame.size.width)
            print("x: \(xCells) y: \(yCells))")
            drawScene()
        }
    }
    private var yCells: UInt = 1
    
    private var gridLineNodes: [SKNode] = []
    private var cellNodes: [SKNode] = []
    
    // MARK: - Override methods

    override func didMoveToView(view: SKView) {
        setupGestures()
        showTitle()
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
                    
                    // Kill cell
                    let index = getCellIndexAtPoint(point)
                    let key = Cell.keyFor(index.x, y: index.y)
                    game?.currentGeneration.livingCells[key] = nil
                    drawScene()
                }
            }
            
            if found == false {
                let index = getCellIndexAtPoint(point)
                
                // Bring cell to life
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
    
    // MARK: - Public methods
    func drawScene() {
        // Clean up first
        for gridLine in gridLineNodes{
            //            let fadeAction = SKAction.fadeAlphaTo(0, duration: 0.3)
            //            gridLine.runAction(fadeAction, completion: { () -> Void in
            gridLine.removeFromParent()
            //            })
        }
        gridLineNodes.removeAll()
        
        for cellNode in cellNodes{
            
            let fadeAction = SKAction.fadeAlphaTo(0, duration: 0.3)
            cellNode.runAction(fadeAction, completion: { () -> Void in
                cellNode.removeFromParent()
            })
            
        }
        cellNodes.removeAll()
        
        // Draw new nodes
        drawCells()
        
        // Draw grid lines
        if game?.hideGrid == false {
            drawGrid()
        }
    }
    
    func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            print("long press. Show menu")
        }
    }

    // MARK: - Private methods
    
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
    
    private func showTitle() {
        let titleNode = SKLabelNode(fontNamed:"Chalkduster")
        titleNode.text = "Swift Game of Life";
        titleNode.fontSize = 28;
        //        titleNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        titleNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.size.height + 100);
        titleNode.alpha = 0
        self.addChild(titleNode)
        
        let fadeInAction = SKAction.fadeAlphaTo(1.0, duration: 0.5)
        let moveInAction = SKAction.moveTo(CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.size.height - 200), duration: 0.5)
        let inAction = SKAction.group([fadeInAction, moveInAction])
        inAction.timingMode = .EaseOut
        titleNode.runAction(inAction) { () -> Void in
            titleNode.runAction(SKAction.waitForDuration(5), completion: { () -> Void in
                
                let fadeOutAction = SKAction.fadeAlphaTo(0.0, duration: 0.5)
                let moveOutAction = SKAction.moveTo(CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.size.height + 200), duration: 0.5)
                let outAction = SKAction.group([fadeOutAction, moveOutAction])
                outAction.timingMode = .EaseIn
                titleNode.runAction(outAction, completion: { () -> Void in
                    titleNode.removeFromParent()
                })
            })
        }

    }
    
    private func setupGestures() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.view?.addGestureRecognizer(longPressRecognizer)
        longPressRecognizer.delegate = self
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

extension GameScene: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}