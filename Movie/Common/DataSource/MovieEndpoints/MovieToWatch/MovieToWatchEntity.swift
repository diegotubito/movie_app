//
//  MovieToWatchEntity.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

struct MovieToWatchEntity {
    struct Request: Encodable { 
        let id: String
    }
    
    struct Response: Decodable {
        let results: [MovieToWatchModel]
    }
}



