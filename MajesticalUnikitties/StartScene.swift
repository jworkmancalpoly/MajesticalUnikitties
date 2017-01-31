//
//  GameScene.swift
//  MajesticalUnikitties
//
//  Created by Julie on 1/12/17.
//  Copyright © 2017 Julie. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    private var label : SKLabelNode?
    private var label2 : SKLabelNode?
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        label = SKLabelNode(fontNamed: "Party LET")
        label2 = SKLabelNode(fontNamed: "Party LET")
        
        if let label = label {
            label.text = "Majestical"
            label.position = CGPoint(x: frame.midX, y: frame.midY + 30)
            label.fontSize = 48
            label.color = UIColor.white
            
            addChild(label)
        }
        
        if let label = label2 {
            label.text = "Unikitties!"
            label.position = CGPoint(x: frame.midX, y: frame.midY - 30)
            label.fontSize = 48
            label.color = UIColor.white
            
            addChild(label)
        }
        
        let uniKitty = SKSpriteNode(imageNamed: "UniKittySplash")
        uniKitty.position = CGPoint(x: frame.midX, y: frame.midY/2)
        addChild(uniKitty)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let reveal = SKTransition.reveal(with: .left,
                                         duration: 1)
        let newScene = GameScene(size: CGSize(width: 1024, height: 768))
        
        scene?.view?.presentScene(newScene,
                                transition: reveal)
    }
}
