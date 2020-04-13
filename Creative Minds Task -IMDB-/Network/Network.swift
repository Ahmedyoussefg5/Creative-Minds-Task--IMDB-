//
//  Network.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Alamofire
import SwiftyJSON

typealias NetworkCompletion<T> = (Result<T>) -> ()

protocol NetworkProtocol {
    func request<T>(_ request: URLRequestConvertible, decodeTo type: T.Type, completionHandler: @escaping NetworkCompletion<T>) where T: Codable
    func upload<T>(_ request: URLRequestConvertible, data: [UploadData], decodedTo type: T.Type, completionHandler: @escaping NetworkCompletion<T>) where T: Codable
    func cancelAllRequests()
}

class Network: NetworkProtocol {
    
    private let networkMiddleware = NetworkMiddleware()
    
    //Use a networkmiddleware to append the headers globally
    private lazy var manager: SessionManager = {
        let manager = networkMiddleware.sessionManager
        manager.adapter = networkMiddleware
        return manager
    }()
    
    func request<T>(_ request: URLRequestConvertible, decodeTo type: T.Type, completionHandler: @escaping (Result<T>) -> ()) where T: Codable {
        manager.request(request).debugLog().responseJSON { [weak self] response in
            guard let self = self else { return }
            completionHandler(self.process(response: response, decodedTo: type))
        }
    }
    
    func upload<T>(_ request: URLRequestConvertible, data: [UploadData], decodedTo type: T.Type, completionHandler: @escaping (Result<T>) -> ()) where T : Decodable, T : Encodable {
        manager.upload(multipartFormData: { multipart in
            
            data.forEach {
                multipart.append($0.data, withName: $0.name, fileName: $0.fileName, mimeType: $0.mimeType)
            }
            
            for (key, value) in request.parameters ?? [:] {
                multipart.append("\(value)".data(using: .utf8)!, withName: key)
            }
            

        }, with: request) { encodingCompletion in
            switch encodingCompletion {
            case .success(let request, _, _):
                request.responseJSON { [weak self] response in
                    guard let self = self else { return }
                    completionHandler(self.process(response: response, decodedTo: type))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func process<T>(response: DataResponse<Any>, decodedTo type: T.Type) -> Result<T> where T: Codable {
        switch response.result {
        case .success:
            
            guard let data = response.data else {
                return .failure(NSError.create(description: "Something went wrong"))
            }
            
            #if DEBUG
                print(JSON(response.value ?? [:]))
            #endif
            
            do {
                let data = try JSONDecoder.decodeFromData(type, data: data)
                return .success(data)
            } catch {
                #if DEBUG
                    debugPrint(error)
                #endif
                
                return .failure(NSError.create(description: "Something went wrong"))
            }
            
        case .failure(let error):
            #if DEBUG
                debugPrint("#DEBUG#", error.localizedDescription)
            #endif
            
            if error.localizedDescription.contains("JSON") {
                return .failure(NSError.create(description: "Something went wrong"))
            }
            
            return .failure(error)
        }
    }
    
    func cancelAllRequests() {
        manager.session.getAllTasks { tasks in tasks.forEach { $0.cancel() } }
    }
}
