//
//  WatchListView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct WatchListView: View {
    @StateObject var viewModel = WatchListViewModel()
    @EnvironmentObject var coordinator: Coordinator<WatchListScreen>
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            CustomZStack(coordinator: coordinator, viewmodel: viewModel) {
                VStack {
                    if viewModel.watchList.isEmpty {
                        VStack {
                            Image("magic-box 1")
                                .font(.largeTitle)
                                .padding()
                            Text("There is no movie yet!")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.Movie.titleColorSecondary)
                                .padding(.bottom, 8)
                            Text("Find your movie by Type title, categories, years, etc ")
                                .font(.system(size: 12, weight: .medium))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color.Movie.lightGray)
                                .padding(.horizontal, 100)
                        }
                    } else {
                        ScrollView {
                            Text("Pull To Refresh")
                                .foregroundStyle(Color.Movie.lightGray)
                                .padding()
                            ForEach(viewModel.watchList, id: \.self) { movie in
                                cellView(movie: movie)
                                    .onTapGesture {
                                        coordinator.push(.detail(movieId: Int(movie.id)))
                                    }
                            }
                            
                        }
                        .refreshable {
                            viewModel.fetchWatchlist()
                        }
                        .padding()
                        
                    }
                }
            }
            .navigationDestination(for: WatchListScreen.self) { screen in
                switch screen {
                case .detail(movieId: let movieId):
                    DetailView<WatchListScreen>(viewModel: DetailViewModel(movieId: movieId))
                case .playMovie(movieId: let movieId):
                    PlayMovieView<WatchListScreen>(viewmodel: PlayMovieViewModel(movieId: movieId))
                }
            }

        }
        .onAppear {
            viewModel.fetchWatchlist()
        }
        .navigationTitle("Watchlist")
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background
    }
    
    @ViewBuilder
    func cellView(movie: WatchList) -> some View {
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
                    Text(movie.originalTitle ?? "Unknown Title")
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
                        Text(movie.releaseDate ?? "N/A")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("\(movie.runtime) minutes")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }
        
      
    }
}

#Preview {
    WatchListView(viewModel: WatchListViewModel())
        .environmentObject(Coordinator<WatchListScreen>())
}
