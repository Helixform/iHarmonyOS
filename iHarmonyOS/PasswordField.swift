//
//  PasswordField.swift
//  iHarmonyOS
//
//  Created by Cyandev on 2021/6/5.
//

import UIKit

fileprivate let dotSize = 19
fileprivate let spacing = 24
fileprivate let dots = 6

class PasswordField: UIView {
    
    private var dotViews = [UIImageView]()
    private var _textLength: Int = 0
    var textLength: Int {
        set {
            _textLength = min(max(newValue, 0), dots)
            setNeedsLayout()
            changeHandler?()
        }
        get {
            return _textLength
        }
    }

    var changeHandler: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        for _ in 0..<dots {
            let dotView = UIImageView(image: .init(named: "passcodeDot-outline_Normal"))
            addSubview(dotView)
            dotViews.append(dotView)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: dots * dotSize + (dots - 1) * spacing, height: 34)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var currentX = 0
        for (index, dotView) in dotViews.enumerated() {
            dotView.frame = .init(x: currentX, y: 7, width: dotSize, height: dotSize)
            if index < textLength {
                dotView.image = .init(named: "passcodeDot-full_Normal")
            } else {
                dotView.image = .init(named: "passcodeDot-outline_Normal")
            }
            currentX += dotSize + spacing
        }
    }

}

extension PasswordField: UITextInputTraits {
    
    var keyboardType: UIKeyboardType {
        set { }
        get {
            return .numberPad
        }
    }
    
}

extension PasswordField: UIKeyInput {
    
    var hasText: Bool {
        return true
    }
    
    func insertText(_ text: String) {
        textLength += text.count
    }
    
    func deleteBackward() {
        textLength -= 1
    }
    
    
}
