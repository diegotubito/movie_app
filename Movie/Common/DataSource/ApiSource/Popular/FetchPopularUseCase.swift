//
//  FetchPopularUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchPopularUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute() async throws -> PopularMovieEntity.Response
}

class FetchPopularUseCase: FetchPopularUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol = MovieRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func excecute() async throws -> PopularMovieEntity.Response {
        let request = PopularMovieEntity.Request()
        return try await repository.fetchPopularMovies(request: request)
    }
}
