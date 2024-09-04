//
//  HomeView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var coordinator: Coordinator<HomeScreen>
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                Button("navigate to detail view") {
                    coordinator.push(.detail)
                }
            }
            .navigationDestination(for: HomeScreen.self) { screen in
                switch screen {
                case .detail:
                    DetailView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
          .environmentObject(Coordinator<HomeScreen>())
}
