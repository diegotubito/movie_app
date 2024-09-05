//
//  PlayMovieViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import Foundation

class PlayMovieViewModel: BaseViewModel {
    var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    @MainActor
    func fetchMovieDetail(completion: @escaping (String?) -> Void) {
        Task {
            do {
                isLoading = true
                let fetchMovieToWatchUseCase = FetchMovieToWatchUseCase()
                let response = try await fetchMovieToWatchUseCase.excecute(_id: movieId)
                
                // Look for the trailer
                if let trailer = response.results.first(where: {$0.type == "Trailer"}) {
                    completion(trailer.key)
                } else {
                    completion(nil)
                }
                isLoading = false
            } catch {
                isLoading = false
                handleError(error: error, .alert(routeBack: .none))
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
