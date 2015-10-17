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

    var skView: SKView? = nil
    
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var settingsBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var showButtonBottomLayoutConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpriteView()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SegueSetupToGame"){
            let vc = segue.destinationViewController as? GameViewController
            vc?.game = sender as? Game
        }
    }
    
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
            view.bringSubviewToFront(settingsView)
            view.bringSubviewToFront(showButton)
        }
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

    @IBAction func startButtonTouchUpInside(sender: AnyObject) {
        
        // draw a vertical line
        var cells = Dictionary<String, Cell>()
        let cell0 = Cell(x: 1, y: 1);
        let cell1 = Cell(x: 1, y: 2);
        let cell2 = Cell(x: 1, y: 3);
        cells[cell0.key()] = cell0
        cells[cell1.key()] = cell1
        cells[cell2.key()] = cell2
        let generation = Generation(width: 5, height: 5, livingCells: cells)
        let game = Game(width: 5, height: 5, currentGeneration: generation)
        
        performSegueWithIdentifier("SegueSetupToGame", sender: game)
    }
}
