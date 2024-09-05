//
//  PlayMovieView.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

struct PlayMovieView: View {
    @EnvironmentObject var coordinator: Coordinator<HomeScreen>
    @StateObject var viewmodel: PlayMovieViewModel
    @State private var trailerUrl: URL? = nil
    
    var body: some View {
        CustomZStack(coordinator: coordinator, viewmodel: viewmodel) {
            VStack {
                if let url = trailerUrl {
                    WebView(url: url)
                        .frame(height: 300)
                } else {
                    Text("No Trailer Available")
                }
                
                Spacer()
            }
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
    PlayMovieView(viewmodel: PlayMovieViewModel(movieId: 1226578))
        .environmentObject(Coordinator<HomeScreen>())
}
