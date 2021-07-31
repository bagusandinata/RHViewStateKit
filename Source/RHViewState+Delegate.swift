//
//  RHViewState+DataSource.swift
//  RHViewStateKit
//
//  Created by Bagus andinata on 24/07/21.
//

import Foundation

public protocol RHViewStateDelegate: AnyObject {
    /// Delegate tap button
    func viewState(_ viewState: RHViewState, didTapButton button: UIButton)
}
