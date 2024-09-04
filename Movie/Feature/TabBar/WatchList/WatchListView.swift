//
//  WatchListView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct WatchListView: View {
    @StateObject var viewmodel: WatchListViewModel
    
    var body: some View {
        Text("Watch List View")
    }
}

#Preview {
    WatchListView(viewmodel: WatchListViewModel())
}
