//
//  Winner.swift
//  MariaGame
//
//  Created by Maria on 27/02/2021.
//

import Foundation
import SpriteKit

class Winner: SKScene {

    override func sceneDidLoad() {
        run(Sound.win.action)
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
            let level1 = GameScene(fileNamed: "Level1")
            self.view?.presentScene(level1)
            self.removeAllActions()
        }
    }
}
