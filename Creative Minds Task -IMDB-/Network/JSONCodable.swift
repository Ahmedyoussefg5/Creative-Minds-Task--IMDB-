//
//  JSONCodable+.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import Foundation

extension JSONDecoder {
    static func decodeFromData<U: Codable>(_ model: U.Type, data: Data) throws -> U {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(U.self, from: data)
        } catch let error {
            debugPrint(error)
            throw error
        }
    }
}
