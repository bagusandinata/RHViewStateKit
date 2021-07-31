//
//  RHViewCollectionState.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

// copy from https://github.com/alberdev/EmptyStateKit, partially edited

import UIKit

public protocol RHViewCollectionState {
    var image: UIImage? { get }
    var title: String? { get }
    var description: String? { get }
    var titleButton: String? { get }
    var viewConfiguration: RHViewConfiguration { get }
    var buttonConfiguration: RHButtonConfiguration { get }
    var titleConfiguration: RHTitleConfiguration { get }
    var descriptionConfiguration: RHDescriptionConfiguration { get }
    var imageConfiguration: RHImageConfiguration { get }
    var positionConfiguration: RHPositionConfiguration { get }
}

public extension RHViewCollectionState {
    
    var image: UIImage? {
        get { return nil }
    }
    
    var title: String? {
        get { return nil }
    }
    
    var description: String? {
        get { return nil }
    }
    
    var titleButton: String? {
        get { return nil }
    }
    
    var viewConfiguration: RHViewConfiguration {
        get { return RHViewConfiguration() }
    }
    
    var buttonConfiguration: RHButtonConfiguration {
        get { return RHButtonConfiguration() }
    }
    
    var titleConfiguration: RHTitleConfiguration {
        get { return RHTitleConfiguration() }
    }
    
    var descriptionConfiguration: RHDescriptionConfiguration {
        get { return RHDescriptionConfiguration() }
    }
    
    var imageConfiguration: RHImageConfiguration {
        get { return RHImageConfiguration() }
    }
    
    var positionConfiguration: RHPositionConfiguration {
        get { return RHPositionConfiguration() }
    }
    
}
