//
//  StartScene.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/11/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit
import GameKit

class StartScene: SKScene, GKGameCenterControllerDelegate {
    
    class func scene(size:CGSize) -> StartScene {
        return StartScene(size: size)
    }
    
    var gameCenter: String = ""
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        let over = SKLabelNode(fontNamed: "Helvetica-Bold")
        over.fontColor = SKColor.blackColor()
        over.fontSize = 52
        over.text = "Jump!"
        over.position = CGPointMake(frame.size.width/2, frame.size.height*2/3)
        
        addChild(over)
        
        let play = playButton()
        play.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        play.zPosition = 1
        play.name = "play"
        
        let text = SKLabelNode(fontNamed: "Helvetica")
        text.fontSize = 34
        text.fontColor = SKColor.whiteColor()
        text.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        text.zPosition = 2
        text.text = "Play"
        text.name = "play"
        
        addChild(play)
        addChild(text)
        
        let score = scoreButton()
        score.position = CGPointMake(frame.size.width/2, frame.size.height/2 - 75)
        score.zPosition = 1
        score.name = "score"
        
        let text2 = SKLabelNode(fontNamed: "Helvetica")
        text2.fontSize = 34
        text2.fontColor = SKColor.whiteColor()
        text2.position = score.position
        text2.zPosition = 2
        text2.text = "Scores"
        text2.name = "score"
        
        addChild(score)
        addChild(text2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            if node.name == "play" {
                let nextLevel = SelectScene(size: frame.size)
                view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
            }
            if node.name == "score" {
                showScores()
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    func showScores() {
        var vc = self.view?.window?.rootViewController
        var gcViewController: GKGameCenterViewController = GKGameCenterViewController()
        gcViewController.gameCenterDelegate = self
        
        gcViewController.viewState = GKGameCenterViewControllerState.Leaderboards
        gcViewController.leaderboardIdentifier = gameCenter
        
        vc?.presentViewController(gcViewController, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!)
    {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    class playButton: SKNode {
        
        override init() {
            super.init()
            
            let button = SKShapeNode(path: CGPathCreateWithRect(CGRectMake(-100, -15, 200, 50), nil))
            button.fillColor = SKColor(red:0.144, green:0.8, blue:0.381, alpha:1)
            button.name = "play"
            
            addChild(button)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    class scoreButton: SKNode {
        
        override init() {
            super.init()
            
            let button = SKShapeNode(path: CGPathCreateWithRect(CGRectMake(-100, -15, 200, 50), nil))
            button.fillColor = SKColor(red:0.31, green:0.74, blue:0.95, alpha:1)
            button.name = "score"
            
            addChild(button)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
}
