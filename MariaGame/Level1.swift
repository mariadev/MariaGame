//
//  Level1.swift
//  MariaGame
//
//  Created by Maria on 24/02/2021.
//


import Foundation
import SpriteKit

class Level1 : GameScene {
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
    }
    
//    override func update(_ currentTime: TimeInterval) {
//        
//        super.update(currentTime)
//        if score >= 1 {
//            let nextLevel = GameScene(fileNamed: "Level2")
//            nextLevel?.scaleMode = .aspectFill
//            view?.presentScene(nextLevel)
//            run(Sound.levelUp.action)
//        }
//    }
}
