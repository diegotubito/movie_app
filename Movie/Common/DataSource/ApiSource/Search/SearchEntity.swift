//
//  SearchEntity.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

struct SearchEntity {
    struct Request: Encodable { 
        let query: String
    }
    
    struct Response: Decodable {
        let results: [SearchModel]
    }
}

