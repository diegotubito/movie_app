//
//  FetchTopRatedUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchTopRatedUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute() async throws -> TopRatedEntity.Response
}

class FetchTopRatedUseCase: FetchTopRatedUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol = MovieRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func excecute() async throws -> TopRatedEntity.Response {
        let request = TopRatedEntity.Request()
        return try await repository.fetchTopRated(request: request)
    }
}


