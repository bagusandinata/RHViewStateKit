//
//  TableViewState.swift
//  RHViewStateKit_Example
//
//  Created by Bagus andinata on 25/07/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import RHViewStateKit

enum TableViewState: RHViewCollectionState {
    case NoInternet
    case EmptyData
    case InternalError
    case Maintenance
    
    var image: UIImage? {
        switch self {
        case .NoInternet:
            return UIImage(named: "ic-no-internet")
        case .EmptyData:
            return UIImage(named: "ic-empty-data")
        case .InternalError:
            return UIImage(named: "ic-internal-error")
        case .Maintenance:
            return UIImage(named: "ic-maintenance")
        }
    }
    
    var title: String? {
        switch self {
        case .NoInternet:
            return "No Internet Connection"
        case .EmptyData:
            return "Oops! It's Empty"
        case .InternalError:
            return "Oops! Something Went Wrong"
        case .Maintenance:
            return "We'll Be Back Soon"
        }
    }
    
    var description: String? {
        switch self {
        case .NoInternet:
            return "Try turning on your Wifi or Mobile Data for using the app"
        case .EmptyData:
            return "There are no products under this category right now"
        case .InternalError:
            return "Try to reload this page or feel free to contact us if the problem persists"
        case .Maintenance:
            return "App is down for scheduled maintenance and expect to back online in a few minutes"
        }
    }
    
    var titleButton: String? {
        switch self {
        case .NoInternet:
            return "RETRY"
        case .EmptyData:
            return ""
        case .InternalError:
            return "RELOAD PAGE"
        case .Maintenance:
            return ""
        }
    }
    
    var viewConfiguration: RHViewConfiguration {
        var config = RHViewConfiguration()
        
        switch self {
        case .NoInternet:
            config.backgroundColor = UIColor(hex: "#ffd600")
        case .EmptyData:
            config.backgroundColor = UIColor(hex: "#c6ff00")
        case .InternalError:
            config.backgroundColor = UIColor(hex: "#fbe9e7")
        case .Maintenance:
            config.backgroundColor = UIColor(hex: "#40c4ff")
            config.verticalConstraint = 100
        }
        
        return config
    }
    
    var buttonConfiguration: RHButtonConfiguration {
        var config = RHButtonConfiguration()
        
        switch self {
        case .NoInternet:
            config.shadowRadius = 8
            config.titleInset = 16.0
            config.cornerType = .custom(radius: 5)
        case .InternalError:
            config.attributes = [.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.red]
            config.color = .clear
            config.borderWidth = 1.0
            config.borderColor = .red
            config.width = 200.0
            config.cornerType = .capsule
        default:
            return config
        }
        
        return config
    }
    
    var titleConfiguration: RHTitleConfiguration {
        var config = RHTitleConfiguration()
        
        switch self {
        case .NoInternet:
            config.attributes = [.font: UIFont.boldSystemFont(ofSize: 24), .foregroundColor: UIColor.white]
        case .EmptyData:
            return config
        case .InternalError:
            return config
        case .Maintenance:
            config.attributes = [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]
        }
        
        return config
    }
    
    var descriptionConfiguration: RHDescriptionConfiguration {
        var config = RHDescriptionConfiguration()
        
        switch self {
        case .NoInternet:
            config.attributes = [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.black]
        case .EmptyData:
            return config
        case .InternalError:
            return config
        case .Maintenance:
            config.attributes = [.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.white]
        }
        
        return config
    }
    
    var imageConfiguration: RHImageConfiguration {
        var config = RHImageConfiguration()
        
        switch self {
        case .NoInternet:
            config.animation = .fade(0.3, 0.3)
        case .EmptyData:
            config.animation = .scale(0.3, 0.3)
        case .InternalError:
            config.animation = .noAnimation
        case .Maintenance:
            config.animation = .scale(0.3, 0.3)
        }
        
        return config
    }
    
    var positionConfiguration: RHPositionConfiguration {
        switch self {
        case .NoInternet:
            return RHPositionConfiguration(view: .top, text: .center, image: .bottom)
        case .EmptyData:
            return RHPositionConfiguration(view: .center, text: .justify, image: .top)
        case .InternalError:
            return RHPositionConfiguration(view: .bottom, text: .right, image: .top)
        case .Maintenance:
            return RHPositionConfiguration(view: .bottom, text: .center, image: .cover(50.0, 50.0))
        }
    }
}
