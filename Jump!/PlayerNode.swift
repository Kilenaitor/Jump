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
    override init() {
        super.init()
        name = "Player"
        initNodeGraph()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    private func initNodeGraph() {
        let player = SKSpriteNode(imageNamed: "Circle.png")
        player.name = "Player"
        player.zRotation = CGFloat(M_PI)
        self.addChild(player)
    }
    
    private func moveToward(location: CGPoint) {
        removeActionForKey("movement")
        let distance = pointDistance(position, location)
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let duration = NSTimeInterval(2 * distance/screenWidth)
        
        runAction(SKAction.moveTo(location, duration: duration), withKey:"movement")
    }
}
