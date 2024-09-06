//
//  UpcomingViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import Foundation

class UpcomingViewModel: BaseViewModel {
    @Published var movies: [UpcomingModel] = []
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager(containerName: "Movie")) {
        self.coreDataManager = coreDataManager
    }
    
    @MainActor
    func fetchUpcomingFromApi() {
        print("Upcoming Fetch From API")
        Task { [weak self] in
            guard let self = self else { return }
            do {
                isLoading = true
                let fetchUpcomingUseCase = FetchUpcomingUseCase()
                let response = try await fetchUpcomingUseCase.excecute()
                coreDataManager.deleteEntities(ofType: Upcoming.self)
                coreDataManager.saveEntities(models: response.results, entityType: Upcoming.self) { (movieModel, popularEntity) in
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
    
    func fetchUpcomingFromCoreData() {
        print("Upcoming Fetch From Core Data")
        loadMoviesFromCoreData()
    }
    
    @MainActor
    func fetchPoster(for path: String, forMovieID id: Int) async {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let fetchPosterUseCase = FetchPosterUseCase()
                let posterData = try await fetchPosterUseCase.excecute(path: path)
                coreDataManager.saveDataForEntity(
                    ofType: Upcoming.self,
                    entityID: id,
                    dataFieldKeyPath: \Upcoming.posterImageData,
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
        coreDataManager.fetchEntities(ofType: Upcoming.self) { entities in
            let movies = entities.map { movieEntity in
                UpcomingModel(
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

