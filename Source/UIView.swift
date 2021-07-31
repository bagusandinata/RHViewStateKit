//
//  UIView.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit

private var viewStatekey = "viewState"

public extension UIView {
    var viewState: RHViewState! {
        get {
            guard let saved = ao_get(pkey: &viewStatekey) as? RHViewState else {
                self.viewState = RHViewState(inView: self)
                return self.viewState
            }
            return saved
        }
        set { ao_set(newValue ?? RHViewState(inView: self), pkey: &viewStatekey) }
    }
    
    func addSubviews(with views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}

