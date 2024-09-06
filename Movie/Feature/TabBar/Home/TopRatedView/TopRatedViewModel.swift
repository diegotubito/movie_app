//
//  TopRatedViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

class TopRatedViewModel: BaseViewModel {
    @Published var movies: [TopRatedModel] = []
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager(containerName: "Movie")) {
        self.coreDataManager = coreDataManager
    }
    
    @MainActor
    func fetchTopRatedFromApi() {
            print("Top Rated From API")
            Task { [weak self] in
                guard let self = self else { return }
                
                do {
                    isLoading = true
                    let fetchTopRatedUseCase = FetchTopRatedUseCase()
                    let response = try await fetchTopRatedUseCase.excecute()
                    coreDataManager.deleteEntities(ofType: TopRated.self)
                    coreDataManager.saveEntities(models: response.results, entityType: TopRated.self) { (movieModel, popularEntity) in
                        popularEntity.id = Int32(movieModel._id)
                        popularEntity.originalTitle = movieModel.originalTitle
                        popularEntity.posterPath = movieModel.posterPath
                    } completion: { }
                    for movie in response.results {
                        await fetchPoster(for: movie.posterPath, forMovieID: movie._id)
                    }
                    movies = response.results
                    isLoading = false
                } catch {
                    isLoading = false
                    handleError(error: error, .alert(routeBack: .none))
                    print(error.localizedDescription)
                }
            }
       
    }
    
    @MainActor
    func fetchTopRatedFromCoreData() {
        print("Top Rated From Core Data")
        loadMoviesFromCoreData()
    }
    
    @MainActor
    func fetchPoster(for path: String, forMovieID id: Int) async {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                isLoading = true
                let fetchPosterUseCase = FetchPosterUseCase()
                let posterData = try await fetchPosterUseCase.excecute(path: path)
                coreDataManager.saveDataForEntity(
                    ofType: TopRated.self,
                    entityID: id,
                    dataFieldKeyPath: \TopRated.posterImageData,
                    data: posterData
                ) {
                    self.isLoading = false
                    if let index = self.movies.firstIndex(where: { $0._id == id }) {
                        self.movies[index].posterImageData = posterData
                    }
                }
                
            } catch {
                print("Error fetching poster: \(error.localizedDescription)")
            }
        }
    }
    
    func loadMoviesFromCoreData() {
        isLoading = true
        coreDataManager.fetchEntities(ofType: TopRated.self) { entities in
            let movies = entities.map { movieEntity in
                TopRatedModel(
                    _id: Int(movieEntity.id),
                    originalTitle: movieEntity.originalTitle ?? "Unknown Title",
                    posterPath: movieEntity.posterPath ?? "",
                    posterImageData: movieEntity.posterImageData
                )
            }
            
            DispatchQueue.main.async {
                self.movies = movies
                self.isLoading = false
            }
        }
    }
}
