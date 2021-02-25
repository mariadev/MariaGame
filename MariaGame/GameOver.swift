//
//  GameOver.swift
//  MariaGame
//
//  Created by Maria on 23/02/2021.
//

import Foundation
import SpriteKit

class GameOver : SKScene {

    override func sceneDidLoad() {
        run(Sound.gameOver.action)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            let level1 = GameScene(fileNamed: "Level1")
            self.view?.presentScene(level1)
            self.removeAllActions()
        }
    }
}
