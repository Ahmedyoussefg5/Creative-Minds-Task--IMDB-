//
//  MovieRowsState.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation

class MovieRowsState {
    var isExpanded: Bool = Bool.random()
    var type: MovieType
    
    init(type: MovieType) {
        self.type = type
    }
}

enum MovieType {
    case topRated
    case popular
    case comingSoon
    case nowPlaying
    
    var title: String {
        switch self {
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        case .comingSoon:
            return "Coming Soon"
        case .nowPlaying:
            return "Now Playing"
        }
    }
    
    var sectionNumber: Int {
        switch self {
        case .topRated:
            return 0
        case .popular:
            return 1
        case .comingSoon:
            return 2
        case .nowPlaying:
            return 3
        }
    }
}
