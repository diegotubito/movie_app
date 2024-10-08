//
//  ContentView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewmodel = SplashViewModel()
    
    var body: some View {
        CustomZStack(coordinator: Coordinator<HomeScreen>(), viewmodel: viewmodel) {
            VStack {
                Text("Play Movies")
                    .padding(.bottom)
                Image("popcorn 1")
                    .resizable()
                    .frame(width: 189, height: 189)
            }
        }
        .onAppear {
            viewmodel.loadInitialValues()
        }
        .fullScreenCover(isPresented: $viewmodel.onInitialValuesDidLoad, content: {
            TabBarView(tabBarManager: TabBarViewModel(selectedTab: .home))
        })
    }
}

#Preview {
    SplashView()
}
