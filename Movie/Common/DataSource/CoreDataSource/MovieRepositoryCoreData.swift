//
//  MovieRepositoryCoreData.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation
/*
class MovieRepositoryCoreData {
    private let coreDataManager = CoreDataManager.shared

    func fetchPopularMovies(request: PopularMovieEntity.Request) async throws -> PopularMovieEntity.Response {
        let movies: [PopularMovieRecord] = coreDataManager.fetchData(for: PopularMovieRecord.self)
        let movieModels = movies.map { movie in
            PopularMovieModel(id: Int(movie.id), originalTitle: movie.originalTitle ?? "", posterPath: movie.posterPath ?? "")
        }
        return PopularMovieEntity.Response(results: movieModels)
    }
    
    func savePopularMovies(movies: [PopularMovieModel]) {
        movies.forEach { model in
            let record = PopularMovieRecord(context: coreDataManager.context)
            record.id = Int32(model.id)
            record.originalTitle = model.originalTitle
            record.posterPath = model.posterPath
        }
        coreDataManager.saveContext()
    }
}
*/
