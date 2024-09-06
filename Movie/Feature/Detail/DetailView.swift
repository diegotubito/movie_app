//
//  DetailView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import SwiftUI

struct DetailView<CoordinatorViewType: Hashable>: View {
    @StateObject var viewModel: DetailViewModel
    @EnvironmentObject var coordinator: Coordinator<HomeScreen>
    @State private var isModalPresented: Bool = false
    
    var body: some View {
        CustomZStack(coordinator: coordinator, viewmodel: viewModel) {
            ScrollView {
                VStack(alignment: .leading) {
                    moviePosterSection
                    movieDetailsSection
                    Spacer()
                }
            }
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchMovieDetail()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.toggleBookmark()
                }) {
                    Image(systemName: viewModel.isBookmarked ? "bookmark.fill" : "bookmark")
                }
            }
        }
        .fullScreenCover(isPresented: $isModalPresented, content: {
            PlayMovieView<CoordinatorViewType>(viewmodel: PlayMovieViewModel(movieId: viewModel.movieId))
        })
    }

    var moviePosterSection: some View {
        ZStack(alignment: .center) {
            if let backgroundPosterImageData = viewModel.detailMovie?.backgroundPosterImageData,
               let uiImage = UIImage(data: backgroundPosterImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .overlay(Color.black.opacity(0.4))
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 250)
            }
            playButton
        }
        .frame(height: 250)
    }

    var movieDetailsSection: some View {
        HStack(alignment: .top, spacing: 16) {
            moviePosterThumbnail
            VStack(alignment: .leading, spacing: 8) {
                movieTitleAndRating
                movieInfo
                movieTagline
                movieOverview
            }
        }
        .padding([.horizontal, .top])
    }

    var moviePosterThumbnail: some View {
        Group {
            if let posterImageData = viewModel.detailMovie?.posterImageData,
               let uiImage = UIImage(data: posterImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 150)
            }
        }
    }

    var movieTitleAndRating: some View {
        HStack {
            if let movie = viewModel.detailMovie {
                Text(movie.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }

    @ViewBuilder
    var movieInfo: some View {
        if let movie = viewModel.detailMovie {
            HStack(spacing: 16) {
                Label(movie.releaseDate.prefix(4), systemImage: "calendar")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Label("\(movie.runtime) Minutes", systemImage: "clock")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Label("Action, Adventure", systemImage: "film")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }

    @ViewBuilder
    var movieTagline: some View {
        if let tagline = viewModel.detailMovie?.tagline {
            Text(tagline)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .italic()
                .padding(.vertical, 4)
        }
    }

    @ViewBuilder
    var movieOverview: some View {
        if let movie = viewModel.detailMovie {
            Text(movie.overview)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(4)
        }
    }

    var playButton: some View {
        Image(systemName: "play.circle.fill")
            .resizable()
            .frame(width: 60, height: 60)
            .foregroundColor(.white)
            .shadow(radius: 10)
            .onTapGesture {
                isModalPresented = true
            }
    }
}

#Preview {
    DetailView<HomeScreen>(viewModel: DetailViewModel(movieId: 1226578))
        .environmentObject(Coordinator<HomeScreen>())
}
