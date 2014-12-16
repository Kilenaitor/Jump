//
//  MedGameScene.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/15/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit
import iAd

class MedGameScene: SKScene, SKPhysicsContactDelegate {
    
    private var world = SKNode()
    private var startHeight:CGFloat = 0
    private var newHeight:CGFloat = 0
    private var viewNode = SKNode()
    private var height: CGFloat = 0
    private var firsttap = true
    private var finished = false
    private var scoreNum = 0
    private let playerNode: PlayerNode = PlayerNode(diff: 1)
    private let floor: WallNode = WallNode()
    private let left: SideNode = SideNode()
    private let right: SideNode = SideNode()
    private let pair = SKNode()
    private var oldy: CGFloat = 0
    private let score = SKLabelNode(fontNamed: "Helvetica")
    private var num = 0
    
    class func scene(size:CGSize) -> MedGameScene {
        return MedGameScene(size: size)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        addChild(world)
        
        setupPhysics()
        setupWalls()
        world.addChild(viewNode)
        
        backgroundColor = SKColor.whiteColor()
        
        score.fontColor = SKColor.blackColor()
        score.fontSize = 32
        score.text = "\(scoreNum)"
        score.verticalAlignmentMode = .Top
        score.horizontalAlignmentMode = .Right
        score.position = CGPointMake(frame.size.width - 5, frame.size.height - 5)
        
        addChild(score)
        
        playerNode.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) * 0.75)
        playerNode.setScale(0.1)
        
        world.addChild(playerNode)
        newHeight = CGRectGetMidY(frame)
        startHeight = CGRectGetMidY(frame)
        oldy = CGRectGetMidY(frame) * 0.75 - 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        if -playerNode.getHeight() + newHeight < world.position.y {
            world.position = CGPointMake(world.position.x, -playerNode.getHeight() + newHeight)
        }
        
        if(oldy - playerNode.getHeight() < 500) {
            addObstacles()
        }
        
        for children in viewNode.children {
            let z = scoreNum - 2
            if(children as SKNode).name == "pair\(z)" {
                children.removeFromParent()
            }
        }
    }
    
    
    func setupPhysics() {
        physicsWorld.gravity = CGVectorMake(0.0, -9.8);
        physicsWorld.contactDelegate = self;
        physicsWorld.speed = 1.0
    }
    
    func setupWalls() {
        floor.position = CGPointMake(CGRectGetMidX(frame), -11)
        left.position = CGPointMake(-11, CGRectGetMidY(frame))
        right.position = CGPointMake(CGRectGetMaxX(frame) + 11, CGRectGetMidY(frame))
        addChild(floor)
        addChild(left)
        addChild(right)
    }
    
    func gameOver() {
        let nextLevel = GameOver(size: frame.size, scoreNum: scoreNum, level: 1)
        view!.presentScene(nextLevel, transition:SKTransition.fadeWithDuration(1))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == FloorCategory || secondBody.categoryBitMask == FloorCategory {
            gameOver()
        }
        
        if firstBody.categoryBitMask == ObstacleCategory || secondBody.categoryBitMask == ObstacleCategory {
            gameOver()
        }
        
        if firstBody.categoryBitMask == SideCategory || secondBody.categoryBitMask == SideCategory {
            playerNode.wall()
        }
        
        if secondBody.categoryBitMask & ScoreCategory == ScoreCategory && secondBody.node?.parent != nil{
            scoreNum++
            score.text = "\(scoreNum)"
            secondBody.node?.removeFromParent()
        }
    }
    
    func addObstacles() {
        let pipePair = SKNode()
        pipePair.position = CGPointMake(0, oldy + 400)
        oldy += 400
        pipePair.name = "pair\(num++)"
        pipePair.zPosition = -10
        
        let y = arc4random() % UInt32((frame.size.width / 2))
        
        
        let side1 = SKSpriteNode(color: SKColor.blueColor(), size: CGSizeMake(frame.size.width, 40))
        side1.position = CGPointMake(CGFloat(y) - 140, 0)
        side1.physicsBody = SKPhysicsBody(rectangleOfSize: side1.size)
        side1.physicsBody?.categoryBitMask = ObstacleCategory
        side1.physicsBody?.dynamic = false
        pipePair.addChild(side1)
        
        let side2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSizeMake(frame.size.width, 40))
        side2.position = CGPointMake(side1.position.x + side1.size.width + 130, 0)
        side2.physicsBody = SKPhysicsBody(rectangleOfSize: side2.size)
        side2.physicsBody?.dynamic = false
        side2.physicsBody?.categoryBitMask = ObstacleCategory
        pipePair.addChild(side2)
        
        if(pipePair.name != "pair0") {
            
            let r = arc4random() % 4
            let block1 = SKSpriteNode(color: SKColor.blueColor(), size: CGSizeMake(30,30))
            block1.position = CGPointMake(side1.position.x + side1.size.width/2 + CGFloat((r+1)*30), side1.position.y - 115)
            block1.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
            block1.physicsBody?.dynamic = false
            block1.physicsBody?.categoryBitMask = ObstacleCategory
            pipePair.addChild(block1)
        }
        
        let r2 = arc4random() % 4
        let block2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSizeMake(30,30))
        block2.position = CGPointMake(side1.position.x + side1.size.width/2 + CGFloat((r2+1)*30), side1.position.y + 115)
        block2.physicsBody = SKPhysicsBody(rectangleOfSize: block2.size)
        block2.physicsBody?.dynamic = false
        block2.physicsBody?.categoryBitMask = ObstacleCategory
        pipePair.addChild(block2)
        
        let contact = SKNode()
        contact.position = CGPointMake(0, side1.size.height)
        contact.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(frame.size.width*2, side1.size.height))
        contact.physicsBody?.dynamic = false
        contact.physicsBody?.categoryBitMask = ScoreCategory
        pipePair.addChild(contact)
        
        viewNode.addChild(pipePair)
    }
}










