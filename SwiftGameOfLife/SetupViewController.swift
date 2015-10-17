//
//  SetupViewController.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import SpriteKit

class SetupViewController: UIViewController {

    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var settingsBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var showButtonBottomLayoutConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = SetupScene(fileNamed:"SetupScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK - IBActions
    @IBAction func hideButtonTouchUpInside(sender: AnyObject) {
        settingsBottomConstraint.constant = -settingsView.bounds.size.height;
        showButtonBottomLayoutConstraint.constant = 8
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func showButtonTouchUpInside(sender: AnyObject) {
        settingsBottomConstraint.constant = 0
        showButtonBottomLayoutConstraint.constant = -38
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }

}
