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
    
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double
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
