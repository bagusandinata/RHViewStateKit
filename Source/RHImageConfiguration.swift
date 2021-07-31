//
//  RHImageConfiguration.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit

public struct RHImageConfiguration {
    /// Image Animation
    public var animation: RHViewStateAnimation? = .scale(0.3, 0.3)
    
    /// Image tint color
    public var tintColor: UIColor? = nil
    
    /// Image top constraint, default = 16
    public var topConstraint: CGFloat = 16
    
    /// Image size, default CGSize(width: 200, height: 200)
    public var size: CGSize = CGSize(width: 200, height: 200)
    
    public init() {}
}
