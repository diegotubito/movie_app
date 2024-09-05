//
//  DetailViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import Foundation
import CoreData

class DetailViewModel: BaseViewModel {
    var movieId: Int
    @Published var detailMovie: DetailModel?
    @Published var isBookmarked: Bool = false
    
    private let coreDataManager: CoreDataManager
    
    init(movieId: Int) {
        self.movieId = movieId
        self.coreDataManager = CoreDataManager(containerName: "Movie")
        super.init()
        checkIfBookmarked()
    }
    
    @MainActor
    func fetchMovieDetail() {
        Task {
            do {
                isLoading = true
                let fetchDetailUseCase = FetchDetailUseCase()
                let response = try await fetchDetailUseCase.excecute(_id: movieId)
                
                await fetchPoster(for: response.posterPath)
                await fetchBackgroundPoster(for: response.backdropPath)
                
                detailMovie = response
                isLoading = false
            } catch {
                isLoading = false
                handleError(error: error, .alert(routeBack: .none))
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func fetchPoster(for path: String) async {
        Task {
            do {
                isLoading = true
                let fetchPosterUseCase = FetchPosterUseCase()
                let posterData = try await fetchPosterUseCase.excecute(path: path)
                detailMovie?.posterImageData = posterData
                isLoading = false
            } catch {
                isLoading = false
                print("Error fetching poster: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func fetchBackgroundPoster(for path: String) async {
        Task {
            do {
                isLoading = true
                let fetchPosterUseCase = FetchPosterUseCase()
                let posterData = try await fetchPosterUseCase.excecute(path: path)
                detailMovie?.backgroundPosterImageData = posterData
                isLoading = false
            } catch {
                isLoading = false
                print("Error fetching poster: \(error.localizedDescription)")
            }
        }
    }
    
    func toggleBookmark() {
        guard let detailMovie = detailMovie else { return }
        coreDataManager.toggleBookmark(detailMovie: detailMovie) { [weak self] isBookmarked in
            self?.isBookmarked = isBookmarked
        }
    }
    
    private func checkIfBookmarked() {
        let fetchRequest: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        
        do {
            let bookmarks = try coreDataManager.viewContext.fetch(fetchRequest)
            self.isBookmarked = bookmarks.first != nil
        } catch {
            print("Failed to check bookmark status: \(error.localizedDescription)")
            self.isBookmarked = false
        }
    }
    
}
