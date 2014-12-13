//
//  GameOver.Swift
//  Jump!
//
//  Created by Kyle Minshall on 12/12/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    class func scene(size:CGSize) -> StartScene {
        return StartScene(size: size)
    }
    
    init(size: CGSize, scoreNum: Int) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        let over = SKLabelNode(fontNamed: "Helvetica")
        over.fontColor = SKColor.redColor()
        over.fontSize = 40
        over.text = "Game Over"
        over.position = CGPointMake(frame.size.width/2, frame.size.height*2/3)
        
        addChild(over)
        
        let score = SKLabelNode(fontNamed: "Helvetica")
        score.fontColor = SKColor.blackColor()
        score.fontSize = 32
        score.text = "Score: \(scoreNum)"
        score.position = CGPointMake(frame.size.width/2, frame.size.height*2/3 - 50)
        
        addChild(score)
        
        let play = playButton()
        play.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        play.zPosition = 1
        
        let text = SKLabelNode(fontNamed: "Helvetica")
        text.fontSize = 32
        text.fontColor = SKColor.whiteColor()
        text.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        text.zPosition = 2
        text.text = "Play Again"
        
        let button = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(-100, -15, 200, 50), 10, 10, nil))
        button.position = CGPointMake(frame.size.width/2, frame.size.height/2 - 75)
        button.fillColor = SKColor.blueColor()
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            if CGRectContainsPoint(CGRectMake(frame.size.width/2, frame.size.height/2, 200, 50), location) {
                let nextLevel = GameScene(size: frame.size)
                view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
            }
            
            let node = nodeAtPoint(location)
            if node.name == "home" {
                let nextLevel = StartScene(size: frame.size)
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
            button.name = "start"
            
            addChild(button)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
}
