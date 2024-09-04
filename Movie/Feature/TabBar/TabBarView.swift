//
//  TabBarView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var tabBarManager: TabBarViewModel
    
    @StateObject var homeCoordinator = Coordinator<HomeScreen>()
    @StateObject var searchCoordinator = Coordinator<SearchScreen>()
    @StateObject var watchListCoordinator = Coordinator<WatchListScreen>()

    var body: some View {
        ZStack {
            TabView(selection: $tabBarManager.selectedTab) {
                HomeView(viewmodel: HomeViewModel())
                    .frame(maxHeight: .infinity)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(TabBarViewModel.Tab.home)
                
                
                SearchView(viewmodel: SearchViewModel())
                    .frame(maxHeight: .infinity)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag((TabBarViewModel.Tab.search))
                
                WatchListView(viewmodel: WatchListViewModel())
                    .frame(maxHeight: .infinity)
                    .tabItem {
                        Label("Watch List", systemImage: "gear")
                    }
                    .tag(TabBarViewModel.Tab.watchList)
            }
        }
        .environmentObject(homeCoordinator)
        .environmentObject(searchCoordinator)
        .environmentObject(watchListCoordinator)
        .onAppear {
            setupTabBar()
        }
    }
    
    func setupTabBar() {
       
        UITabBar.appearance().backgroundColor = UIColor(.Movie.primary)
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Movie.gray)
    
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(tabBarManager: TabBarViewModel(selectedTab: .home))
    }
}
