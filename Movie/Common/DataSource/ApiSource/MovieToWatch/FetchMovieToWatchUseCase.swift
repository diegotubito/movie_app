//
//  FetchMovieToWatchUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchMovieToWatchUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute(_id: String) async throws -> MovieToWatchEntity.Response
}

class FetchMovieToWatchUseCase: FetchMovieToWatchUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol = MovieRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func excecute(_id: String) async throws -> MovieToWatchEntity.Response {
        let request = MovieToWatchEntity.Request(_id: _id)
        return try await repository.fetchMovieToWatch(request: request)
    }
}


