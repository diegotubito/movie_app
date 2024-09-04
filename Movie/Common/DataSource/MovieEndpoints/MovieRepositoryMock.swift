//
//  MovieRepositoryMock.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

class MovieRepositoryMock: ApiNetworkMock, MovieRepositoryProtocol {
    func fetchPopularMovies(request: PopularEntity.Request) async throws -> PopularEntity.Response {
        mockFileName = "popular_mock_success_response"
        return try await apiCallMocked(bundle: .main)
    }
    
    func fetchMoviePoster(request: PosterEntity.Request) async throws -> Data {
        return try await apiCallMocked(bundle: .main)
    }
}
