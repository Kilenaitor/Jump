//
//  StartScene.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/11/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    
    class func scene(size:CGSize) -> StartScene {
        return StartScene(size: size)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        let over = SKLabelNode(fontNamed: "Helvetica")
        over.fontColor = SKColor.blackColor()
        over.fontSize = 40
        over.text = "Jump!"
        over.position = CGPointMake(frame.size.width/2, frame.size.height*2/3)
        
        addChild(over)
        
        let play = playButton()
        play.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        play.zPosition = 1
        play.name = "play"
        
        let text = SKLabelNode(fontNamed: "Helvetica")
        text.fontSize = 32
        text.fontColor = SKColor.whiteColor()
        text.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        text.zPosition = 2
        text.text = "Play"
        text.name = "play"
        
        addChild(play)
        addChild(text)
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
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    class playButton: SKNode {
        
        override init() {
            super.init()
            
            let button = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(-100, -15, 200, 50), 10, 10, nil))
            button.fillColor = SKColor.greenColor()
            button.name = "play"
            
            addChild(button)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
}
