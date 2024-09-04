//
//  FetchPosterUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchPosterUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute(path: String) async throws -> Data
}

class FetchPosterUseCase: FetchPosterUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: any MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func excecute(path: String) async throws -> Data {
        let request = PosterEntity.Request(path: path)
        return try await repository.fetchMoviePoster(request: request)
    }
}
