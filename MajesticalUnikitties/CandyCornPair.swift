//
//  CandyCornSprite.swift
//  MajesticalUnikitties
//
//  Created by Julie on 1/15/17.
//  Copyright © 2017 Julie. All rights reserved.
//
//var rand = CGFloat(Double(arc4random())/Double(UINT32_MAX))

import Foundation
import SpriteKit
import GameplayKit

class CandyCornPair: SKNode {
    private var size : CGSize
    private var ccWidth : CGFloat
    
    init(scene: SKScene, start: CGPoint, ccWidth: CGFloat) {
        size = CGSize(width: ccWidth, height: scene.size.height)
        self.ccWidth = ccWidth
        super.init()
        position = start

        let ccTexture = SKTexture(imageNamed: "CandyCorn")
        let bottomHeight = CGFloat(arc4random() % 4 + 1)
        
        let spriteBottom = SKSpriteNode(texture: ccTexture, color: .clear, size: CGSize(width: ccWidth, height: bottomHeight*size.height/7))
        spriteBottom.position = CGPoint(x: 0, y: -size.height/2 + spriteBottom.size.height/2)
        spriteBottom.physicsBody = SKPhysicsBody(texture: ccTexture, size: spriteBottom.size)
        spriteBottom.physicsBody?.categoryBitMask = PhysicsCategory.CandyCornCategory
        spriteBottom.physicsBody?.collisionBitMask = PhysicsCategory.UniKittyCategory
        spriteBottom.physicsBody?.contactTestBitMask = PhysicsCategory.UniKittyCategory
        spriteBottom.physicsBody?.affectedByGravity = false
        spriteBottom.physicsBody?.isDynamic = false
        addChild(spriteBottom)
        
        let spriteTop = SKSpriteNode(texture: ccTexture, color: .clear, size: CGSize(width: ccWidth, height: (5-bottomHeight)*size.height/7))
        spriteTop.zRotation = .pi
        spriteTop.position = CGPoint(x: 0, y: size.height/2 - spriteTop.size.height/2)
        spriteTop.physicsBody = SKPhysicsBody(texture: ccTexture, size: spriteTop.size)
        spriteTop.physicsBody?.categoryBitMask = PhysicsCategory.CandyCornCategory
        spriteTop.physicsBody?.collisionBitMask = PhysicsCategory.UniKittyCategory
        spriteTop.physicsBody?.contactTestBitMask = PhysicsCategory.UniKittyCategory
        spriteTop.physicsBody?.affectedByGravity = false
        spriteTop.physicsBody?.isDynamic = false
        addChild(spriteTop)
    }
    
    required init?(coder aDecoder: NSCoder) {
        size = CGSize(width: 0, height: 0)
        self.ccWidth = 100
        super.init(coder: aDecoder)
    }
    
    func isOffScreen() -> Bool {
        return position.x < -ccWidth/2
    }
    
    func move() {
        position.x -= 3
    }
}
