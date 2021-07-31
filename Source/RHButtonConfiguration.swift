//
//  RHButtonConfiguration.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit

public enum RHButtonCornerType {
    case capsule
    case custom(radius: CGFloat)
    case none
}

public struct RHButtonConfiguration {
    /// Button attributes
    public var attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.white]
    
    /// Button color
    public var color: UIColor = .red
    
    /// Button corner radius, default = 20
    public var cornerType: RHButtonCornerType = .custom(radius: 20)
    
    /// Button width, nil = auto
    public var width: CGFloat? = nil
    
    /// Button height, default = 40
    public var height: CGFloat = 40
    
    /// Button top constraint, default = 20
    public var topConstraint: CGFloat = 20
    
    /// Button title inset, default = 8
    public var titleInset: CGFloat = 8
    
    /// Button shadow radius, default = 0
    public var shadowRadius: CGFloat = 0
    
    /// Button shadow opacity, defautl = 0.5
    public var shadowOpacity: Float = 0.5
    
    /// Button border color, default = nil
    public var borderColor: UIColor? = nil
    
    /// Button border width, default = 0
    public var borderWidth: CGFloat = 0
    
    public init() {}
}
