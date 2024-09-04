//
//  HomeViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let fetchPopularUseCase: FetchPopularUseCaseProtocol
    let fetchPosterUseCase: FetchPosterUseCaseProtocol

    @Published var posterImage: Data? = nil // Published property to store image data

    init(fetchPopularUseCase: FetchPopularUseCaseProtocol, fetchPosterUseCase: FetchPosterUseCaseProtocol) {
        self.fetchPopularUseCase = fetchPopularUseCase
        self.fetchPosterUseCase = fetchPosterUseCase
    }

    @MainActor
    func fetchPopular() {
        Task {
            do {
                let response = try await fetchPopularUseCase.excecute()
                print(response)
                
                // Load the poster for the first movie in the response (for example)
                if let firstMovie = response.results.first {
                    await fetchPoster(for: firstMovie.posterPath)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    @MainActor
    func fetchPoster(for path: String) async {
        Task {
            do {
                let posterResponse = try await fetchPosterUseCase.excecute(path: path)
                self.posterImage = posterResponse
            } catch {
                print("Error fetching poster: \(error.localizedDescription)")
            }
        }
    }
}
