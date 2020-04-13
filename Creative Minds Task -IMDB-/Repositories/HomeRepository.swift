//
//  HomeRepository.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation
import Alamofire

typealias MovieResponse = BaseModel<[Movie]>

protocol HomeRepositoryProtocol {
    func getPopular(completionHandler: @escaping (Result<MovieResponse>) -> ())
    func getTopRated(completionHandler: @escaping (Result<MovieResponse>) -> ())
    func getUpcoming(completionHandler: @escaping (Result<MovieResponse>) -> ())
    func getNowPlaying(completionHandler: @escaping (Result<MovieResponse>) -> ())
}

class HomeRepository: HomeRepositoryProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getPopular(completionHandler: @escaping (Result<MovieResponse>) -> ()) {
        network.request(AppRouter.popular, decodeTo: MovieResponse.self, completionHandler: completionHandler)
    }
    
    func getTopRated(completionHandler: @escaping (Result<MovieResponse>) -> ()) {
        network.request(AppRouter.topRated, decodeTo: MovieResponse.self, completionHandler: completionHandler)
    }
    
    func getUpcoming(completionHandler: @escaping (Result<MovieResponse>) -> ()) {
        network.request(AppRouter.upcoming, decodeTo: MovieResponse.self, completionHandler: completionHandler)
    }
    
    func getNowPlaying(completionHandler: @escaping (Result<MovieResponse>) -> ()) {
        network.request(AppRouter.nowPlaying, decodeTo: MovieResponse.self, completionHandler: completionHandler)
    }
}
