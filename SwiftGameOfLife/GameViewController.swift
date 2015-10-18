//
//  GameViewController.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 10/17/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit


class GameViewController: SpriteViewController {

    var game: Game? = nil
    
    @IBOutlet weak var toolbarView: UIVisualEffectView!
    @IBOutlet weak var evolveButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScene?.game = game
        view.bringSubviewToFront(toolbarView)
    }
    
    @IBAction func backButtonTouchUpInside(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func evolveButtonTouchUpInside(sender: AnyObject) {
        game?.evolveOnceWithRenderHander({ (currentGeneration: Generation) -> Void in
            gameScene?.game = game
//            gameScene?.game = self.game
//            self.ageLabel.text = String(format: "%lu", arguments: game?.generationCounter)
        })
        
        //        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        //        dispatch_after(delayTime, dispatch_get_main_queue()) {
        //            game?.startWithRenderHander({ (currentGeneration: Generation) -> Void in
        //                gameScene?.game = game
        //            })
        //        }

    }
}
