//
//  NowPlayingModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

struct NowPlayingModel: Decodable {
    let id: Int
    let originalTitle: String
    let posterPath: String
}
