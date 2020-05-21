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

import Foundation
import AVFoundation

extension String {
    func speak() {
        // Configure audio session
        let audioSession = AVAudioSession.sharedInstance()
        do { try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker) }
        catch { print(error) }
        
        // set up synthesizer + Convert self to utterance
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: self)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-EN")
        utterance.rate = 0.50
        
        // Speak
        synthesizer.speak(utterance)
    }
}
