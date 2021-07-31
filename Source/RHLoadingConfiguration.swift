//
//  RHLoadingConfiguration.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit

public struct RHLoadingConfiguration {
    /// Title attributes
    public var view: RHLoadingView = RHDefaultLoading()
    
    /// Size loading, default = 50
    public var size: CGSize = CGSize(width: 20, height: 20)
    
    /// Background loading, default = white
    public var backgroundColor: UIColor = .white
    
    /// Indicator color default, default = gray
    public var color: UIColor = .gray
    
    public init() {}
}
