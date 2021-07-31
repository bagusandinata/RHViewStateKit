//
//  RHPositionConfiguration.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit

public typealias TopConstraint = CGFloat
public typealias BottomConstraint = CGFloat

public struct RHPositionConfiguration {
    var view: RHViewPosition = .center
    var text: RHTextPosition = .center
    var image: RHImagePosition = .top
    
    public init(view: RHViewPosition? = nil, text: RHTextPosition? = nil, image: RHImagePosition? = nil) {
        self.view = view ?? .center
        self.text = text ?? .center
        self.image = image ?? .top
    }
}

public enum RHViewPosition {
    case top
    case center
    case bottom
}

public enum RHTextPosition {
    case left
    case center
    case right
    case justify
}

public enum RHImagePosition {
    case top
    case bottom
    case cover(TopConstraint, BottomConstraint)
}
