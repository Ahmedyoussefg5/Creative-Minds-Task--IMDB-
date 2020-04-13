//
//  MoviesTypesViewModel.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/14/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation

class MoviesTypesViewModel {
    var type: MovieType
    var isSelected: Bool
    
    init(type: MovieType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
}
