//
//  GameScene.swift
//  CrashCar-Foundation
//
//  Created by Gerson Janhuel on 27/06/24.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var cone: SKSpriteNode?
    var car: SKSpriteNode?
    
    let xPositions = [-90, 90]
    
    var carPosition = 1
    
    var score = 0
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        cone = self.childNode(withName: "//Cone") as? SKSpriteNode
        
        
        car = self.childNode(withName: "//Car") as? SKSpriteNode
        car?.physicsBody = SKPhysicsBody(rectangleOf: car?.size ?? .zero)
        car?.physicsBody?.affectedByGravity = false
        car?.physicsBody?.allowsRotation = false
        car?.physicsBody?.contactTestBitMask = car?.physicsBody?.collisionBitMask ?? 0
        
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
        newCone.physicsBody = SKPhysicsBody(rectangleOf: newCone.size)
        newCone.physicsBody?.isDynamic = false
        
        newCone.position = CGPoint(x: xPositions[Int.random(in: 0...1)], y: 700)
        
        addChild(newCone)
        
        moveCone(node: newCone)
    }
    
    func moveCone(node: SKNode) {
        let moveDownAction = SKAction.moveTo(y: -700, duration: 2)
        let removeNodeAction = SKAction.removeFromParent()
        let addScore = SKAction.run {
            self.score = self.score + 1
            print("score: \(self.score)")
        }
        let moveAndRemove = SKAction.sequence([moveDownAction, removeNodeAction, addScore])
        node.run(moveAndRemove)
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "Car" && nodeB.name == "Cone" {
            
            nodeB.removeFromParent()
            nodeA.shakeSprite(duration: 0.5)
            
        }
    }
    
    

}
