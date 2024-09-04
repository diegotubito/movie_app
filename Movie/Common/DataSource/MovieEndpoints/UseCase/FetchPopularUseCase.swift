//
//  FetchPopularUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchPopularUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute() async throws -> PopularEntity.Response
}

class FetchPopularUseCase: FetchPopularUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: any MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func excecute() async throws -> PopularEntity.Response {
        let request = PopularEntity.Request()
        return try await repository.fetchPopularMovies(request: request)
    }
}
