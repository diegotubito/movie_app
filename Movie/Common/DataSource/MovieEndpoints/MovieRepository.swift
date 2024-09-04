//
//  MovieRepository.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchPopularMovies(request: PopularEntity.Request) async throws -> PopularEntity.Response
    func fetchMoviePoster(request: PosterEntity.Request) async throws -> Data
}

class MovieRepository: ApiNetwork, MovieRepositoryProtocol {
    func fetchPopularMovies(request: PopularEntity.Request) async throws -> PopularEntity.Response {
        config.serverType = .api
        config.path = "/3/movie/popular"
        config.addQueryItem(key: "language", value: "en-US")
        config.addQueryItem(key: "page", value: "1")
        config.method = .get
        return try await apiCall()
    }
    
    func fetchMoviePoster(request: PosterEntity.Request) async throws -> Data {
        config.serverType = .image
        config.path = "/t/p/w500\(request.path)"
        config.method = .get
        return try await apiCall()
    }
}
