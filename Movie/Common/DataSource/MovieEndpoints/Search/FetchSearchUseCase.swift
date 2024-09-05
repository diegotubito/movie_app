//
//  FetchSearchUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchSearchUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute(query: String) async throws -> SearchEntity.Response
}

class FetchSearchUseCase: FetchSearchUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol = MovieRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func excecute(query: String) async throws -> SearchEntity.Response {
        let request = SearchEntity.Request(query: query)
        return try await repository.fetchSearch(request: request)
    }
}

