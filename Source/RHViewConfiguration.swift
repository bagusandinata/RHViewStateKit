//
//  RHViewConfiguration.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit

public struct RHViewConfiguration {
    /// Alpha container
    public var alpha: CGFloat = 1.0
    
    /// Background color
    public var backgroundColor: UIColor = .white
    
    /// Background Gradient color
    public var gradientColor: (UIColor, UIColor)? = nil
    
    /// Top or bottom Constraint
    public var verticalConstraint: CGFloat = 40
    
    /// Left & right Constraint
    public var horizontalConstraint: CGFloat = 40
    
    public init() {}
}
