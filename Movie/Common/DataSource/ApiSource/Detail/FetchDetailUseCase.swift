//
//  FetchDetailUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchDetailUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute(_id: Int) async throws -> DetailModel
}

class FetchDetailUseCase: FetchDetailUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol = MovieRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func excecute(_id: Int) async throws -> DetailModel {
        let request = DetailEntity.Request(_id: String(_id))
        return try await repository.fetchDetailMovie(request: request)
    }
}


