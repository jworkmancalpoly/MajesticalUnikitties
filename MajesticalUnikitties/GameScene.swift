//
//  GameScene.swift
//  MajesticalUnikitties
//
//  Created by Julie on 1/13/17.
//  Copyright © 2017 Julie. All rights reserved.
//
// Julie is bad because there is no readme

import Foundation
import SpriteKit
import GameplayKit

// from Make FlappyBird YouTube
struct PhysicsCategory {
    static let UniKittyCategory : UInt32 = 0x1 << 1
    static let CandyCornCategory : UInt32 = 0x1 << 2
    static let GroundCategory : UInt32 = 0x1 << 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var uniKitty : UniKitty?
    private var candyCorn : [CandyCornPair] = []
    private var ccWidth = CGFloat(100)
    let meow = SKAction.playSoundFileNamed("CatScream.mp3", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        backgroundColor = UIColor.cyan
        self.physicsWorld.contactDelegate = self
    
        // background scene
        let background = SKSpriteNode(imageNamed: "Rainbow")
        background.size = frame.size
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        // update the background and candyCorn size based on the screen orientation
        if UIDevice.current.orientation.isLandscape {
            ccWidth = 50
        }
        else {
            background.size.width = frame.size.width*2
            background.position = CGPoint(x: frame.maxX, y: frame.midY)
        }
        
        uniKitty = UniKitty(scene: self)
        if let uniKitty = uniKitty {
           addChild(uniKitty)
        }
    
        candyCorn = [CandyCornPair(scene: self, start: CGPoint(x: frame.maxX + ccWidth/2 , y: frame.midY), ccWidth: ccWidth),
                     CandyCornPair(scene: self, start: CGPoint(x: 3*frame.maxX/2 + ccWidth , y: frame.midY), ccWidth: ccWidth)]
        addChild(candyCorn[0])
        addChild(candyCorn[1])
        
        // define the ground
        let ground = SKSpriteNode(imageNamed: "Ground")
        ground.setScale(0.2)
        ground.size.width = frame.size.width
        ground.zPosition = 6
        ground.position = CGPoint(x: frame.width/2, y: 0 + ground.frame.height/2)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground.frame.width,
                                                               height: ground.frame.height/4))
        ground.physicsBody?.categoryBitMask = PhysicsCategory.GroundCategory
        ground.physicsBody?.collisionBitMask = PhysicsCategory.UniKittyCategory
        ground.physicsBody?.contactTestBitMask = PhysicsCategory.UniKittyCategory
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        addChild(ground)
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let uniKitty = uniKitty {
            uniKitty.flap()
            
            uniKitty.physicsBody?.affectedByGravity = true
            uniKitty.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            uniKitty.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 70))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        run(meow)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for i in 0..<candyCorn.count {
            candyCorn[i].move()
            if candyCorn[i].isOffScreen() {
                candyCorn[i].removeFromParent()
                candyCorn[i] = CandyCornPair(scene: self,
                                             start: CGPoint(x: frame.maxX + ccWidth/2 , y: frame.midY),
                                             ccWidth: ccWidth)
                addChild(candyCorn[i])
            }
        }
    }
}

