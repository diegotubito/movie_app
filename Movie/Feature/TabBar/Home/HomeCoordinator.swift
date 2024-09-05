//
//  HomeCoordinator.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

enum HomeScreen: Hashable {
    case detail(movieId: Int)
    case playMovie(movieId: Int)
}
