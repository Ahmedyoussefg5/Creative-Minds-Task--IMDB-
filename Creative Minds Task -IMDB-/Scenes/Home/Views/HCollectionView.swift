//
//  HCollectionView.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

class HCollectionView: UICollectionView {
    init(backgroundColor: UIColor = .clear, isPagingEnabled: Bool = false) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        alwaysBounceHorizontal = true
        self.backgroundColor = backgroundColor
        self.isPagingEnabled = isPagingEnabled
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
