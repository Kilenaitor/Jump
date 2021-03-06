//
//  GameOver.Swift
//  Jump!
//
//  Created by Kyle Minshall on 12/12/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit
import GameKit

class GameOver: SKScene {
    
    var diff = 0
    var gameCenter: String = ""
    var sub: Int = 0
    
    class func scene(size:CGSize) -> StartScene {
        return StartScene(size: size)
    }
    
    init(size: CGSize, scoreNum: Int, level: Int, gc: String) {
        
        super.init(size: size)
        
        gameCenter = gc
        
        diff = level
        
        sub = scoreNum
        
        backgroundColor = SKColor.whiteColor()
        
        reportScore(scoreNum)
        
        var prevHigh = 0
        if(NSUserDefaults.standardUserDefaults().integerForKey("HighScore\(level)") != 0) {
            prevHigh = NSUserDefaults.standardUserDefaults().integerForKey("HighScore\(level)")
        }
        
        if scoreNum > prevHigh {
            NSUserDefaults.standardUserDefaults().setInteger(scoreNum, forKey:"HighScore\(level)")
            prevHigh = scoreNum
        }
        
        
        let over = SKLabelNode(fontNamed: "Helvetica-Bold")
        over.fontColor = SKColor.redColor()
        over.fontSize = 45
        over.text = "Game Over"
        over.position = CGPointMake(frame.size.width/2, frame.size.height - 100)
        
        addChild(over)
        
        let score = SKLabelNode(fontNamed: "Helvetica")
        score.fontColor = SKColor.blackColor()
        score.fontSize = 32
        score.text = "Score: \(scoreNum)"
        score.position = CGPointMake(frame.size.width/2, frame.size.height - 150)
        
        addChild(score)
        
        let highscore = SKLabelNode(fontNamed: "Helvetica")
        highscore.fontColor = SKColor.blackColor()
        highscore.fontSize = 32
        highscore.text = "High Score: \(prevHigh)"
        highscore.position = CGPointMake(frame.size.width/2, frame.size.height - 200)
        
        addChild(highscore)
        
        let play = playButton()
        play.position = CGPointMake(frame.size.width/2, frame.size.height - 350)
        play.zPosition = 1
        play.name = "play"
        
        let text = SKLabelNode(fontNamed: "Helvetica")
        text.fontSize = 32
        text.fontColor = SKColor.whiteColor()
        text.position = CGPointMake(frame.size.width/2, frame.size.height - 350)
        text.zPosition = 2
        text.text = "Play Again"
        text.name = "play"
        
        let button = SKShapeNode(path: CGPathCreateWithRect(CGRectMake(-100, -15, 200, 50), nil))
        button.fillColor = SKColor(red:0.09, green:0.51, blue:0.98, alpha:1)
        button.position = CGPointMake(frame.size.width/2, frame.size.height - 425)
        button.name = "home"
        
        let home = SKLabelNode(fontNamed: "Helvetica")
        home.fontSize = 32
        home.fontColor = SKColor.whiteColor()
        home.position = button.position
        home.zPosition = 2
        home.text = "Go Home"
        home.name = "home"
        
        addChild(play)
        addChild(text)
        addChild(button)
        addChild(home)
    }
    
    func reportScore(score: Int) {
        var score = GKScore(leaderboardIdentifier: gameCenter)
        score.value = Int64(sub)
        
        GKScore.reportScores([score], {(error : NSError!) -> Void in
            if error != nil {
                NSLog(error.localizedDescription)
            }
        })
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
            if node.name == "home" {
                let nextLevel = StartScene(size: frame.size)
                view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
            }
            if node.name == "play" {
                switch diff {
                    
                case 0:
                    let nextLevel = EasyGameScene(size: frame.size);
                    view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5)); break
                case 1:
                    let nextLevel = MedGameScene(size: frame.size);
                    view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5)); break
                case 2:
                    let nextLevel = HardGameScene(size: frame.size);
                    view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5)); break
                default:
                    let nextLevel = EasyGameScene(size: frame.size);
                    view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5)); break
                }
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    class playButton: SKNode {
        
        override init() {
            super.init()
            
            let button = SKShapeNode(path: CGPathCreateWithRect(CGRectMake(-100, -15, 200, 50), nil))
            button.fillColor = SKColor(red:0.144, green:0.8, blue:0.381, alpha:1)
            button.name = "start"
            
            addChild(button)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
}
