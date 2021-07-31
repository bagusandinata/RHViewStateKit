//
//  ItemTableViewCell.swift
//  RHViewStateKit
//
//  Created by Bagus andinata on 21/07/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    //MARK: - PROPERTY
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.textColor = .black
        view.numberOfLines = 1
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .gray
        view.numberOfLines = 1
        return view
    }()
    
    let arrowRight: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ic-arrow-right"))
        view.contentMode = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(arrowRight)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - METHODS
    private func configureConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowRight.leadingAnchor, constant: -8)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowRight.leadingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
        
        arrowRight.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowRight.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowRight.widthAnchor.constraint(equalToConstant: 24),
            arrowRight.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    //MARK: - ACTION
    
}
