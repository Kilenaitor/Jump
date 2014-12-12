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
    private let floor: WallNode = WallNode()
    private let left: SideNode = SideNode()
    private let right: SideNode = SideNode()
    
    class func scene(size:CGSize) -> GameScene {
        return GameScene(size: size)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        setupPhysics()
        setupWalls()
        
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
   
    override func update(currentTime: NSTimeInterval) {

    }
    
    
    func setupPhysics() {
        physicsWorld.gravity = CGVectorMake(0.0, -5);
        physicsWorld.contactDelegate = self;
        physicsWorld.speed = 1.0
    }
    
    func setupWalls() {
        floor.position = CGPointMake(CGRectGetMidX(frame), -20)
        left.position = CGPointMake(-20, CGRectGetMidY(frame))
        right.position = CGPointMake(CGRectGetMaxX(frame) + 20, CGRectGetMidY(frame))
        addChild(floor)
        addChild(left)
        addChild(right)
    }
    
    func gameOver() {
        let nextLevel = StartScene(size: frame.size)
        view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(0.5))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {

        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == FloorCategory || secondBody.categoryBitMask == FloorCategory {
            gameOver()
        }
    }
}
