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
import ARKit


class LearningSCNView: SCNView, ARSCNViewDelegate, AVAudioPlayerDelegate {
    // 3D experiences
    var scnScene: LearningSCNScene!
    var centerCoord: SCNVector3?
    var animationPlayer: SCNAnimationPlayer?
    var isAnimationPaused: Bool = false

    // Musics
    var soundEffectPlayer: AVAudioPlayer?
    var bgmPlayer: AVAudioPlayer?
    
    // Text guide
    var guideLabel: UILabel?
    
    // MARK: - Appear
    // Start AR experience when the view appears
    func setup() {
        // Update scene
        self.scnScene = LearningSCNScene()
        self.scnScene.update(self)

        self.animationPlayer = self.scnScene.model.animate()
        self.delegate = self
        
        self.backgroundColor = .black
        self.autoenablesDefaultLighting = true
        
        self.scene = scnScene
        
        // Configure camera
        self.configureCamera()
        
        // Play background music
        self.playBackgroundMusic()
        
        // Set up gesture
        self.setupGesture()
        
        // Add Guide text
        self.addGuideText("")
        
        // Reset the text after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            guard self.guideLabel?.text?.contains("Tap") ?? false else { return }
            self.updateGuideText("")
        }
        
        let text = "3D Mode is ready.  Tap button to start."
        text.speak()
    }
    
    // Configure camera
    private func configureCamera() {
        self.allowsCameraControl = true
        self.defaultCameraController.interactionMode = .orbitTurntable
        self.defaultCameraController.maximumVerticalAngle = 60.0
        self.defaultCameraController.minimumVerticalAngle = 0.0
    }
    
    // Play background music
    private func playBackgroundMusic() {
        guard let musicPath = Bundle.main.path(forResource: "bgm", ofType: "m4a") else { return }
        let musicURL = URL(fileURLWithPath: musicPath)
        
        do {
            try self.bgmPlayer = AVAudioPlayer(contentsOf: musicURL)
            self.bgmPlayer?.delegate = self
            self.bgmPlayer?.volume = 0.5
            self.bgmPlayer?.numberOfLoops = -1  // infinite loop
            self.bgmPlayer?.play()
        } catch { print(error) }
    }
    
    // Set up gesture
    private func setupGesture() {
        gestureRecognizers?.forEach({ gesture in
            if gesture is UITapGestureRecognizer || gesture is UIRotationGestureRecognizer || gesture is UILongPressGestureRecognizer {
                if let index = gestureRecognizers?.firstIndex(of: gesture) {
                    gestureRecognizers?.remove(at: index)
                }
            }
        })
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    
    // MARK: - UI

    // Add text guide label
    private func addGuideText(_ initialText: String) {
        let label = UILabel()
        label.text = initialText
        label.textColor = .systemYellow
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.sizeToFit()
        label.center = CGPoint(x: self.frame.width / 2, y: self.frame.height - 32)
        label.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]    // center alignment
        self.guideLabel = label
        self.addSubview(label)
    }
    
    // Update text of added guide label
    private func updateGuideText(_ text: String) {
        self.guideLabel?.text = text
        self.guideLabel?.sizeToFit()
        self.guideLabel?.center = CGPoint(x: self.frame.width / 2, y: self.frame.height - 32)
        self.guideLabel?.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin] // re-alignment
    }
    
    // MARK: - Actions
    // Play and pause the action of 3D model
    @objc func didTap(_ recognizer: UITapGestureRecognizer) {
        switch self.isAnimationPaused {
        case true:  // play action
            guard let soundPath = Bundle.main.path(forResource: "play", ofType: "m4a") else { return }
            self.animationPlayer?.paused = false
            let soundURL = URL(fileURLWithPath: soundPath)
            self.playSoundEffect(url: soundURL)
            self.updateGuideText("")
            
        case false: // pause action
            guard let soundPath = Bundle.main.path(forResource: "pause", ofType: "m4a") else { return }
            self.animationPlayer?.paused = true
            let soundURL = URL(fileURLWithPath: soundPath)
            self.playSoundEffect(url: soundURL)
            self.updateGuideText("Paused")
        }
    }
    
    private func playSoundEffect(url: URL) {
        do {
            try self.soundEffectPlayer = AVAudioPlayer(contentsOf: url)
            soundEffectPlayer?.delegate = self
            soundEffectPlayer?.play()
        } catch { print(error) }
        
        self.isAnimationPaused.toggle()
        print(self.isAnimationPaused)
    }
}

