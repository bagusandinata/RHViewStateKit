//
//  RHViewStateAnimation.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

// copy from https://github.com/alberdev/EmptyStateKit

import UIKit

public typealias FadeTimeInterval = TimeInterval
public typealias ScaleTimeInterval = TimeInterval

public enum RHViewStateAnimation {
    
    case fade(FadeTimeInterval, FadeTimeInterval)
    case scale(ScaleTimeInterval, ScaleTimeInterval)
    case noAnimation
    
    var play: ((RHDefaultViewState) -> ())? {
        switch self {
        case .fade(let duration1, let duration2):
            return { $0.fade(duration1, duration2) }
        case .scale(let duration1, let duration2):
            return { $0.scale(duration1, duration2) }
        case .noAnimation: return nil
        }
    }
}
