//
//  MovieRepositoryFactory.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

class MovieRepositoryFactory {
    static func create() -> MovieRepositoryProtocol {
        if ProcessInfo.processInfo.arguments.contains("ui-testing") {
            return MovieRepositoryMock()
        }
        return MovieRepository()
    }
}
