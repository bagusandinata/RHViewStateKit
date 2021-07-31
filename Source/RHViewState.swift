//
//  RHViewState.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

// copy from https://github.com/alberdev/EmptyStateKit, partially edited and added

import UIKit

public class RHViewState {
    
    public weak var delegate: RHViewStateDelegate?
    public weak var dataSource: RHViewStateDataSource?
    
    private var defaultViewState: RHDefaultViewState!
    
    /// Show or hide view
    private var hidden = true {
        didSet {
            defaultViewState?.isHidden = hidden
        }
    }
    
    /// State mode
    private var state: RHViewCollectionState? {
        didSet {
            guard let state = state else { return }
            
            if let dataSource = dataSource {
                let content = RHDefaultViewState.RHContent(
                    image: dataSource.imageForState(state, inViewState: self),
                    title: dataSource.titleForState(state, inViewState: self),
                    description: dataSource.descriptionForState(state, inViewState: self),
                    titleButton: dataSource.titleButtonForState(state, inViewState: self))
                
                defaultViewState.configureDataSource(content: content,
                                                     configView: dataSource.rhViewConfiguration(state, inViewState: self),
                                                     configButton: dataSource.rhButtonConfiguration(state, inViewState: self),
                                                     configTitle: dataSource.rhTitleConfiguration(state, inViewState: self),
                                                     configDescription: dataSource.rhDescriptionConfiguration(state, inViewState: self),
                                                     configImage: dataSource.rhImageConfiguration(state, inViewState: self),
                                                     configPosition: dataSource.rhPositionConfiguration(state, inViewState: self))
            } else {
                let content = RHDefaultViewState.RHContent(image: state.image, title: state.title, description: state.description, titleButton: state.titleButton)
                
                defaultViewState.configureDataSource(content: content,
                                                     configView: state.viewConfiguration,
                                                     configButton: state.buttonConfiguration,
                                                     configTitle: state.titleConfiguration,
                                                     configDescription: state.descriptionConfiguration,
                                                     configImage: state.imageConfiguration,
                                                     configPosition: state.positionConfiguration)
            }
        }
    }
    
    /// Loading configuration
    public var loading = RHLoadingConfiguration() {
        didSet {
            defaultViewState.loadingConfiguration = loading
        }
    }
    
    init(inView view: UIView?) {
        
        // Create empty state view
        defaultViewState = RHDefaultViewState()
        defaultViewState.isHidden = true
        defaultViewState.actionButton = { [weak self] (button) in
            self?.didTapButton(button)
        }
        
        // Add it to your view
        if let view = view as? UIScrollView {
            configureViewStateConstraint(with: view.superview)
        } else {
            configureViewStateConstraint(with: view)
        }
    }
    
    deinit {
        delegate = nil
        dataSource = nil
        defaultViewState = nil
        state = nil
    }
}

extension RHViewState {
    /// Show view state
    public func show(_ state: RHViewCollectionState? = nil) {
        self.state = state
        hidden = false
        defaultViewState.play()
    }
    
    public func hide() {
        hidden = true
    }
    
    /// Show loading in viewstate
    public func showLoader() {
        defaultViewState.showLoader()
        hidden = false
    }
    
    /// Hide loading in viewstate
    public func hideLoader() {
        defaultViewState.hideLoader()
        hidden = true
    }
}

extension RHViewState {
    /// Handle tap button
    private func didTapButton(_ button: UIButton) {
        delegate?.viewState(self, didTapButton: button)
    }
}

extension RHViewState {
    fileprivate func configureViewStateConstraint(with containerView: UIView!) {
        defaultViewState.frame = containerView.frame
        
        containerView.addSubview(defaultViewState)
        
        defaultViewState.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }
}
