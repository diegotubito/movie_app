//
//  HomeView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import SwiftUI

struct HomeView: View {
    @StateObject var popularViewModel = PopularViewModel()
    @EnvironmentObject var coordinator: Coordinator<HomeScreen>
    
    @State private var selectedSegment: segmentedOptions = .nowPlaying
      
    enum segmentedOptions: String, CaseIterable, Identifiable {
        case nowPlaying = "Now Playing"
        case upcoming = "Upcoming"
        case topRated = "Top Rated"
        var id: String { self.rawValue }
    }
    
    var body: some View {
        CustomZStack(coordinator: coordinator, viewmodel: popularViewModel) {
            ScrollView {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        scrollViewContent()
                            .padding(.horizontal)
                    }
                    .frame(height: 225)
                    
                    segmentedControlView()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            popularViewModel.fetchPopular()
        }
    }
    
    @ViewBuilder
    func scrollViewContent() -> some View {
        LazyHStack {
            ForEach(Array(popularViewModel.popularMovies.enumerated()), id: \.element) { index, movie in
                popularCellView(movie: movie, index: index)
            }
        }
    }
    
    @ViewBuilder
    func popularCellView(movie: PopularMovieModel, index: Int) -> some View {
        ZStack(alignment: .bottomLeading) {
            if let posterImageData = movie.posterImageData, let uiImage = UIImage(data: posterImageData) {
                VStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                .padding(.horizontal, 8)
                .padding(.vertical)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 225)
            }
            
            Text(String(index + 1))
                .font(Font.system(size: 80, weight: .bold))
                .foregroundColor(Color.Movie.tintColor)
                .offset(x: 0, y: 15)
                .overlay {
                    Text(String(index + 1))
                        .font(Font.system(size: 75, weight: .semibold))
                        .foregroundColor(Color.Movie.primary)
                        .offset(x: 0, y: 14)
                }
        }
    }
    
    @ViewBuilder
    func segmentedControlView() -> some View {
        VStack {
            Picker("Select a segment", selection: $selectedSegment) {
                ForEach(segmentedOptions.allCases, id: \.self) { segment in
                    Text(segment.rawValue)
                       
                }
            }
            .colorInvert()
            .pickerStyle(SegmentedPickerStyle())
            
            Text("Selected segment: \(selectedSegment.rawValue)")
                .padding()
            
            switch selectedSegment {
            case .nowPlaying:
                TopRatedView()
            case .upcoming:
                TopRatedView()
            case .topRated:
                TopRatedView()
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Coordinator<HomeScreen>())
    }
}
