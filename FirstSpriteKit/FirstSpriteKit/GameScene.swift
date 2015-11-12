//
//  GameScene.swift
//  FirstSpriteKit
//
//  Created by huchunbo on 15/11/12.
//  Copyright (c) 2015年 Bijiabo. All rights reserved.
//

import SpriteKit

struct MASK_COSTANT {
    static let PhySicsBody = UInt32(0b10000)
    static let Ball = UInt32(0b1)
    static let Flag = UInt32(0b10)
}

class GameScene: SKScene {
    
    var gameStarted: Bool = false
    var ball: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.whiteColor()
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        physicsBody?.contactTestBitMask = MASK_COSTANT.PhySicsBody
        physicsWorld.contactDelegate = self
        
        ball = childNodeWithName("ball") as! SKSpriteNode
        
        let flash: SKAction = SKAction.sequence([
            SKAction.fadeInWithDuration(0.2),
            SKAction.fadeOutWithDuration(0.2)
            ])
        
        ball.runAction(SKAction.repeatActionForever(flash))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if gameStarted {
            for touch in touches {
                let flagColor = UIColor(red:0.67, green:0.42, blue:0.81, alpha:1)
                let flag = SKSpriteNode(color: flagColor, size: CGSize(width: 50.0, height: 50.0))
                addChild(flag)
                flag.texture = SKTexture(image: UIImage(named: "doge")!)
                flag.physicsBody = SKPhysicsBody(circleOfRadius: flag.frame.size.width/CGFloat(2))
                flag.position = touch.locationInNode(self)
                flag.physicsBody?.contactTestBitMask = MASK_COSTANT.Flag
                flag.physicsBody?.velocity =  CGVector(dx: 0.0, dy: 500.0)
            }
        } else {
            gameStarted = true
            
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2.0)
            ball.physicsBody?.contactTestBitMask = MASK_COSTANT.Ball
            ball.physicsBody?.restitution = 0.6
        }
        
        /*
        for touch in touches {
            
            
            
            
            let myLabel = SKLabelNode(fontNamed:"Chalkduster")
            myLabel.text = "Hello, World!"
            myLabel.fontSize = 14
            myLabel.position = touch.locationInNode(self)
            myLabel.physicsBody = SKPhysicsBody(rectangleOfSize: myLabel.frame.size)
            myLabel.physicsBody?.restitution = 0.8
            self.addChild(myLabel)
        }
        */
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let flagColor = UIColor(red:0.67, green:0.42, blue:0.81, alpha:1)
            let flag = SKSpriteNode(color: flagColor, size: CGSize(width: 50.0, height: 50.0))
            addChild(flag)
            flag.texture = SKTexture(image: UIImage(named: "doge")!)
            flag.physicsBody = SKPhysicsBody(circleOfRadius: flag.frame.size.width/CGFloat(2))
            flag.position = touch.locationInNode(self)
            flag.physicsBody?.contactTestBitMask = MASK_COSTANT.Flag
            flag.physicsBody?.velocity =  CGVector(dx: 0.0, dy: 500.0)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        
        let mask_code = contact.bodyA.contactTestBitMask|contact.bodyB.contactTestBitMask
        
        switch mask_code {
        case MASK_COSTANT.Ball | MASK_COSTANT.PhySicsBody :
            break
            
        case MASK_COSTANT.Flag | MASK_COSTANT.PhySicsBody:
            if contact.bodyA.contactTestBitMask == MASK_COSTANT.Flag {
                contact.bodyA.node?.removeFromParent()
            }else if contact.bodyB.contactTestBitMask == MASK_COSTANT.Flag{
                contact.bodyB.node?.removeFromParent()
            }
            
        default:
            break
        }
        
    }
}