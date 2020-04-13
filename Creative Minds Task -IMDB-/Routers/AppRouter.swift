//
//  AppRouter.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation
import Alamofire

enum AppRouter: URLRequestConvertible {
    
    case popular
    case topRated
    case upcoming
    case nowPlaying
    
    var method: HTTPMethod {
        switch self {
        case .popular:
            return .get
        case .topRated:
            return .get
        case .upcoming:
            return .get
        case .nowPlaying:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .popular:
            return ["api_key": Constants.apiKey]
        case .topRated:
            return ["api_key": Constants.apiKey]
        case .upcoming:
            return ["api_key": Constants.apiKey]
        case .nowPlaying:
            return ["api_key": Constants.apiKey]
        }
    }
    
    var url: URL {
        let endpoint: String
        
        switch self {
        case .popular:
            endpoint = Constants.AuthEndpoints.popular
        case .topRated:
            endpoint = Constants.AuthEndpoints.topRated
        case .upcoming:
            endpoint = Constants.AuthEndpoints.upcoming
        case .nowPlaying:
            endpoint = Constants.AuthEndpoints.nowPlaying
        }
        
        return URL(string: Constants.baseUrl)!.appendingPathComponent(endpoint)
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}
