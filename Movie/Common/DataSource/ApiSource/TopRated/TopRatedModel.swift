//
//  TopRatedModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

struct TopRatedModel: Decodable, Identifiable, Hashable {
    var id: UUID? = UUID() 
    let _id: Int
    let originalTitle: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case originalTitle
        case posterPath
    }
    
    var posterImageData: Data?
}

