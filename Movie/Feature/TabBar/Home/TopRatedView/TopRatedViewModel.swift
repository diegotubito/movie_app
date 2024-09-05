//
//  TopRatedViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

class TopRatedViewModel: BaseViewModel {
    @Published var movies: [TopRatedModel] = []
    private let networkMonitor: NetworkMonitor
    private let coreDataManager: CoreDataManager
    
    init(networkMonitor: NetworkMonitor, coreDataManager: CoreDataManager = CoreDataManager(containerName: "Movie")) {
        self.networkMonitor = networkMonitor
        self.coreDataManager = coreDataManager
    }
    
    @MainActor
    func fetchTopRated() {
        if networkMonitor.isConnected {
            print("Loading Top Rated From API")
            Task {
                do {
                    isLoading = true
                    
                    
                    let fetchTopRatedUseCase = FetchTopRatedUseCase()
                    let response = try await fetchTopRatedUseCase.excecute()
                    
                    
                    coreDataManager.deleteEntities(ofType: TopRated.self)
                    coreDataManager.saveEntities(models: response.results, entityType: TopRated.self) { (movieModel, popularEntity) in
                        popularEntity.id = Int32(movieModel._id)
                        popularEntity.originalTitle = movieModel.originalTitle
                        popularEntity.posterPath = movieModel.posterPath
                    } completion: {
                        self.loadMoviesFromCoreData()
                    }
                    for movie in response.results {
                        await fetchPoster(for: movie.posterPath, forMovieID: movie._id)
                    }
                     
                } catch {
                    isLoading = false
                    handleError(error: error, .alert(routeBack: .none))
                    print(error.localizedDescription)
                }
            }
        } else {
            print("Loading Top Rated From Core Data")
            loadMoviesFromCoreData()
        }
    }
    
    @MainActor
    func fetchPoster(for path: String, forMovieID id: Int) async {
        Task {
            do {
                let fetchPosterUseCase = FetchPosterUseCase()
                let posterData = try await fetchPosterUseCase.excecute(path: path)
                coreDataManager.saveDataForEntity(
                    ofType: Popular.self,
                    entityID: id,
                    dataFieldKeyPath: \Popular.posterImageData,
                    data: posterData
                ) {
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
        coreDataManager.fetchEntities(ofType: TopRated.self) { popularEntities in
            let movies = popularEntities.map { movieEntity in
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
