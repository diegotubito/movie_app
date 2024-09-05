//
//  FetchUpcomingUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchUpcomingUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute() async throws -> UpcomingEntity.Response
}

class FetchUpcomingUseCase: FetchUpcomingUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol = MovieRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func excecute() async throws -> UpcomingEntity.Response {
        let request = UpcomingEntity.Request()
        return try await repository.fetchUpcoming(request: request)
    }
}

