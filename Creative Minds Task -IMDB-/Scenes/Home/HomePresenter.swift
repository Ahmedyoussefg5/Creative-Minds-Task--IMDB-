//
//  LoginPresenter.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation
import Alamofire

protocol HomePresenterProtocol {
    func getData()
    
    func getPopularMoviesCount() -> Int
    func getTopRatedMoviesCount() -> Int
    func getUpcomingMoviesCount() -> Int
    func getNowPlayingMoviesCount() -> Int
    
    func getData(for type: MovieType) -> [Movie]
    
    func getmovieTypesCount() -> Int
    func getmovieType(at index: Int) -> MovieRowsState
    
    func handelArrowAction(_ type: MovieType)
}

class HomePresenter: HomePresenterProtocol {
    
    func getmovieTypesCount() -> Int {
        return movieTypes.count
    }
    
    func getmovieType(at index: Int) -> MovieRowsState {
        return movieTypes[index]
    }
    
    func handelArrowAction(_ type: MovieType) {
        if let data = movieTypes.first(where: { $0.type == type }) {
            if data.isExpanded {
                data.isExpanded.toggle()
                view?.deleteRow(at: type.sectionNumber)
            } else {
                data.isExpanded.toggle()
                view?.indsertRow(at: type.sectionNumber)
            }
        }
    }
    
    func getData(for type: MovieType) -> [Movie] {
        switch type {
        case .topRated:
            return movieLists.topRated ?? []
        case .popular:
            return movieLists.popular ?? []
        case .comingSoon:
            return movieLists.upcoming ?? []
        case .nowPlaying:
            return movieLists.nowPlaying ?? []
        }
    }
    
    func getPopularMoviesCount() -> Int {
        return movieLists.popular?.count ?? 0
    }
    
    func getTopRatedMoviesCount() -> Int {
        return movieLists.topRated?.count ?? 0
    }
    
    func getUpcomingMoviesCount() -> Int {
        return movieLists.upcoming?.count ?? 0
    }
    
    func getNowPlayingMoviesCount() -> Int {
        return movieLists.nowPlaying?.count ?? 0
    }
    
    
    weak var view: HomeViewProtocol?
    private let homeRepository: HomeRepositoryProtocol
    
    private lazy var movieLists = MovieLists(popular: [], topRated: [], upcoming: [], nowPlaying: [])
    
    private lazy var movieTypes: [MovieRowsState] = [
        .init(type: .topRated),
        .init(type: .popular),
        .init(type: .comingSoon),
        .init(type: .nowPlaying)
    ]
    
    init(view: HomeViewProtocol, authRepository: HomeRepositoryProtocol) {
        self.view = view
        self.homeRepository = authRepository
    }
    
    fileprivate func handleResponse(_ result: Result<MovieResponse>) -> [Movie] {
        switch result {
        case .success(let movieData):
            
            if let error = movieData.statusMessage {
                view?.showAlert(message: error)
            }
            
            return movieData.results ?? []
            
        case .failure(let error):
            return []
            view?.showAlert(message: error.localizedDescription)
        }
    }
    
    func getData() {
        view?.showActivityIndicator()
        
        // Using DispatchGroup To Avoid Nested Closures
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        homeRepository.getTopRated {[weak self] result in
            dispatchGroup.leave()
            self?.movieLists.topRated = self?.handleResponse(result)
        }
        
        dispatchGroup.enter()
        self.homeRepository.getPopular {[weak self] result in
            dispatchGroup.leave()
            self?.movieLists.popular = self?.handleResponse(result)
        }
        
        dispatchGroup.enter()
        self.homeRepository.getUpcoming {[weak self] result in
            dispatchGroup.leave()
            self?.movieLists.upcoming = self?.handleResponse(result)
        }
        
        dispatchGroup.enter()
        self.homeRepository.getNowPlaying {[weak self] result in
            self?.movieLists.nowPlaying = self?.handleResponse(result)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {[weak self] in
            self?.view?.hideActivityIndicator()
            self?.view?.dataTaskSuccess()
        }
    }
}
