//
//  WallNode.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/12/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class WallNode: SKNode {
    
    let floor = SKSpriteNode(color: SKColor.blackColor(), size: CGSizeMake(UIScreen.mainScreen().bounds.size.width, 20))
    
    override init() {
        super.init()
        name = "Wall"
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(UIScreen.mainScreen().bounds.size.width, 20))
        floor.physicsBody?.dynamic = false
        floor.physicsBody?.categoryBitMask = FloorCategory
        floor.physicsBody?.collisionBitMask = PlayerCategory
        floor.physicsBody?.mass = 100
        floor.physicsBody?.restitution = 1.0
        self.addChild(floor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
}