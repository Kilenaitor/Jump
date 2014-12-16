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
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
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
                let nextLevel = MedGameScene(size: frame.size)
                view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
            }
            if node.name == "hard" {
                let nextLevel = HardGameScene(size: frame.size)
                view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    class playButton: SKNode {
        
        override init() {
            super.init()
            
            let button = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(-100, -15, 200, 50), 10, 10, nil))
            button.fillColor = SKColor.greenColor()
            
            addChild(button)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    class playMedButton: SKNode {
        
        override init() {
            super.init()
            
            let button = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(-100, -15, 200, 50), 10, 10, nil))
            button.fillColor = SKColor.blueColor()
            
            addChild(button)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    class playHardButton: SKNode {
        
        override init() {
            super.init()
            
            let button = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(-100, -15, 200, 50), 10, 10, nil))
            button.fillColor = SKColor.redColor()
            
            addChild(button)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
}
