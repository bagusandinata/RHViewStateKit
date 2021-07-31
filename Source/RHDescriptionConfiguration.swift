//
//  RHDescriptionConfiguration.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit

public struct RHDescriptionConfiguration {
    /// Title attributes
    public var attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.darkGray]
    
    /// Description top constraint , default = 26
    public var topConstraint: CGFloat = 10
    
    public init() {}
}
