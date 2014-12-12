//
//  GameScene.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/11/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var firsttap = true
    private var finished = false
    private let playerNode: PlayerNode = PlayerNode()
    
    class func scene(size:CGSize) -> GameScene {
        return GameScene(size: size)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        setupPhysics()
        
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
            
            if(firsttap) {
                playerNode.activate();
                firsttap = false
            }
          
            let touchLoc = touch.locationInNode(self)
            let location = CGPointMake(playerNode.position.x, playerNode.position.y)
            var right = true
            if(touchLoc.x > CGRectGetWidth(frame) * 0.5) {
                right = false
            }
            playerNode.jump(location, right: right)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    
    func setupPhysics() {
        physicsWorld.gravity = CGVectorMake(0.0, -5);
        physicsWorld.contactDelegate = self;
        physicsWorld.speed = 1.0
    }
}
