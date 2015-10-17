//
//  SpriteViewController.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 10/17/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import SpriteKit

class SpriteViewController: UIViewController {

    var skView: SKView? = nil
    var gameScene: GameScene? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpriteView()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    func setupSpriteView(){
        if(skView == nil){
            skView = SKView(frame: view.bounds)
            skView?.showsFPS = true
            skView?.showsNodeCount = true
            skView?.ignoresSiblingOrder = true
            view.addSubview(self.skView!)
            if let scene = GameScene(fileNamed:"GameScene") {
                scene.scaleMode = .ResizeFill
                gameScene = scene
                skView?.presentScene(gameScene)
            }
        }
    }
}
