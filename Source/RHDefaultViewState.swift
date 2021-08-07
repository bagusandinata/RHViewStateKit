//
//  RHDefaultViewState.swift
//  Pods-RHViewStateKit_Example
//
//  Created by Bagus andinata on 18/07/21.
//

import UIKit
import SnapKit

class RHDefaultViewState: UIView {
    // MARK: - PROPERTY
    private let messageView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let coverImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var primaryButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(didTapPrimaryButton(_:)), for: .touchUpInside)
        return view
    }()
    
    private var gradientLayer: CAGradientLayer?
    
    private var DEFAULT_CONTENT = RHContent()
    
    private var DEFAULT_CONFIGURATION_VIEW = RHViewConfiguration()
    
    private var DEFAULT_CONFIGURATION_BUTTON = RHButtonConfiguration()
    
    private var DEFAULT_CONFIGURATION_TITLE = RHTitleConfiguration()
    
    private var DEFAULT_CONFIGURATION_DESCRIPTION = RHDescriptionConfiguration()
    
    private var DEFAULT_CONFIGURATION_IMAGE = RHImageConfiguration()
    
    private var DEFAULT_CONFIGURATION_POSITION = RHPositionConfiguration()
    
    private var loadingView: RHLoadingView {
        return loadingConfiguration.view
    }
    
    var loadingConfiguration = RHLoadingConfiguration() {
        didSet {
            configureUILoading()
        }
    }
    
    var actionButton: ((UIButton)->())?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(with: [coverImageView, messageView])
        messageView.addSubviews(with: [imageView, titleLabel, descriptionLabel, primaryButton])
        
        configureUILoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - METHODS
    
    /*
     - content : Data source for content
     - configView : Data source for view configuration
     - configButton : Data source for button configuration
     - configTitle : Data source for title configuration
     - configDescription : Data source for description configuration
     - configImage : Data source for image configuration
     - configPosition : Data source for position configuration
    */
    func configureDataSource(content: RHContent,
                             configView: RHViewConfiguration,
                             configButton: RHButtonConfiguration,
                             configTitle: RHTitleConfiguration,
                             configDescription: RHDescriptionConfiguration,
                             configImage: RHImageConfiguration,
                             configPosition: RHPositionConfiguration) {
        self.DEFAULT_CONTENT = content
        self.DEFAULT_CONFIGURATION_VIEW = configView
        self.DEFAULT_CONFIGURATION_BUTTON = configButton
        self.DEFAULT_CONFIGURATION_TITLE = configTitle
        self.DEFAULT_CONFIGURATION_DESCRIPTION = configDescription
        self.DEFAULT_CONFIGURATION_IMAGE = configImage
        self.DEFAULT_CONFIGURATION_POSITION = configPosition
        
        updateContent()
        updateUI()
    }
    
    // Update Content
    private func updateContent() {
        updateContentImage()
        updateContentTitle()
        updateContentDescription()
        updateContentButton()
    }
    
    // Update UI
    private func updateUI() {
        // Message configuration
        messageView.alpha = DEFAULT_CONFIGURATION_VIEW.alpha
        
        updateUIImage()
        updateUIButton()
        updateUIBackground()
        configurePosition(viewPosition: DEFAULT_CONFIGURATION_POSITION.view,
                          imagePosition: DEFAULT_CONFIGURATION_POSITION.image,
                          messagePosition: DEFAULT_CONFIGURATION_POSITION.text)
    }
    
    /// Make text alignment from message position
    fileprivate func makeTextAlignment(with messagePosition: RHTextPosition) -> NSTextAlignment {
        switch messagePosition {
        case .left:
            return .left
        case .right:
            return .right
        case .justify:
            return .justified
        default:
            return .center
        }
    }
    
    //MARK: - ACTION
    
    @objc
    private func didTapPrimaryButton(_ sender: UIButton) {
        actionButton?(sender)
    }
}

//MARK: - Update Content

extension RHDefaultViewState {
    /// Update content image
    fileprivate func updateContentImage() {
        switch DEFAULT_CONFIGURATION_POSITION.image {
        case .cover(_, _):
            coverImageView.image = nil
            coverImageView.image = DEFAULT_CONTENT.image
            imageView.image = nil
            imageView.isHidden = true
        default:
            coverImageView.image = nil
            imageView.image = nil
            imageView.image = DEFAULT_CONTENT.image
            imageView.isHidden = false
        }
    }
    
    /// Update content title
    fileprivate func updateContentTitle() {
        if let title = DEFAULT_CONTENT.title {
            titleLabel.isHidden = false
            titleLabel.attributedText = NSAttributedString(string: title, attributes: DEFAULT_CONFIGURATION_TITLE.attributes)
        } else {
            titleLabel.isHidden = true
        }
    }
    
    /// Update content description
    fileprivate func updateContentDescription() {
        if let description = DEFAULT_CONTENT.description {
            descriptionLabel.isHidden = false
            descriptionLabel.attributedText = NSAttributedString(string: description, attributes: DEFAULT_CONFIGURATION_DESCRIPTION.attributes)
        } else {
            descriptionLabel.isHidden = true
        }
    }
    
    /// Update content primary button
    fileprivate func updateContentButton() {
        if let titleButton = DEFAULT_CONTENT.titleButton,
           !titleButton.isEmpty {
            primaryButton.isHidden = false
            primaryButton.setAttributedTitle(NSAttributedString(string: titleButton, attributes: DEFAULT_CONFIGURATION_BUTTON.attributes), for: .normal)
        } else {
            primaryButton.isHidden = true
        }
    }
}

//MARK: - Update UI

extension RHDefaultViewState {
    /// Update UI image
    fileprivate func updateUIImage() {
        if let imageTintColor = DEFAULT_CONFIGURATION_IMAGE.tintColor {
            imageView.tintColor = imageTintColor
            coverImageView.tintColor = imageTintColor
        } else {
            imageView.tintColor = .systemBlue
            coverImageView.tintColor = .systemBlue
        }
    }
    
    /// Update UI button
    fileprivate func updateUIButton() {
        primaryButton.backgroundColor = DEFAULT_CONFIGURATION_BUTTON.color
        primaryButton.layer.shadowColor = DEFAULT_CONFIGURATION_BUTTON.color.cgColor
        primaryButton.layer.shadowOffset = CGSize(width: 0.0, height: 0)
        primaryButton.layer.masksToBounds = false
        primaryButton.layer.shadowRadius = DEFAULT_CONFIGURATION_BUTTON.shadowRadius
        primaryButton.layer.shadowOpacity = DEFAULT_CONFIGURATION_BUTTON.shadowOpacity
        primaryButton.layer.borderWidth = DEFAULT_CONFIGURATION_BUTTON.borderWidth
        primaryButton.layer.borderColor = DEFAULT_CONFIGURATION_BUTTON.borderColor?.cgColor
        
        switch DEFAULT_CONFIGURATION_BUTTON.cornerType {
        case .capsule:
            primaryButton.layer.cornerRadius = DEFAULT_CONFIGURATION_BUTTON.height*0.5
        case .custom(let radius):
            primaryButton.layer.cornerRadius = radius
        case .none:
            primaryButton.layer.cornerRadius = 0
        }
    }
    
    /// Update UI background
    fileprivate func updateUIBackground() {
        // Background gradient configuration
        if let gradientColor = DEFAULT_CONFIGURATION_VIEW.gradientColor {
            gradientLayer?.removeFromSuperlayer()
            gradientLayer = CAGradientLayer()
            gradientLayer?.colors = [gradientColor.0.cgColor, gradientColor.1.cgColor]
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer?.locations = [0, 1]
            gradientLayer?.frame = bounds
            layer.insertSublayer(gradientLayer!, at: 0)
        } else {
            gradientLayer?.removeFromSuperlayer()
            // Background configuration
            backgroundColor = DEFAULT_CONFIGURATION_VIEW.backgroundColor
        }
    }
    
    /// Update UI background loading
    fileprivate func updateUIBackgroundLoading() {
        gradientLayer?.removeFromSuperlayer()
        backgroundColor = loadingConfiguration.backgroundColor
    }
    
    /// Update UI loading
    fileprivate func configureUILoading() {
        loadingView.removeFromSuperview()
        loadingView.isHidden = true
        addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(loadingConfiguration.size)
        }
        
        loadingView.updateUI()
        guard let loadingView = loadingView as? RHDefaultLoading else { return }
        loadingView.color = loadingConfiguration.color
    }
}

//MARK: - Configure Constraint

extension RHDefaultViewState {
    fileprivate func configurePosition(viewPosition: RHViewPosition, imagePosition: RHImagePosition, messagePosition: RHTextPosition) {
        configureView(in: viewPosition)
        
        switch imagePosition {
        case .top:
            topImage(in: messagePosition)
        case .bottom:
            bottomImage(in: messagePosition)
        case .cover(let topConstraint, let bottomConstraint):
            coverImage(in: messagePosition, topConstraint: topConstraint, bottomConstraint: bottomConstraint)
        }
    }
    
    //MARK: Configure View Position
    
    private func configureView(in position: RHViewPosition) {
        messageView.snp.remakeConstraints { make in
            make.leading.equalTo(self).offset(DEFAULT_CONFIGURATION_VIEW.horizontalConstraint)
            make.trailing.equalTo(self).offset(-DEFAULT_CONFIGURATION_VIEW.horizontalConstraint)
            switch position {
            case .top:
                make.top.equalTo(self).offset(DEFAULT_CONFIGURATION_VIEW.verticalConstraint)
            case .center:
                make.centerY.equalTo(self)
            case .bottom:
                make.bottom.equalTo(self).offset(-DEFAULT_CONFIGURATION_VIEW.verticalConstraint)
            }
        }
    }
    
    //MARK: Configure Image Position
    
    private func topImage(in position: RHTextPosition) {
        coverImageView.snp.removeConstraints()
        
        imageView.snp.remakeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(DEFAULT_CONFIGURATION_IMAGE.size)
        }
        
        titleLabel.textAlignment = makeTextAlignment(with: position)
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(DEFAULT_CONFIGURATION_TITLE.topConstraint)
            make.trailing.leading.equalToSuperview()
        }
        
        descriptionLabel.textAlignment = makeTextAlignment(with: position)
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DEFAULT_CONFIGURATION_DESCRIPTION.topConstraint)
            make.trailing.leading.equalToSuperview()
        }
        
        primaryButton.snp.remakeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(DEFAULT_CONFIGURATION_BUTTON.topConstraint)
            configureButton(in: position, withConstraintMaker: make)
        }
    }
    
    private func bottomImage(in position: RHTextPosition) {
        coverImageView.snp.removeConstraints()
        
        titleLabel.textAlignment = makeTextAlignment(with: position)
        titleLabel.snp.remakeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
        }
        
        descriptionLabel.textAlignment = makeTextAlignment(with: position)
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DEFAULT_CONFIGURATION_DESCRIPTION.topConstraint)
            make.trailing.leading.equalToSuperview()
        }
        
        imageView.snp.remakeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(DEFAULT_CONFIGURATION_IMAGE.topConstraint)
            make.size.equalTo(DEFAULT_CONFIGURATION_IMAGE.size)
            make.centerX.equalToSuperview()
        }
        
        primaryButton.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(DEFAULT_CONFIGURATION_BUTTON.topConstraint)
            configureButton(in: position, withConstraintMaker: make)
        }
    }
    
    private func coverImage(in position: RHTextPosition, topConstraint: TopConstraint, bottomConstraint: BottomConstraint) {
        imageView.snp.removeConstraints()
        
        coverImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(topConstraint)
            make.bottom.equalToSuperview().offset(-bottomConstraint)
            make.trailing.leading.equalToSuperview()
        }
        
        titleLabel.textAlignment = makeTextAlignment(with: position)
        titleLabel.snp.remakeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
        }
        
        descriptionLabel.textAlignment = makeTextAlignment(with: position)
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DEFAULT_CONFIGURATION_DESCRIPTION.topConstraint)
            make.trailing.leading.equalToSuperview()
        }
        
        primaryButton.snp.remakeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(DEFAULT_CONFIGURATION_BUTTON.topConstraint)
            configureButton(in: position, withConstraintMaker: make)
        }
    }
    
    // MARK: Configure Button Position
    
    private func configureButton(in position: RHTextPosition, withConstraintMaker make: ConstraintMaker) {
        make.bottom.equalTo(messageView).offset(0)
        make.height.equalTo(DEFAULT_CONFIGURATION_BUTTON.height)
        
        switch position {
        case .center, .justify:
            make.centerX.equalToSuperview()
        case .left:
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        case .right:
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.equalToSuperview()
        }
        
        if let width = DEFAULT_CONFIGURATION_BUTTON.width {
            make.width.equalTo(width)
        } else {
            guard let titleWidth = primaryButton.titleLabel?.textWidth else { return }
            
            let insetTitle = DEFAULT_CONFIGURATION_BUTTON.titleInset*2
            let targetWidth = titleWidth + insetTitle
            
            make.width.equalTo(targetWidth)
        }
    }
}

// MARK: - Animations

extension RHDefaultViewState {
    // Fade animation
    func fade(_ duration1: TimeInterval, _ duration2: TimeInterval) {
        
        coverImageView.alpha = 0
        imageView.alpha = 0
        titleLabel.alpha = 0
        descriptionLabel.alpha = 0
        primaryButton.alpha = 0
        
        UIView.animate(withDuration: duration1, animations: { [weak self] in
            self?.titleLabel.alpha = 1
            self?.descriptionLabel.alpha = 1
            self?.primaryButton.alpha = 1
        }) { [weak self](completed) in
            UIView.animate(withDuration: duration2, animations: { [weak self] in
                self?.coverImageView.alpha = 1
                self?.imageView.alpha = 1
            }, completion: nil)
        }
    }
    
    // Scale animation
    func scale(_ duration1: TimeInterval, _ duration2: TimeInterval) {
        
        coverImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        imageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        titleLabel.alpha = 0
        descriptionLabel.alpha = 0
        primaryButton.alpha = 0
        
        UIView.animate(withDuration: duration1, animations: { [weak self] in
            self?.titleLabel.alpha = 1
            self?.descriptionLabel.alpha = 1
            self?.primaryButton.alpha = 1
        }) { [weak self](completed) in
            UIView.animate(withDuration: duration2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: { [weak self] in
                self?.coverImageView.transform = .identity
                self?.imageView.transform = .identity
            }, completion: nil)
        }
    }
}

extension RHDefaultViewState {
    /// Play image animation
    func play() {
        DEFAULT_CONFIGURATION_IMAGE.animation?.play?(self)
    }
    
    /// Show loading
    func showLoader() {
        coverImageView.isHidden = true
        messageView.isHidden = true
        loadingView.isHidden = false
        loadingView.startAnimating()
        updateUIBackgroundLoading()
    }
    
    /// Hide loading
    func hideLoader() {
        coverImageView.isHidden = false
        messageView.isHidden = false
        loadingView.isHidden = true
        loadingView.stopAnimating()
        updateUIBackground()
    }
}

// MARK: - Model Content

extension RHDefaultViewState {
    struct RHContent {
        var image: UIImage?
        var title: String?
        var description: String?
        var titleButton: String?
    }
}
