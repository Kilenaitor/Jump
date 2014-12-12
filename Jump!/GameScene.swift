//
//  GameScene.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/11/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private var finished = false
    private let playerNode: PlayerNode = PlayerNode()
    
    class func scene(size:CGSize) -> GameScene {
        return GameScene(size: size)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        let level = SKLabelNode(fontNamed: "Courier")
        level.fontColor = SKColor.blackColor()
        level.fontSize = 26
        level.text = "Easy"
        level.verticalAlignmentMode = .Top
        level.horizontalAlignmentMode = .Right
        level.position = CGPointMake(frame.size.width, frame.size.height)
        
        addChild(level)
        
        playerNode.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) * 0.75)
        playerNode.setScale(0.1)
        
        addChild(playerNode)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            if location.y < CGRectGetHeight(frame) * 0.5 {
                let target = CGPointMake(location.x, playerNode.position.y)
                playerNode.moveToward(target)
            }
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {

    }
}
