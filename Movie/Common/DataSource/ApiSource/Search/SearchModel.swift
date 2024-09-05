//
//  SearchModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

struct SearchModel: Decodable, Identifiable, Hashable {
    var id: UUID? = UUID()
    let _id: Int
    let originalTitle: String
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case originalTitle
        case posterPath
        case releaseDate
        case voteAverage
    }
    
    var posterImageData: Data?
}

