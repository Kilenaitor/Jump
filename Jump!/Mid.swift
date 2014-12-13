//
//  Mid.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/12/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class Mid: SKNode {
    
    let mid = SKSpriteNode(
        color: SKColor.clearColor(),
        size: CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    
    override init() {
        super.init()
        name = "Mid"
        mid.physicsBody =
            SKPhysicsBody(rectangleOfSize:
                CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        mid.physicsBody?.dynamic = false
        mid.physicsBody?.friction = 0.0
        mid.physicsBody?.categoryBitMask = MidCategory
        mid.physicsBody?.restitution = 0.0
        addChild(mid)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
}