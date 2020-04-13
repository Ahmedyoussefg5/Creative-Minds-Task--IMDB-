//
//  Movie.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let popularity: Double?
    let posterPath: String?
    let overview: String?
    let backdropPath: String?
    let genreIDS: [Int]?
    let originalLanguage: String?
    let voteAverage: Double?
    let originalTitle: String?
    let video: Bool?
    let voteCount: Int?
    let releaseDate: String?
    let id: Int?
    let adult: Bool?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case posterPath = "poster_path"
        case overview
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case voteAverage = "vote_average"
        case originalTitle = "original_title"
        case video
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case id, adult, title
    }
}
