//
//  SetupViewController.swift
//  SwiftGameOfLife
//
//  Created by Zakk Hoyt on 7/19/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import SpriteKit

class SetupViewController: SpriteViewController {

//    var setupCompletionHandler:((Game)->Void)!
    
    var game: Game? = nil
    
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var settingsBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var showButtonBottomLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(settingsView)
        view.bringSubviewToFront(showButton)
        setupGame()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SegueSetupToGame"){
            let vc = segue.destinationViewController as? GameViewController
            vc?.game = sender as? Game
        } else {
            print("other segue")
        }
    }
    
    // MARK Private methods
    func setupGame() {
        // draw a vertical line
        var cells = Dictionary<String, Cell>()
        let cell0 = Cell(x: 1, y: 1);
        let cell1 = Cell(x: 1, y: 2);
        let cell2 = Cell(x: 1, y: 3);
        cells[cell0.key()] = cell0
        cells[cell1.key()] = cell1
        cells[cell2.key()] = cell2
        
        // A 2x2 square
        //        let cell0 = Cell(x: 1, y: 1);
        //        let cell1 = Cell(x: 1, y: 2);
        //        let cell2 = Cell(x: 2, y: 1);
        //        let cell3 = Cell(x: 2, y: 2);
        //        cells[cell0.key()] = cell0
        //        cells[cell1.key()] = cell1
        //        cells[cell2.key()] = cell2
        //        cells[cell3.key()] = cell3
        
        let width: UInt = 10
        let height = UInt(CGFloat(width) * view.bounds.size.height / view.bounds.size.width)
        let generation = Generation(width: width, height: height, livingCells: cells)
        game = Game(width: width, height: height, currentGeneration: generation)
        self.gameScene?.game = self.game
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
        performSegueWithIdentifier("SegueSetupToGame", sender: game)
    }
    
    @IBAction func densitySliderValueChanged(sender: UISlider) {
//        self.gameScene?.xCells = UInt(sender.value)
        
        let width: UInt = UInt(sender.value)
        let height = UInt(CGFloat(width) * view.bounds.size.height / view.bounds.size.width)
        self.game?.width = width
        self.game?.height = height
        self.gameScene?.game = self.game
    }
}
