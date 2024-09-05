//
//  PlayMovieView.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

struct PlayMovieView<CoordinatorViewType: Hashable>: View {
    @EnvironmentObject var coordinator: Coordinator<CoordinatorViewType>
    @StateObject var viewmodel: PlayMovieViewModel
    @State private var trailerUrl: URL? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        CustomZStack(coordinator: coordinator, viewmodel: viewmodel) {
            VStack(alignment: .trailing) {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.Movie.paleWhite)
                .onTapGesture {
                   dismiss()
                }
                
                if let url = trailerUrl {
                    WebView(url: url)
                        .frame(height: 300)
                } else {
                    Text("No Trailer Available")
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewmodel.fetchMovieDetail { trailerKey in
                    if let key = trailerKey {
                        trailerUrl = URL(string: "https://www.youtube.com/watch?v=\(key)")
                    }
                }
            }
        }
    }
}

#Preview {
    PlayMovieView<HomeScreen>(viewmodel: PlayMovieViewModel(movieId: 1226578))
        .environmentObject(Coordinator<HomeScreen>())
}
