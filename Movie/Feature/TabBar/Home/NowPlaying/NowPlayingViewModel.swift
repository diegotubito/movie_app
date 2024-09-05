//
//  NowPlayingViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import Foundation

class NowPlayingViewModel: BaseViewModel {
    @Published var movies: [NowPlayingModel] = []
    
    private let networkMonitor: NetworkMonitor
    private let coreDataManager: CoreDataManager
    
    init(networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.networkMonitor = networkMonitor
        self.coreDataManager = CoreDataManager(containerName: "Movie")
    }
    
    @MainActor
    func fetchNowPlaying() {
        if networkMonitor.isConnected {
            print("Loading Now Playing From API")
            Task {
                do {
                    isLoading = true
                    
                    
                    let fetchNowPlayingUseCase = FetchNowPlayingUseCase()
                    let response = try await fetchNowPlayingUseCase.excecute()
                    
                    
                    coreDataManager.deleteEntities(ofType: NowPlaying.self)
                    coreDataManager.saveEntities(models: response.results, entityType: NowPlaying.self) { (movieModel, popularEntity) in
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
            print("Loading Upcoming From Core Data")
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
        coreDataManager.fetchEntities(ofType: NowPlaying.self) { popularEntities in
            let movies = popularEntities.map { movieEntity in
                NowPlayingModel(
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


