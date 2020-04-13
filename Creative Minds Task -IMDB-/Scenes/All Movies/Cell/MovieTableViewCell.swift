//
//  MovieTableViewCell.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/14/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let posterImagView = UIImageView()
    
    private let nameLable = UILabel()
    private let genderLable = UILabel()
    private let rateLable = UILabel()
    
    private let descLable = UILabel()


    fileprivate func setupCellView() {
        selectionStyle = .none
        
        containerView.layer.applySketchShadow()
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.widthAnchorWithMultiplier(multiplier: 0.9)
        containerView.centerXInSuperview()
        containerView.heightAnchorConstant(constant: 100)
        containerView.topAnchorSuperView(constant: 50)
        
        
        backgroundColor = .clear
        posterImagView.layer.cornerRadius = 5
        posterImagView.clipsToBounds = true
        contentView.addSubview(posterImagView)
        posterImagView.topAnchorSuperView(constant: 10)
        posterImagView.leadingAnchorToView(anchor: containerView.leadingAnchor, constant: 10)
        posterImagView.heightAnchorConstant(constant: 120)
        posterImagView.widthAnchorConstant(constant: 100)
        
        let stack = UIStackView(arrangedSubviews: [
            nameLable, genderLable, rateLable
        ])
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        
        containerView.addSubview(stack)
        stack.leadingAnchorToView(anchor: posterImagView.trailingAnchor, constant: 10)
        stack.topAnchorSuperView(constant: 10)
        stack.trailingAnchorAnchorSuperView(constant: -10)
        stack.heightAnchorConstant(constant: 60)
        
        descLable.numberOfLines = 0
        descLable.textAlignment = .center
        descLable.font = .systemFont(ofSize: 13, weight: .medium)
        contentView.addSubview(descLable)
        descLable.topAnchorToView(anchor: containerView.bottomAnchor, constant: 10)
        descLable.widthAnchorWithMultiplier(multiplier: 0.95)
        descLable.bottomAnchorSuperView(constant: -10)
        descLable.centerXInSuperview()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(_ data: Movie) {
        posterImagView.loadImageData(url: Constants.imageBaseUrl + (data.posterPath ?? ""))
        nameLable.text = data.originalTitle
        genderLable.text = data.originalLanguage
        rateLable.text = "Rate: \(data.voteAverage ?? 0.0)"
        descLable.text = data.overview
    }
}
