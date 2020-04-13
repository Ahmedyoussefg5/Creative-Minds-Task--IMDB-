//
//  Constants.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation

struct Constants {
    
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    
    static let apiKey = "d5b759f1645a495f85b519e58a812f32"
    
    static let imageBaseUrl = "http://image.tmdb.org/t/p/w185/"
    
    enum AuthEndpoints {
        static let popular = "popular"
        static let topRated = "top_rated"
        static let upcoming = "upcoming"
        static let nowPlaying = "now_playing"
    }
}
