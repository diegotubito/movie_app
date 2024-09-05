//
//  HomeViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import SwiftUI
import CoreData

class PopularViewModel: BaseViewModel {
    @Published var popularMovies: [PopularMovieModel] = []
    
    private let networkMonitor: NetworkMonitor
    private let coreDataManager: CoreDataManager
    
    init(networkMonitor: NetworkMonitor = NetworkMonitor()) {
      
        self.networkMonitor = networkMonitor
        self.coreDataManager = CoreDataManager(containerName: "Movie")
    }
    
    @MainActor
    func fetchPopular() {
        if networkMonitor.isConnected {
            print("Loading Popular From API")
            Task {
                do {
                    isLoading = true
                    let fetchPopularUseCase = FetchPopularUseCase()
                    let response = try await fetchPopularUseCase.excecute()
                    coreDataManager.deleteEntities(ofType: Popular.self)
                    coreDataManager.saveEntities(models: response.results, entityType: Popular.self) { (movieModel, popularEntity) in
                        popularEntity.id = Int32(movieModel._id)
                        popularEntity.originalTitle = movieModel.originalTitle
                        popularEntity.posterPath = movieModel.posterPath
                    } completion: {
                        self.loadPopularMoviesFromCoreData()
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
            print("Loading Popular From API")
            loadPopularMoviesFromCoreData()
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
                    if let index = self.popularMovies.firstIndex(where: { $0._id == id }) {
                        self.popularMovies[index].posterImageData = posterData
                    }
                }
                
            } catch {
                print("Error fetching poster: \(error.localizedDescription)")
            }
        }
    }
    
    func loadPopularMoviesFromCoreData() {
        isLoading = true
        coreDataManager.fetchEntities(ofType: Popular.self) { popularEntities in
            let movies = popularEntities.map { movieEntity in
                PopularMovieModel(
                    _id: Int(movieEntity.id),
                    originalTitle: movieEntity.originalTitle ?? "Unknown Title",
                    posterPath: movieEntity.posterPath ?? "",
                    posterImageData: movieEntity.posterImageData
                )
            }
            
            DispatchQueue.main.async {
                self.popularMovies = movies
                self.isLoading = false
            }
        }
    }
}
