//
//  SideNode.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/12/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class SideNode: SKNode {
    
    let wall = SKSpriteNode(color: SKColor.blackColor(), size: CGSizeMake(20, UIScreen.mainScreen().bounds.size.height))
    
    override init() {
        super.init()
        name = "Wall"
        wall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(20, UIScreen.mainScreen().bounds.size.height))
        wall.physicsBody?.dynamic = false
        wall.physicsBody?.friction = 1.0
        wall.physicsBody?.categoryBitMask = SideCategory
        wall.physicsBody?.restitution = 0.0
        addChild(wall)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
}