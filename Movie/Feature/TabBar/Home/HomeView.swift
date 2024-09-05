//
//  HomeView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import SwiftUI

struct HomeView: View {
    @StateObject var popularViewModel = PopularViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(popularViewModel.popularMovies, id: \.self) { movie in
                    HStack {
                        if let posterImageData = movie.posterImageData, let uiImage = UIImage(data: posterImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 75)
                                .clipped()
                        } else {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 50, height: 75)
                        }
                        
                        Text(movie.originalTitle)
                    }
                }
            }
        }
        .onAppear {
            popularViewModel.fetchPopular()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(popularViewModel: PopularViewModel())
    }
}
