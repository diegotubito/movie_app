//
//  WatchListViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI
import CoreData

class WatchListViewModel: BaseViewModel {
    @Published var watchList: [WatchList] = []
    private let coreDataManager: CoreDataManager
    
    override init() {
        coreDataManager = CoreDataManager(containerName: "Movie")
    }
    
    func fetchWatchlist() {
        coreDataManager.fetchEntities(ofType: WatchList.self) { [weak self] movies in
            DispatchQueue.main.async {
                self?.watchList = movies
            }
        }
    }
}
