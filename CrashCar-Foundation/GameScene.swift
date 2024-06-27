//
//  GameScene.swift
//  CrashCar-Foundation
//
//  Created by Gerson Janhuel on 27/06/24.
//

import SpriteKit

class GameScene: SKScene {
    
    var cone: SKSpriteNode?
    var car: SKSpriteNode?
    
    let xPositions = [-90, 90]
    
    var carPosition = 1
    
    
    override func didMove(to view: SKView) {
        
        cone = self.childNode(withName: "//Cone") as? SKSpriteNode
        car = self.childNode(withName: "//Car") as? SKSpriteNode
        
        repeatedlySpawnCone()
    }
    
    func repeatedlySpawnCone() {
        let spawnAction = SKAction.run {
            self.spawnCone()
        }
        
        let waitAction = SKAction.wait(forDuration: 0.5)
        
        let spawnAndWaitAction = SKAction.sequence([spawnAction, waitAction])
        
        run(SKAction.repeatForever(spawnAndWaitAction))
        
    }
    
    func spawnCone() {
        let newCone = cone?.copy() as! SKSpriteNode
        newCone.position = CGPoint(x: xPositions[Int.random(in: 0...1)], y: 700)
        
        addChild(newCone)
        
        moveCone(node: newCone)
    }
    
    func moveCone(node: SKNode) {
        let moveDownAction = SKAction.moveTo(y: -700, duration: 2)
        node.run(moveDownAction)
    }
    
    func updateCarPosition() {
        //conditional
        
        if carPosition == 1 {
            carPosition = 2
        } else {
            carPosition = 1
        }
        
        car?.run(SKAction.moveTo(x: (carPosition == 1) ? -80 : 80, duration: 0.1))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //update car position
        updateCarPosition()
    }
    
    

}
