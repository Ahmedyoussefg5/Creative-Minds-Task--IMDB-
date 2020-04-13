//
//  BaseCodable.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation

protocol BaseCodable: Codable {
    var success: Bool? { get set }
    var statusCode: Int? { get set }
    var statusMessage: String? { get set }
}

// MARK: - BaseModel
struct BaseModel<T: Codable>: BaseCodable {
    var success: Bool?
    var statusCode: Int?
    var statusMessage: String?
    var results: T?

    enum CodingKeys: String, CodingKey {
        case success, results
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
