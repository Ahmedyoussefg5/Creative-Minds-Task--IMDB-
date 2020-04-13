//
//  LoginPresenter.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation
import Alamofire

class MoviesTypesViewModel {
    var type: MovieType
    var isSelected: Bool
    
    init(type: MovieType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
}

protocol AllMoviesPresenterProtocol {
    func getDataForSelectedType()
    func getTypesCount() -> Int
    func getDataFor(index: Int) -> MoviesTypesViewModel
    func selectType(at index: Int)
    
    func getMoviesCount() -> Int
    func getMovie(at index: Int) -> Movie?
}

class AllMoviesPresenter: AllMoviesPresenterProtocol {
    
    func getMovie(at index: Int) -> Movie? {
        guard let selectedType = moviesTypesViewModel.first(where: { $0.isSelected })?.type else { return nil }
        
        switch selectedType {
        case .topRated:
            return movieLists.topRated?[index]
        case .popular:
            return movieLists.popular?[index]
        case .comingSoon:
            return movieLists.upcoming?[index]
        case .nowPlaying:
            return movieLists.nowPlaying?[index]
        }
        
    }
    
    func getMoviesCount() -> Int {
        guard let selectedType = moviesTypesViewModel.first(where: { $0.isSelected })?.type else { return 0 }
                
        switch selectedType {
        case .topRated:
            return movieLists.topRated?.count ?? 0
        case .popular:
            return movieLists.popular?.count ?? 0
        case .comingSoon:
            return movieLists.upcoming?.count ?? 0
        case .nowPlaying:
            return movieLists.nowPlaying?.count ?? 0
        }
    }
    
    
    func selectType(at index: Int) {
        _ = moviesTypesViewModel.map({ $0.isSelected = false })
        moviesTypesViewModel[index].isSelected = true
    }
    
    
    func getTypesCount() -> Int {
        return moviesTypesViewModel.count
    }
    
    func getDataFor(index: Int) -> MoviesTypesViewModel {
        return moviesTypesViewModel[index]
    }
    
    private weak var view: AllMoviesViewProtocol?
    private let homeRepository: HomeRepositoryProtocol
    
    private lazy var movieLists = MovieLists(popular: [], topRated: [], upcoming: [], nowPlaying: [])
    
    private var moviesTypesViewModel: [MoviesTypesViewModel] = [
        .init(type: .topRated, isSelected: false),
        .init(type: .popular, isSelected: false),
        .init(type: .comingSoon, isSelected: false),
        .init(type: .nowPlaying, isSelected: false),
    ]
    
    
    init(view: AllMoviesViewProtocol, authRepository: HomeRepositoryProtocol, selectedType: MovieType) {
        self.view = view
        self.homeRepository = authRepository
        
        moviesTypesViewModel.first(where: { $0.type == selectedType })?.isSelected = true
    }
    
    fileprivate func handleResponse(_ result: Result<MovieResponse>) -> [Movie] {
        view?.hideActivityIndicator()
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
    
    func getDataForSelectedType() {
        view?.showActivityIndicator()
        
        guard let selectedType = moviesTypesViewModel.first(where: { $0.isSelected })?.type else { return }
        
        switch selectedType {
        case .topRated:
            getTopRated()
        case .popular:
            getPopular()
        case .comingSoon:
            getUpcoming()
        case .nowPlaying:
            getNowPlaying()
        }
    }
    
    func getTopRated() {
        homeRepository.getTopRated {[weak self] result in
            self?.movieLists.topRated = self?.handleResponse(result)
            self?.view?.dataTaskDone()
        }
    }
    
    func getPopular() {
        homeRepository.getPopular {[weak self] result in
            self?.movieLists.popular = self?.handleResponse(result)
            self?.view?.dataTaskDone()
        }
    }
    
    func getUpcoming() {
        homeRepository.getUpcoming {[weak self] result in
            self?.movieLists.upcoming = self?.handleResponse(result)
            self?.view?.dataTaskDone()
        }
    }
    
    func getNowPlaying() {
        homeRepository.getNowPlaying {[weak self] result in
            self?.movieLists.nowPlaying = self?.handleResponse(result)
            self?.view?.dataTaskDone()
        }
    }
}
