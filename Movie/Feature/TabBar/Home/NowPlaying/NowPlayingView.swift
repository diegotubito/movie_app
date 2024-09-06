//
//  NowPlayingView.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

struct NowPlayingView: View {
    @StateObject var viewmodel = NowPlayingViewModel()
    @EnvironmentObject var coordinator: Coordinator<HomeScreen>
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        CustomZStack(coordinator: coordinator, viewmodel: viewmodel) {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
                spacing: 16
            ) {
                ForEach(viewmodel.movies.prefix(6)) { movie in
                    VStack {
                        if let posterImageData = movie.posterImageData, let uiImage = UIImage(data: posterImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Rectangle()
                                .fill(Color.gray)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .onTapGesture {
                        coordinator.push(.detail(movieId: movie._id))
                    }
                }
            }
            .padding()
            
        }
        .onAppear {
            loadData()
        }
        .onChange(of: networkMonitor.isConnected) { oldValue, newValue in
            loadData()
        }
    }
    
    private func loadData() {
        networkMonitor.isConnected ? viewmodel.fetchNowPlayingFromApi() : viewmodel.fetchNowPlayingFromCoreData()
    }
}

#Preview {
    NowPlayingView()
        .environmentObject(Coordinator<HomeScreen>())
        .environmentObject(NetworkMonitor())
}

