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
    
    func fetchNowPlaying(request: NowPlayingEntity.Request) async throws -> NowPlayingEntity.Response {
        return try await apiCallMocked(bundle: .main)
    }
    
    func fetchUpcoming(request: UpcomingEntity.Request) async throws -> UpcomingEntity.Response {
        return try await apiCallMocked(bundle: .main)
    }
    
    func fetchTopRated(request: TopRatedEntity.Request) async throws -> TopRatedEntity.Response {
        return try await apiCallMocked(bundle: .main)
    }
    
    func fetchDetailMovie(request: DetailEntity.Request) async throws -> DetailEntity.Response {
        return try await apiCallMocked(bundle: .main)
    }
    
    func fetchSearch(request: SearchEntity.Request) async throws -> SearchEntity.Response {
        return try await apiCallMocked(bundle: .main)
    }
    
    func fetchMovieToWatch(request: MovieToWatchEntity.Request) async throws -> MovieToWatchEntity.Response {
        return try await apiCallMocked(bundle: .main)
    }
}
