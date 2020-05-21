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
import UIKit

class LearningSCNScene: SCNScene, UIGestureRecognizerDelegate {
    var scnView: LearningSCNView?
    var node: SCNNode?
    var model: Model = Model()
    let cameraNode = SCNNode()
    let camera = SCNCamera()
    
    // MARK: - Update view with scene
    func update(_ view: LearningSCNView) {
        self.scnView = view
        
        self.addCamera()
        self.addFloor()
        self.loadModel()
        
        scnView?.autoenablesDefaultLighting = true
    }
    
    // MARK: - Camera
    private func addCamera() {
        self.camera.zFar = 10000000
        self.cameraNode.camera = self.camera
        self.cameraNode.position = SCNVector3(0, 0, 0)
        self.cameraNode.rotation = SCNVector4(0, 0, 0, 0)
    }
    
    // MARK: - Floor
    private func addFloor() {
        let node = SCNNode()
        let floor = SCNFloor()
        floor.reflectivity = 0.3    // Optional
        node.geometry = floor
        node.position = SCNVector3(50, 0, 50)
        self.rootNode.addChildNode(node)
    }
    
    // MARK: - Model
    private func loadModel() {
        // Fetch node from "idle.scn"
        self.node = self.model.node
        
        guard let node = self.node else { return }
        self.rootNode.addChildNode(node)
    }
}


