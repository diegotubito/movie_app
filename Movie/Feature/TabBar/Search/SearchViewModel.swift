//
//  SearchViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

class SearchViewModel: BaseViewModel {
    @Published var searchList: [SearchModel] = []
    @Published var searchText = ""
    @Published var showEmptyView = false
    
    @MainActor
    func fetchSearch() {
        print("Loading Search Query From API")
        Task {
            do {
                isLoading = true
                let fetchSearchUseCase = FetchSearchUseCase()
                let response = try await fetchSearchUseCase.excecute(query: searchText)
                
                for movie in response.results {
                    if let posterPath = movie.posterPath {
                        await fetchPoster(for: posterPath, forMovieID: movie._id)
                    }
                }
                isLoading = false
                searchList = response.results
                showEmptyView = searchList.isEmpty
            } catch {
                isLoading = false
                handleError(error: error, .alert(routeBack: .none))
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func fetchPoster(for path: String, forMovieID id: Int) async {
        Task {
            do {
                isLoading = true
                let fetchPosterUseCase = FetchPosterUseCase()
                let posterData = try await fetchPosterUseCase.excecute(path: path)
                if let index = self.searchList.firstIndex(where: { $0._id == id }) {
                    self.searchList[index].posterImageData = posterData
                }
                isLoading = false
                
            } catch {
                isLoading = false
                print("Error fetching poster: \(error.localizedDescription)")
            }
        }
    }
}
