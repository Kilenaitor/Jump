//
//  PlayerNode.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/11/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class PlayerNode: SKNode {
    
    let player = SKShapeNode(circleOfRadius: 15)
    private var height :CGFloat = 0
    private var dif = 0

    init(diff: Int) {
        super.init()
        name = "Player"
        dif = diff
        initPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    private func initPhysicsBody() {
        
        player.name = "Player"
        player.fillColor = SKColor.blackColor()
        player.zRotation = CGFloat(M_PI)
        player.physicsBody = SKPhysicsBody(circleOfRadius:15)
        player.physicsBody?.dynamic = false
        player.physicsBody?.linearDamping = 0.0
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = PlayerCategory
        player.physicsBody?.contactTestBitMask = FloorCategory | ObstacleCategory | SideCategory | ScoreCategory
        player.physicsBody?.collisionBitMask = SideCategory
        player.physicsBody?.restitution = 0.0
        player.physicsBody?.friction = 2.0
        player.physicsBody?.mass = 0.038
        self.addChild(player)
    }
    
    internal func jump(location: CGPoint, right: Bool) {
        
        
        switch dif {
            
        case 0: player.physicsBody!.velocity = right ?
            CGVectorMake(-50, 450) :
            CGVectorMake(50, 450); break
        case 1: player.physicsBody!.velocity = right ?
            CGVectorMake(-70, 650) :
            CGVectorMake(70, 650); break
        case 2: player.physicsBody!.velocity = right ?
            CGVectorMake(-60, 550) :
            CGVectorMake(60, 550); break
        default: player.physicsBody!.velocity = right ?
            CGVectorMake(-50, 450) :
            CGVectorMake(50, 450); break
        }
    }
    
    internal func activate() {
        player.physicsBody?.dynamic = true
    }
    
    internal func wall() {
        player.physicsBody!.applyImpulse(CGVectorMake(0,5))
    }
    
    internal func mid() {
        let old = player.physicsBody!.velocity
        player.physicsBody!.velocity = CGVectorMake(old.dx, 1)
    }
    
    internal func getHeight() -> CGFloat {
        return player.position.y + UIScreen.mainScreen().bounds.height/2*0.75
    }
    
    internal func getVelocity() -> CGFloat {
        return player.physicsBody!.velocity.dy
    }
    
    internal func over() {
        player.fillColor = SKColor.redColor()
    }
}
