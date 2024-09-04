//
//  HomeView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewmodel: HomeViewModel

    var body: some View {
        VStack {
            if let imageData = viewmodel.posterImage, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 300)
            } else {
                ProgressView()
                    .frame(width: 200, height: 300)
            }
        }
        .onAppear {
            viewmodel.fetchPopular() 
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewmodel: HomeViewModel())
    }
}
