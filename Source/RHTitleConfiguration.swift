//
//  RHTitleConfiguration.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit

public struct RHTitleConfiguration {
    /// Title attributes
    public var attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 24), .foregroundColor: UIColor.darkGray]
    
    /// Title top constraint  when image in top, default = 26
    public var topConstraint: CGFloat = 26
    
    public init() {}
}
