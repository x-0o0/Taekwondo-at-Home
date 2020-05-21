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

import UIKit
import AVFoundation

class CoverView: UIView {
    
    init() {
        super.init(frame: WWDC.frame)
        // Set up UI
        self.backgroundColor = .init(red: 41 / 255, green: 42 / 255, blue: 48 / 255, alpha: 1.0)
        self.setupGuideUI()
        self.setupTitleUI()
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setupGuideUI() {
        let label = newLabel("Tap button to start", font: .preferredFont(forTextStyle: .subheadline))
        label.textColor = .gray
        label.sizeToFit()
        label.center = CGPoint(x: self.frame.width / 2, y: self.frame.height - 32)
        label.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        self.addSubview(label)
    }
    
    private func setupTitleUI() {
        let title1 = newLabel("Taekwondo@Home", font: .boldSystemFont(ofSize: 35))
        let title2 = newLabel("Jaesung Lee", font: .boldSystemFont(ofSize: 24))
        let title3 = newLabel("Swift Student Challenge", font: .preferredFont(forTextStyle: .headline))
        
        title1.frame = CGRect(x: 0, y: self.frame.height / 2 - 65, width: self.frame.width, height: 36)
        title2.frame = CGRect(x: 0, y: self.frame.height / 2 - 13, width: self.frame.width, height: 26)
        title3.frame = CGRect(x: 0, y: self.frame.height / 2 + 40, width: self.frame.width, height: 24)
        
        let titles = [title1, title2, title3]
        
        titles.forEach { title in
            title.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            self.addSubview(title)
        }
    }
    
    private func newLabel(_ text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.font = font
        
        return label
    }
    
    private func setupButton() {
        let button = UIButton()
        button.setTitle("Let's Learn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: self.frame.width / 2 - 100, y: self.frame.height - 150, width: 200, height: 60)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        
        button.addTarget(self, action: #selector(didTapLearn), for: .touchUpInside)
        button.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        self.addSubview(button)
    }
    
    @objc func didTapLearn() {
        WWDC.SwiftStudentChallenge.learnIn3D()
    }
}



