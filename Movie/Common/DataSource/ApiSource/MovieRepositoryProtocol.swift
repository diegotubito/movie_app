//
//  MovieRepositoryProtocol.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchPopularMovies(request: PopularMovieEntity.Request) async throws -> PopularMovieEntity.Response
    func fetchMoviePoster(request: PosterEntity.Request) async throws -> Data
    func fetchNowPlaying(request: NowPlayingEntity.Request) async throws -> NowPlayingEntity.Response
    func fetchUpcoming(request: UpcomingEntity.Request) async throws -> UpcomingEntity.Response
    func fetchTopRated(request: TopRatedEntity.Request) async throws -> TopRatedEntity.Response
    func fetchDetailMovie(request: DetailEntity.Request) async throws -> DetailModel
    func fetchSearch(request: SearchEntity.Request) async throws -> SearchEntity.Response
    func fetchMovieToWatch(request: MovieToWatchEntity.Request) async throws -> MovieToWatchEntity.Response

}
