//
//  RHDefaultLoading.swift
//  RHViewStateKit
//
//  Created by Bagus andinata on 21/07/21.
//

import UIKit
import SnapKit

open class RHLoadingView: UIView {
    /// Start loading animation
    open func startAnimating() {}
    
    /// Stop loading animation
    open func stopAnimating() {}
    
    /// Optional update UI loading animation
    open func updateUI() {}
}

class RHDefaultLoading: RHLoadingView {
    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        return view
    }()
    
    var color: UIColor = .gray {
        didSet {
            indicator.color = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(indicator)
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func updateUI() {
        indicator.snp.remakeConstraints { make in
            make.width.height.equalTo(20)
            make.center.equalTo(self)
        }
    }
    
    override func startAnimating() {
        indicator.startAnimating()
    }
    
    override func stopAnimating() {
        indicator.stopAnimating()
    }
}
