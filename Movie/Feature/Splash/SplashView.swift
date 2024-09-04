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
        VStack {
            Text("Splash View")
        }
        .padding()
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
