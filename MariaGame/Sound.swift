//
//  Sound.swift
//  MariaGame
//
//  Created by Maria on 22/02/2021.
//

import Foundation
import SpriteKit

enum Sound : String {
    case hit, jump, levelUp, meteorFalling, reward, game , gameOver
    
    var action : SKAction {
        return SKAction.playSoundFileNamed(rawValue + "Sound.wav", waitForCompletion: false)
    }
    
    var musicGame : SKAction {
        return SKAction.playSoundFileNamed("music.wav", waitForCompletion: false)
    }
   
}

extension SKAction {
    static let playGameMusic : SKAction = repeatForever(playSoundFileNamed("music2.wav", waitForCompletion: false))
}

