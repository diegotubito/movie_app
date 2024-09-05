//
//  HomeViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import SwiftUI
import CoreData

class PopularViewModel: ObservableObject {
    @Published var popularMovies: [PopularMovieModel] = []
    
    let fetchPopularUseCase: FetchPopularUseCaseProtocol
    let fetchPosterUseCase: FetchPosterUseCaseProtocol
    private let networkMonitor: NetworkMonitor
    private let coreDataManager: CoreDataManager
    
    init(networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.fetchPopularUseCase = FetchPopularUseCase()
        self.fetchPosterUseCase = FetchPosterUseCase()
        self.networkMonitor = networkMonitor
        self.coreDataManager = CoreDataManager(containerName: "Movie")
    }
    
    @MainActor
    func fetchPopular() {
        if !networkMonitor.isConnected {
            print("Loading from API")
            Task {
                do {
                    let response = try await fetchPopularUseCase.excecute()
                    coreDataManager.deleteEntities(ofType: Popular.self)
                    coreDataManager.saveEntitiesInBackground(models: response.results, entityType: Popular.self) { (movieModel, popularEntity) in
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
                    if let error = error as? APIError {
                        print(error.message)
                    }
                    print(error.localizedDescription)
                }
            }
        } else {
            print("Loading from Core Data")
            loadPopularMoviesFromCoreData()
        }
    }
    
    @MainActor
    func fetchPoster(for path: String, forMovieID id: Int) async {
        Task {
            do {
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
            }
        }
    }
}
