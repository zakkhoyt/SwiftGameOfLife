//
//  GameViewController.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 10/17/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var skView: SKView? = nil
    var game: Game? = nil {
        didSet{
            print("game has been passed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpriteView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK Private methods
    func setupSpriteView(){
        if(skView == nil){
            skView = SKView(frame: view.bounds)
            skView?.showsFPS = true
            skView?.showsNodeCount = true
            skView?.ignoresSiblingOrder = true
            view.addSubview(self.skView!)
            let scene = GameScene()
            scene.scaleMode = .AspectFill
            skView?.presentScene(scene)
        }
    }
}
