//
//  MovieEntity.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

struct PopularEntity {
    struct Request: Encodable { }
    
    struct Response: Decodable {
        let results: [PopularModel]
    }
}

struct PosterEntity {
    struct Request: Encodable {
        let path: String
    }
  
}
