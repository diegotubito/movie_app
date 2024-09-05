//
//  MovieRepository.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

class MovieRepository: ApiNetwork, MovieRepositoryProtocol {
    
    func fetchPopularMovies(request: PopularMovieEntity.Request) async throws -> PopularMovieEntity.Response {
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
    
    func fetchNowPlaying(request: NowPlayingEntity.Request) async throws -> NowPlayingEntity.Response {
        config.serverType = .api
        config.path = "/3/movie/now_playing"
        config.addQueryItem(key: "language", value: "en-US")
        config.addQueryItem(key: "page", value: "1")
        config.method = .get
        return try await apiCall()
    }
    
    func fetchUpcoming(request: UpcomingEntity.Request) async throws -> UpcomingEntity.Response {
        config.serverType = .api
        config.path = "/3/movie/upcoming"
        config.addQueryItem(key: "language", value: "en-US")
        config.addQueryItem(key: "page", value: "1")
        config.method = .get
        return try await apiCall()
    }
    
    func fetchTopRated(request: TopRatedEntity.Request) async throws -> TopRatedEntity.Response {
        config.serverType = .api
        config.path = "/3/movie/top_rated"
        config.addQueryItem(key: "language", value: "en-US")
        config.addQueryItem(key: "page", value: "1")
        config.method = .get
        return try await apiCall()
    }
    
    func fetchDetailMovie(request: DetailEntity.Request) async throws -> DetailModel {
        config.serverType = .api
        config.path = "/3/movie/\(request._id)"
        config.addQueryItem(key: "language", value: "en-US")
        config.addQueryItem(key: "page", value: "1")
        config.method = .get
        return try await apiCall()
    }
        
    func fetchSearch(request: SearchEntity.Request) async throws -> SearchEntity.Response {
        config.serverType = .api
        config.path = "/3/search/movie"
        config.addQueryItem(key: "language", value: "en-US")
        config.addQueryItem(key: "page", value: "1")
        config.addQueryItem(key: "query", value: request.query)
        config.method = .get
        return try await apiCall()
    }
    func fetchMovieToWatch(request: MovieToWatchEntity.Request) async throws -> MovieToWatchEntity.Response {
        config.serverType = .api
        config.path = "/3/movie/\(request._id)/videos"
        config.addQueryItem(key: "language", value: "en-US")
        config.method = .get
        return try await apiCall()
    }
    
}
