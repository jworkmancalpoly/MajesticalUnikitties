//
//  UniKitty.swift
//  MajesticalUnikitties
//
//  Created by Julie on 1/18/17.
//  Copyright © 2017 Julie. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit
import GameplayKit

class UniKitty: SKNode {
    let ukSprite : SKSpriteNode
    
    init(scene: SKScene) {
        ukSprite = SKSpriteNode(imageNamed: "UniKittyUp")

        super.init()
        position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        
        // define sprite's characteristics
        ukSprite.zPosition = 5
        ukSprite.setScale(0.6)
        
        let ukTextures = [SKTexture(imageNamed: "UniKittyDown"),
                          SKTexture(imageNamed: "UniKitty")]
        let ukSwim = SKAction.animate(with: ukTextures, timePerFrame: 0.5)
        let ukSwimForever = SKAction.repeatForever(ukSwim)
        ukSprite.run(ukSwimForever)
        
        // define physics
        physicsBody = SKPhysicsBody(texture: ukTextures[1], size: ukSprite.size)
        physicsBody?.categoryBitMask = PhysicsCategory.UniKittyCategory
        physicsBody?.collisionBitMask = PhysicsCategory.CandyCornCategory | PhysicsCategory.GroundCategory
        physicsBody?.contactTestBitMask = PhysicsCategory.CandyCornCategory | PhysicsCategory.GroundCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = true
        
        addChild(ukSprite)
        
    }
    required init?(coder aDecoder: NSCoder) {
        ukSprite = SKSpriteNode(imageNamed: "UniKittyUp")
        super.init(coder: aDecoder)
    }
    
    func flap() {
        let ukTextures = [SKTexture(imageNamed: "UniKittyUp"),
                          SKTexture(imageNamed: "UniKitty")]
        let ukFlap = SKAction.animate(with: ukTextures, timePerFrame: 0.1)
        let ukFlapTwice = SKAction.repeat(ukFlap, count: 2)
        
        ukSprite.run(ukFlapTwice)
    }
}
