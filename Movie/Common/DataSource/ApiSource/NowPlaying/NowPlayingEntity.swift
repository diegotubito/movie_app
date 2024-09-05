//
//  NowPlayingEntity.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

struct NowPlayingEntity {
    struct Request: Encodable { }
    
    struct Response: Decodable {
        let results: [NowPlayingModel]
    }
}


