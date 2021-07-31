//
//  EActivityIndicatorView.swift
//  app
//
//  Created by Bagus andinata on 18/02/21.
//  Copyright © 2021 wit. All rights reserved.
//

// Copy and Edit partially from https://github.com/ninjaprox/NVActivityIndicatorView 

import UIKit
import RHViewStateKit

protocol EActivityIndicatorAnimationDelegate {
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor)
}

public enum EActivityIndicatorType: CaseIterable {
    case ballClipRotateMultiple
    case ballPulseSync
    
    func animation() -> EActivityIndicatorAnimationDelegate {
        switch self {
        case .ballClipRotateMultiple:
            return EAnimationMultipleBallClipRotate()
        case .ballPulseSync:
            return EAnimationBallPulseSync()
        }
    }
}

public typealias FadeInAnimation = (UIView) -> Void

public typealias FadeOutAnimation = (UIView, @escaping () -> Void) -> Void

public final class EActivityIndicatorView: RHLoadingView {
    
    public static var DEFAULT_TYPE: EActivityIndicatorType = .ballClipRotateMultiple

    public static var DEFAULT_COLOR = UIColor.white

    public static var DEFAULT_TEXT_COLOR = UIColor.white

    public static var DEFAULT_PADDING: CGFloat = 0

    public static var DEFAULT_BLOCKER_SIZE = CGSize(width: 60, height: 60)

    public static var DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD = 0

    public static var DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME = 0
    
    public static var DEFAULT_BLOCKER_MESSAGE: String?
    
    public static var DEFAULT_BLOCKER_MESSAGE_SPACING = CGFloat(8.0)
    
    public static var DEFAULT_BLOCKER_MESSAGE_FONT = UIFont.boldSystemFont(ofSize: 20)
    
    public static var DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

    public static var DEFAULT_FADE_IN_ANIMATION: FadeInAnimation = { view in
        view.alpha = 0
        UIView.animate(withDuration: 0.25) {
            view.alpha = 1
        }
    }

    public static var DEFAULT_FADE_OUT_ANIMATION: FadeOutAnimation = { (view, complete) in
        UIView.animate(withDuration: 0.25,
                       animations: {
                        view.alpha = 0
        },
                       completion: { completed in
                        if completed {
                            complete()
                        }
        })
    }
    
    public var type: EActivityIndicatorType = EActivityIndicatorView.DEFAULT_TYPE

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var typeName: String {
        get {
            return getTypeName()
        }
        set {
            _setTypeName(newValue)
        }
    }

    @IBInspectable public var color: UIColor = EActivityIndicatorView.DEFAULT_COLOR

    @IBInspectable public var padding: CGFloat = EActivityIndicatorView.DEFAULT_PADDING

    @available(*, deprecated)
    public var animating: Bool { return isAnimating }

    private(set) public var isAnimating: Bool = false

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        isHidden = true
    }

    public init(frame: CGRect, type: EActivityIndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil) {
        self.type = type ?? EActivityIndicatorView.DEFAULT_TYPE
        self.color = color ?? EActivityIndicatorView.DEFAULT_COLOR
        self.padding = padding ?? EActivityIndicatorView.DEFAULT_PADDING
        super.init(frame: frame)
        isHidden = true
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }

    public override var bounds: CGRect {
        didSet {
            if oldValue != bounds && isAnimating {
                setUpAnimation()
            }
        }
    }

    public override func startAnimating() {
        guard !isAnimating else {
            return
        }
        isHidden = false
        isAnimating = true
        layer.speed = 1
        setUpAnimation()
    }
    
    public override func stopAnimating() {
        guard isAnimating else {
            return
        }
        isHidden = true
        isAnimating = false
        layer.sublayers?.removeAll()
    }

    func _setTypeName(_ typeName: String) {
        for item in EActivityIndicatorType.allCases {
            if String(describing: item).caseInsensitiveCompare(typeName) == ComparisonResult.orderedSame {
                type = item
                break
            }
        }
    }

    func getTypeName() -> String {
        return String(describing: type)
    }
    
    private final func setUpAnimation() {
        let animation: EActivityIndicatorAnimationDelegate = type.animation()
        var animationRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        let minEdge = min(animationRect.width, animationRect.height)

        layer.sublayers = nil
        animationRect.size = CGSize(width: minEdge, height: minEdge)
        animation.setUpAnimation(in: layer, size: animationRect.size, color: color)
    }
}
