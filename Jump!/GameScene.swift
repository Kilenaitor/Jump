//
//  GameScene.swift
//  Jump!
//
//  Created by Kyle Minshall on 12/11/14.
//  Copyright (c) 2014 tmg. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var world = SKNode()
    private var startHeight:CGFloat = 0
    private var newHeight:CGFloat = 0
    private var viewNode = SKNode()
    private var height: CGFloat = 0
    private var firsttap = true
    private var finished = false
    private var scoreNum = 0
    private let playerNode: PlayerNode = PlayerNode()
    private let floor: WallNode = WallNode()
    private let left: SideNode = SideNode()
    private let right: SideNode = SideNode()
    private let pair = SKNode()
    
    class func scene(size:CGSize) -> GameScene {
        return GameScene(size: size)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        addChild(world)
        
        setupPhysics()
        setupWalls()
        setupObstacles()
        
        backgroundColor = SKColor.whiteColor()
        
        let score = SKLabelNode(fontNamed: "Helvetica")
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
        world.addChild(viewNode)
        newHeight = CGRectGetMidY(frame)
        startHeight = CGRectGetMidY(frame)
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
        if playerNode.getHeight() > world.frame.height/2 && -playerNode.getHeight() + newHeight < world.position.y {
            world.position = CGPointMake(world.position.x, -playerNode.getHeight() + newHeight)
        }
    }
    
    
    func setupPhysics() {
        physicsWorld.gravity = CGVectorMake(0.0, -5);
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
    
    func setupObstacles() {
        pair.position = CGPointMake(0, frame.size.height - 100)
        
        let y = arc4random() % UInt32((frame.size.width / 3))
        
        let side1 = SKSpriteNode(color: SKColor.blackColor(), size: CGSizeMake(frame.size.width, 40))
        side1.position = CGPointMake(0, CGFloat(y))
        side1.physicsBody = SKPhysicsBody(rectangleOfSize: side1.size)
        side1.physicsBody?.categoryBitMask = ObstacleCategory
        side1.physicsBody?.dynamic = false
        pair.addChild(side1)
        
        let side2 = SKSpriteNode(color: SKColor.blackColor(), size: CGSizeMake(frame.size.width, 40))
        side2.position = CGPointMake(side1.size.width + 100, CGFloat(y))
        side2.physicsBody = SKPhysicsBody(rectangleOfSize: side2.size)
        side2.physicsBody?.dynamic = false
        side2.physicsBody?.categoryBitMask = ObstacleCategory
        pair.addChild(side2)
        viewNode.addChild(pair)
    }
    
    func gameOver() {
        let nextLevel = GameOver(size: frame.size, scoreNum: scoreNum)
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
        
        if firstBody.categoryBitMask == ObstacleCategory || secondBody.categoryBitMask == ObstacleCategory {
            gameOver()
        }
        
        if firstBody.categoryBitMask == SideCategory || secondBody.categoryBitMask == SideCategory {
            playerNode.wall()
        }
    }
}










