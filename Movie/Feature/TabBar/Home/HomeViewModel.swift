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

    @Published var posterImage: Data? = nil

    init() {
        self.fetchPopularUseCase = FetchPopularUseCase()
        self.fetchPosterUseCase = FetchPosterUseCase()
    }

    @MainActor
    func fetchPopular() {
        Task {
            do {
                let response = try await fetchPopularUseCase.excecute()
                print(response)
                
                if let firstMovie = response.results.first {
                    await fetchPoster(for: firstMovie.posterPath)
                }
            } catch {
                if let error = error as? APIError {
                    print(error.message)
                }
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
                self.posterImage = nil
                print("Error fetching poster: \(error.localizedDescription)")
            }
        }
    }
}
