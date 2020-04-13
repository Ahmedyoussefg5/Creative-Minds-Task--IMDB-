//
//  NetworkMiddleware.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation
import Alamofire

class NetworkMiddleware: RequestAdapter {
    
    let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return SessionManager(configuration: configuration)
    }()
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("en", forHTTPHeaderField: "X-localization")
        urlRequest.setValue("os", forHTTPHeaderField: "ios")
        return urlRequest
    }
}
