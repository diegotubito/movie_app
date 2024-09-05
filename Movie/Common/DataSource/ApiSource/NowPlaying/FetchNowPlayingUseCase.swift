//
//  FetchNowPlayingUseCase.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol FetchNowPlayingUseCaseProtocol {
    init(repository: MovieRepositoryProtocol)
    func excecute() async throws -> NowPlayingEntity.Response
}

class FetchNowPlayingUseCase: FetchNowPlayingUseCaseProtocol {
    var repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol = MovieRepositoryFactory.create()) {
        self.repository = repository
    }
    
    func excecute() async throws -> NowPlayingEntity.Response {
        let request = NowPlayingEntity.Request()
        return try await repository.fetchNowPlaying(request: request)
    }
}
