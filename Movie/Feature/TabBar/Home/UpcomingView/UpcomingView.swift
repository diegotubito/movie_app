//
//  UpcomingView.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

struct UpcomingView: View {
    @StateObject var viewmodel = UpcomingViewModel()
    @EnvironmentObject var coordinator: Coordinator<HomeScreen>

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
                }
            }
            .padding()
            
        }
        .onAppear {
            viewmodel.fetchUpcoming()
        }
    }
}

#Preview {
    UpcomingView()
        .environmentObject(Coordinator<HomeScreen>())
}

