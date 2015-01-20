//
//  SelectScene.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/15/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit

class SelectScene: SKScene {
    
    class func scene(size:CGSize) -> SelectScene {
        return SelectScene(size: size)
    }
    
    var unlock_medium: Bool = false
    var unlock_hard: Bool = false
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        if( NSUserDefaults.standardUserDefaults().integerForKey("HighScore0") >= 50 ) {
            unlock_medium = true
        }
        
        if( NSUserDefaults.standardUserDefaults().integerForKey("HighScore1") >= 30 ) {
            unlock_hard = true
        }
        
        backgroundColor = SKColor.whiteColor()
        
        let over = SKLabelNode(fontNamed: "Helvetica")
        over.fontColor = SKColor.blackColor()
        over.fontSize = 40
        over.text = "Difficulty:"
        over.position = CGPointMake(frame.size.width/2, frame.size.height*2/3)
        
        addChild(over)
        
        let easy = playButton()
        easy.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        easy.zPosition = 1
        easy.name = "easy"
        
        let text = SKLabelNode(fontNamed: "Helvetica")
        text.fontSize = 32
        text.fontColor = SKColor.whiteColor()
        text.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        text.zPosition = 2
        text.text = "Easy"
        text.name = "easy"
        
        addChild(easy)
        addChild(text)
        
        let medium = playMedButton()
        if(!unlock_medium) {
            medium.getButton().fillColor = SKColor(red:0.892, green:0.888, blue:0.884, alpha:1)
        }
        medium.position = CGPointMake(frame.size.width/2, frame.size.height/2 - 75)
        medium.zPosition = 1
        medium.name = "med"
        
        let text2 = SKLabelNode(fontNamed: "Helvetica")
        text2.fontSize = 32
        text2.fontColor = SKColor.whiteColor()
        text2.position = medium.position
        text2.zPosition = 2
        text2.text = "Medium"
        text2.name = "med"
        
        addChild(medium)
        addChild(text2)
        
        let hard = playHardButton()
        if(!unlock_hard) {
            hard.getButton().fillColor = SKColor(red:0.892, green:0.888, blue:0.884, alpha:1)
        }
        hard.position = CGPointMake(frame.size.width/2, frame.size.height/2-150)
        hard.zPosition = 1
        hard.name = "hard"
        
        let text3 = SKLabelNode(fontNamed: "Helvetica")
        text3.fontSize = 32
        text3.fontColor = SKColor.whiteColor()
        text3.position = hard.position
        text3.zPosition = 2
        text3.text = "Hard"
        text3.name = "hard"
        
        addChild(hard)
        addChild(text3)
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
            
            if node.name == "easy" {
                let nextLevel = EasyGameScene(size: frame.size)
                view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
            }
            if node.name == "med" {
                if(!unlock_medium) {
                    var alert = UIAlertView(title: "Whoops", message: "You have to score at least 50 in Easy before you can play Medium", delegate: self, cancelButtonTitle: "Okay")
                    alert.show()
                } else {
                    let nextLevel = MedGameScene(size: frame.size)
                    view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
                }
            }
            if node.name == "hard" {
                if(!unlock_hard) {
                    var alert = UIAlertView(title: "Whoops", message: "You have to score at least 30 in Medium before you can play Hard", delegate: self, cancelButtonTitle: "Okay")
                    alert.show()
                } else {
                    let nextLevel = HardGameScene(size: frame.size)
                    view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
                }
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    class playButton: SKNode {
        
        let button = SKShapeNode(path: CGPathCreateWithRect(CGRectMake(-100, -15, 200, 50), nil))
        
        override init() {
            super.init()
            
            button.fillColor = SKColor(red:0.144, green:0.8, blue:0.381, alpha:1)
            button.name="easy"
            
            addChild(button)
        }
        
        func getButton() -> SKShapeNode {
            return button;
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    class playMedButton: SKNode {
        
        let button = SKShapeNode(path: CGPathCreateWithRect(CGRectMake(-100, -15, 200, 50), nil))
        
        override init() {
            
            super.init()
            
            button.fillColor = SKColor(red:0.09, green:0.51, blue:0.98, alpha:1)
            button.name="med"
            addChild(button)
        }
        
        func getButton() -> SKShapeNode {
            return button;
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    class playHardButton: SKNode {
        
        let button = SKShapeNode(path: CGPathCreateWithRect(CGRectMake(-100, -15, 200, 50), nil))
        
        override init() {
            super.init()
            
            button.fillColor = SKColor(red:0.98, green:0.26, blue:0.29, alpha:1)
            button.name="hard"
            addChild(button)
        }
        
        func getButton() -> SKShapeNode {
            return button;
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
}
