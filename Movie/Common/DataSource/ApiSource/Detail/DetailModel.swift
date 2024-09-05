//
//  DetailModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

struct DetailModel: Decodable, Identifiable, Hashable {
    var id: UUID? = UUID()
    let _id: Int
    
    var title: String
    var originalTitle: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String
    var runtime: Int
    var voteAverage: Double
    let tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case title
        case originalTitle
        case overview
        case posterPath
        case backdropPath
        case releaseDate
        case runtime
        case voteAverage
        case tagline
    }

    var posterImageData: Data?
    var backgroundPosterImageData: Data?

}
