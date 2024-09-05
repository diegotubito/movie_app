//
//  FetchDetailUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchDetailUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute(id: String) async throws -> DetailEntity.Response
}

class FetchDetailUseCase: FetchDetailUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol = MovieRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func excecute(id: String) async throws -> DetailEntity.Response {
        let request = DetailEntity.Request(id: id)
        return try await repository.fetchDetailMovie(request: request)
    }
}


