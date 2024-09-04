//
//  TabBarViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

class TabBarViewModel: ObservableObject {
    @Published var selectedTab: Tab

    
    init(selectedTab: Tab) {
        self.selectedTab = selectedTab
    }
    
    enum Tab {
        case home
        case search
        case watchList
    }
    
}

