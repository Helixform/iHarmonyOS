//
//  PasswordField.swift
//  iHarmonyOS
//
//  Created by Cyandev on 2021/6/5.
//

import UIKit

private let dotSize = 19
private let spacing = 24
private let dots = 6

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
            _textLength
        }
    }

    var changeHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        for _ in 0 ..< dots {
            let dotView = UIImageView()
            dotView.tintColor = .label
            addSubview(dotView)
            dotViews.append(dotView)
        }
    }

    override var intrinsicContentSize: CGSize {
        .init(width: dots * dotSize + (dots - 1) * spacing, height: 34)
    }

    override var canBecomeFirstResponder: Bool {
        true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var currentX = 0
        for (index, dotView) in dotViews.enumerated() {
            dotView.frame = .init(x: currentX, y: 7, width: dotSize, height: dotSize)
            if index < textLength {
                dotView.image = .init(named: "passcodeDot-full_Normal")?.withRenderingMode(.alwaysTemplate)
            } else {
                dotView.image = .init(named: "passcodeDot-outline_Normal")?.withRenderingMode(.alwaysTemplate)
            }
            currentX += dotSize + spacing
        }
    }
}

extension PasswordField: UITextInputTraits {
    var keyboardType: UIKeyboardType {
        set {}
        get {
            .numberPad
        }
    }
}

extension PasswordField: UIKeyInput {
    var hasText: Bool {
        true
    }

    func insertText(_ text: String) {
        textLength += text.count
    }

    func deleteBackward() {
        textLength -= 1
    }
}
