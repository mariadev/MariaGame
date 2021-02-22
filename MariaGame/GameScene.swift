//
//  GameScene.swift
//  MariaGame
//
//  Created by Maria on 21/02/2021.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private let kTimeoutInSeconds:TimeInterval = 1
//    private var timer: Timer?
    // Nodes
    var player : SKNode?
    var joystick : SKNode?
    var joystickKnob : SKNode?
    var cameraNode : SKCameraNode?
    var mountains1 : SKNode?
    var mountains2 : SKNode?
    var mountains3 : SKNode?
    var moon : SKNode?
    
    // Boolean
    var joystickAction = false
    
    // Measure
    var knobRadius : CGFloat = 50.0
    
    // Sprite Engine
    var previousTimeInterval : TimeInterval = 0
    var playerIsFacingRight = true
    var playerSpeed = 4.0
    
    var playerStateMachine : GKStateMachine!
    
    
    func fetch () {}
    // didmove
    override func didMove(to view: SKView) {
        
        player = childNode(withName: "player")
        joystick = childNode(withName: "joystick")
        joystickKnob = joystick?.childNode(withName: "knob")
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        mountains1 = childNode(withName: "mountain1")
        mountains2 = childNode(withName: "mountain2")
        mountains3 = childNode(withName: "mountain3")
        moon = childNode(withName: "moon")
        
        playerStateMachine = GKStateMachine(states: [
            JumpingState(playerNode: player!),
            WalkingState(playerNode: player!),
            IdleState(playerNode: player!),
            LandingState(playerNode: player!),
            StunnedState(playerNode: player!),
        ])
        
        playerStateMachine.enter(IdleState.self)
    }
}

// MARK: Touches
extension GameScene {
    // Touch Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let joystickKnob = joystickKnob {
                let location = touch.location(in: joystick!)
                joystickAction = joystickKnob.frame.contains(location)
            }
            
            let location = touch.location(in: self)
            if !(joystick?.contains(location))! {
                playerStateMachine.enter(JumpingState.self)
            }
        }
    }
    
    // Touch Moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let joystick = joystick else { return }
        guard let joystickKnob = joystickKnob else { return }
        
        if !joystickAction { return }
        
        // Distance
        for touch in touches {
            let position = touch.location(in: joystick)
            
            let length = sqrt(pow(position.y, 2) + pow(position.x, 2))
            let angle = atan2(position.y, position.x)
            
            if knobRadius > length {
                joystickKnob.position = position
            } else {
                joystickKnob.position = CGPoint(x: cos(angle) * knobRadius, y: sin(angle) * knobRadius)
            }
        }

    }
    
    // Touch End
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let xJoystickCoordinate = touch.location(in: joystick!).x
            let xLimit: CGFloat = 200.0
            if xJoystickCoordinate > -xLimit && xJoystickCoordinate < xLimit {
                resetKnobPosition()
            }
            
        }
    }
}

extension GameScene {
    func resetKnobPosition() {
        let initialPoint = CGPoint(x: 0, y: 0)
        let moveBack = SKAction.move(to: initialPoint, duration: 0.1)
        moveBack.timingMode = .linear
        joystickKnob?.run(moveBack)
        joystickAction = false
    }
}

// MARK: Game Loop
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        //        let deltaTime = currentTime - previousTimeInterval
        //        previousTimeInterval = currentTime
        //        guard let joystickKnob = joystickKnob else { return }
        //        let xPosition = Double(joystickKnob.position.x)
        //        let displacement = CGVector(dx: deltaTime * xPosition * playerSpeed, dy: 0)
        guard let joystickKnob = joystickKnob else { return }
        let xPosition = Double(joystickKnob.position.x)
        let positivePosition = xPosition < 0 ? -xPosition : xPosition
        
        if floor(positivePosition) != 0 {
            playerStateMachine.enter(WalkingState.self)
        } else {
            playerStateMachine.enter(IdleState.self)
        }
        
        cameraNode?.position.x = (player?.position.x)!
        joystick?.position.y = (cameraNode?.position.y)! - 100
        joystick?.position.x = (cameraNode?.position.x)! - 300
        
        let displacement = CGVector(dx: 0.016 * xPosition * playerSpeed, dy: 0)
        let move = SKAction.move(by: displacement, duration: 0)
        let faceAction : SKAction!
        let movingRight = xPosition > 0
        let movingLeft = xPosition < 0
        if movingLeft && playerIsFacingRight {
            playerIsFacingRight = false
            let faceMovement = SKAction.scaleX(to: -1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        }
        else if movingRight && !playerIsFacingRight {
            playerIsFacingRight = true
            let faceMovement = SKAction.scaleX(to: 1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        } else {
            faceAction = move
        }
        player?.run(faceAction)
        
        let displacementParallax1 = CGVector(dx: (0.016 * xPosition * playerSpeed) / -20, dy: 0)
        let parallax1 = SKAction.move(by: displacementParallax1, duration: 0)
        mountains1?.run(parallax1)

        let displacementParallax2 = CGVector(dx: (0.016 * xPosition * playerSpeed) / -20, dy: 0)
        let parallax2 = SKAction.move(by: displacementParallax2, duration: 0)
        mountains2?.run(parallax2)

        let displacementParallax3 = CGVector(dx: (0.016 * xPosition * playerSpeed) / -20, dy: 0)
        let parallax3 = SKAction.move(by: displacementParallax3, duration: 0)
        mountains3?.run(parallax3)

        
        let displacementParallax4 = SKAction.moveTo(x: (cameraNode?.position.x)!, duration: 0.0)
        moon?.run( displacementParallax4 )
        
//        let parallax5 = SKAction.moveTo(x: (cameraNode?.position.x)!, duration: 0.0)
//        stars?.run(parallax5)
    }
    
}







