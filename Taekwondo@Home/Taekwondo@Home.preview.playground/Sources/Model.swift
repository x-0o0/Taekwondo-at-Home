/// MIT License
///
/// Copyright (c) 2020 Jaesung
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.

// Copyright © 2020 Jaesung Lee. All Rights reserved.

import SceneKit

class Model {
    // Store posture of taekwondo
    static var posture: String = ""
    
    // MARK: - Properties
    var node: SCNNode?
    
    // MARK: - initialization
    init() {
        self.node = loadNode()
        loadAnimations(for: node!)
    }
    
    // MARK: - Load Animations
    private func loadAnimation(from sceneName: String) -> SCNAnimationPlayer? {
        guard let scene = SCNScene(named: sceneName) else { return nil }
        
        var animationPlayer: SCNAnimationPlayer?
        
        // Fetch animation
        scene.rootNode.enumerateChildNodes { (child, stop) in
            if !child.animationKeys.isEmpty {
                animationPlayer = child.animationPlayer(forKey: child.animationKeys[0])
                stop.pointee = true
            }
        }
        return animationPlayer
    }
    
    private func loadAnimations(for node: SCNNode) {
        let key = Model.posture
        guard let animation = self.loadAnimation(from: "\(key).scn") else {
            print("Failed to load animation")
            return
        }
        
        // Default settings for animation
        animation.speed = 1.0
        animation.stop()
        
        // Add animation player
        node.addAnimationPlayer(animation, forKey: key)
    }
    
    // MARK: - Model Setup
    private func loadNode() -> SCNNode {
        let idleScene = SCNScene(named: "idle.scn")!
        
        // Fetch default node with default scale and default position
        let node = idleScene.rootNode.childNode(withName: "Armature", recursively: false)!
        node.scale(0.7)
        node.position = SCNVector3(0, 0, 0)
        
        return node
    }
    
    // MARK: - Animating Model
    func animate() -> SCNAnimationPlayer? {
        let key = Model.posture
        let animationPlayer = self.node?.animationPlayer(forKey: key)
        
        // Set up animation player
        animationPlayer?.animation.repeatCount = .infinity
        animationPlayer?.animation.blendInDuration = 0.3
        
        // Play animation player
        animationPlayer?.play()
        
        return animationPlayer
    }
}

