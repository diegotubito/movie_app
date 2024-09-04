//
//  MovieRepositoryProtocol.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchPopularMovies(request: PopularEntity.Request) async throws -> PopularEntity.Response
    func fetchMoviePoster(request: PosterEntity.Request) async throws -> Data
}
