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

import PlaygroundSupport
import UIKit

public enum TaeKwonDo: String {
    case all = "dynamic"
}

public class WWDC {
    public static let SwiftStudentChallenge = WWDC()
    
    static let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
    
    var scnView: LearningSCNView!
    
    // MARK: Learning
    public func letsLearn(taekwondo: TaeKwonDo) {
        Model.posture = taekwondo.rawValue
        self.load3DView()
        
        PlaygroundPage.current.liveView = CoverView()
        PlaygroundPage.current.needsIndefiniteExecution = true
    }
    
    func learnIn3D() {
        PlaygroundPage.current.liveView = self.scnView
        PlaygroundPage.current.needsIndefiniteExecution = true
    }
    
    private func load3DView() {
        self.scnView = LearningSCNView(frame: WWDC.frame)
        self.scnView.scene = LearningSCNScene()
        
        self.scnView.setup()
    }
}
