//
//  MovieCollectionViewCell.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    private let posterImagView = UIImageView()
    
    fileprivate func setupCellView() {
        backgroundColor = .clear
        contentView.addSubview(posterImagView)
        posterImagView.fillSuperview()
        posterImagView.layer.cornerRadius = 5
        posterImagView.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(_ data: Movie) {
        posterImagView.loadImageData(url: Constants.imageBaseUrl + (data.posterPath ?? ""))
    }
}
