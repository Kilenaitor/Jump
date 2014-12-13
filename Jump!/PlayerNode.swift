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
    
    let player = SKSpriteNode(imageNamed: "Circle.png")
    private var height :CGFloat = 0

    override init() {
        super.init()
        name = "Player"
        initPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    private func initPhysicsBody() {
        
        player.name = "Player"
        player.zRotation = CGFloat(M_PI)
        player.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Circle.png"), size: player.size)
        player.physicsBody?.dynamic = false
        player.physicsBody?.linearDamping = 0.0
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.categoryBitMask = PlayerCategory
        player.physicsBody?.contactTestBitMask = FloorCategory | MidCategory
        player.physicsBody?.collisionBitMask = SideCategory | MidCategory
        player.physicsBody?.restitution = 0.0
        player.physicsBody?.friction = 1.0
        self.addChild(player)
    }
    
    internal func jump(location: CGPoint, right: Bool) {
        player.physicsBody!.velocity = CGVectorMake(0,0)
        right ?
            player.physicsBody!.applyImpulse(CGVectorMake(CGFloat(-3), CGFloat(15))) :
            player.physicsBody!.applyImpulse(CGVectorMake(CGFloat(3), CGFloat(15)))
    }
    
    internal func activate() {
        player.physicsBody?.dynamic = true
    }
    
    internal func wall() {
        player.physicsBody!.velocity = CGVectorMake(0,0)
    }
    
    internal func mid() {
        let old = player.physicsBody!.velocity
        player.physicsBody!.velocity = CGVectorMake(old.dx, 0)
    }
    
    internal func getHeight() -> CGFloat {
        return player.position.y*0.1 + UIScreen.mainScreen().bounds.height/2*0.75
    }
}
