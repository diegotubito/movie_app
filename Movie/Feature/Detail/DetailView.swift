//
//  DetailView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @EnvironmentObject var coordinator: Coordinator<HomeScreen>
    
    var body: some View {
        CustomZStack(coordinator: coordinator, viewmodel: viewModel) {
            VStack(alignment: .leading) {
                // Movie backdrop with play button overlay
                if let backgroundPosterImageData = viewModel.detailMovie?.backgroundPosterImageData,
                   let uiImage = UIImage(data: backgroundPosterImageData) {
                    ZStack(alignment: .center) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .overlay(
                                Color.black.opacity(0.4) // Darken the image for better text contrast
                            )
                        
                        // Play button
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .onTapGesture {
                                coordinator.push(.playMovie(movieId: viewModel.movieId))
                            }
                    }
                    .frame(height: 250)
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 250)
                }
                
                // Poster image and movie details
                HStack(alignment: .top, spacing: 16) {
                    // Poster Image
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
                    
                    VStack(alignment: .leading, spacing: 8) {
                        // Movie title and rating
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
                        
                        // Year, runtime, and genres (hardcoded genres for now)
                        if let movie = viewModel.detailMovie {
                            HStack(spacing: 16) {
                                Label(movie.releaseDate.prefix(4), systemImage: "calendar")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Label("\(movie.runtime) Minutes", systemImage: "clock")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                // Assuming genres would be added in your DetailModel later
                                Label("Action, Adventure", systemImage: "film")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            // Tagline and description text
                            if let tagline = movie.tagline {
                                Text(tagline)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.gray)
                                    .italic()
                                    .padding(.vertical, 4)
                            }
                            
                            Text(movie.overview)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(4)
                        }
                    }
                }
                .padding([.horizontal, .top])
                
                Spacer()
            }
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
        
        }
        .onAppear {
            viewModel.fetchMovieDetail()
        }
        
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(movieId: 1226578))
        .environmentObject(Coordinator<HomeScreen>())
}
