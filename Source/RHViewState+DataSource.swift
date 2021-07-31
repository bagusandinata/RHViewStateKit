//
//  RHViewState+DataSource.swift
//  RHViewStateKit
//
//  Created by Bagus andinata on 24/07/21.
//

import Foundation

public protocol RHViewStateDataSource: AnyObject {
    /// Data source for content image
    func imageForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> UIImage?
    
    /// Data source for content title
    func titleForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String?
    
    /// Data source for content description
    func descriptionForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String?
    
    /// Data source for content title
    func titleButtonForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String?
    
    /// Data source for view configuration
    func rhViewConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHViewConfiguration
    
    /// Data source for button configuration
    func rhButtonConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHButtonConfiguration
    
    /// Data source for title configuration
    func rhTitleConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHTitleConfiguration
    
    /// Data source for description configuration
    func rhDescriptionConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHDescriptionConfiguration
    
    /// Data source for image configuration
    func rhImageConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHImageConfiguration
    
    /// Data source for position configuration
    func rhPositionConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHPositionConfiguration
}

public extension RHViewStateDataSource {
    func imageForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> UIImage? {
        return nil
    }
    
    func titleForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String? {
        return nil
    }
    
    func descriptionForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String? {
        return nil
    }
    
    func titleButtonForState(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> String? {
        return nil
    }
    
    func rhViewConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHViewConfiguration {
        return RHViewConfiguration()
    }
    
    func rhButtonConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHButtonConfiguration {
        return RHButtonConfiguration()
    }
    
    func rhTitleConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHTitleConfiguration {
        return RHTitleConfiguration()
    }
    
    func rhDescriptionConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHDescriptionConfiguration {
        return RHDescriptionConfiguration()
    }
    
    func rhImageConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHImageConfiguration {
        return RHImageConfiguration()
    }
    
    func rhPositionConfiguration(_ state: RHViewCollectionState, inViewState viewState: RHViewState) -> RHPositionConfiguration {
        return RHPositionConfiguration(view: .center, text: .center, image: .top)
    }
}
