//
//  SearchView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @EnvironmentObject var coordinator: Coordinator<SearchScreen>
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            CustomZStack(coordinator: coordinator, viewmodel: viewModel) {
                VStack {
                    ScrollView {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search here", text: $viewModel.searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading, 8)
                                .onSubmit {
                                    viewModel.fetchSearch()
                                }
                        }
                        .padding()
                        
                        ForEach(viewModel.searchList, id: \.self) { searchResult in
                            cellView(movie: searchResult)
                                .onTapGesture {
                                    coordinator.push(.detail(movieId: Int(searchResult._id)))
                                }
                        }
                    }
                    .padding()
                }
                .overlay {
                    if viewModel.showEmptyView {
                        VStack {
                            Image("no-results 1")
                                .font(.largeTitle)
                                .padding()
                            Text("we are sorry, we can not find the movie :(")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.Movie.titleColorSecondary)
                                .padding(.bottom, 8)
                            Text("Find your movie by Type title, categories, years, etc")
                                .font(.system(size: 12, weight: .medium))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color.Movie.lightGray)
                                .padding(.horizontal, 100)
                        }
                    }
                }
                .navigationDestination(for: SearchScreen.self) { screen in
                    switch screen {
                    case .detail(movieId: let movieId):
                        DetailView<SearchScreen>(viewModel: DetailViewModel(movieId: movieId))
                    }
                }
            }
        }.onAppear {
            viewModel.showEmptyView = false
        }
    }
    
    @ViewBuilder
    func cellView(movie: SearchModel) -> some View {
        HStack(alignment: .top, spacing: 16) {
            // Movie Poster
            if let posterImage = movie.posterImageData {
                Image(uiImage: UIImage(data: posterImage)!)
                    .resizable()
                    .frame(width: 60, height: 90)
                    .cornerRadius(8)
                    .padding(.trailing, 8)
            } else {
                Image(systemName: "film")
                    .resizable()
                    .frame(width: 60, height: 90)
                    .cornerRadius(8)
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                // Movie Title
                Text(movie.originalTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.system(size: 12))
                        .foregroundColor(.yellow)
                    
                }
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text(movie.releaseDate)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
        .environmentObject(Coordinator<SearchScreen>())
}
