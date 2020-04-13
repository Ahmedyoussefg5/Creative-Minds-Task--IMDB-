//
//  MoviesTypesSliderCollectionViewCell.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

class MoviesTypesSliderCollectionViewCell: UICollectionViewCell {
    
    private let backView = UIView()
    private let nameLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backView.layer.cornerRadius = 7
        contentView.addSubview(backView)
        backView.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        nameLable.textAlignment = .center
        nameLable.font = .systemFont(ofSize: 15, weight: .medium)
        backView.addSubview(nameLable)
        nameLable.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(_ model: MoviesTypesViewModel) {
        nameLable.text = model.type.title
        if model.isSelected {
            let color = #colorLiteral(red: 0.3346029818, green: 0.3666692972, blue: 0.9529878497, alpha: 1)
            backView.backgroundColor = color
            nameLable.textColor = .white
            backView.layer.applySketchShadow(color: color.withAlphaComponent(0.5))
        } else {
            backView.backgroundColor = .white
            nameLable.textColor = .darkGray
            backView.layer.applySketchShadow(color: .clear)
        }
    }
}
