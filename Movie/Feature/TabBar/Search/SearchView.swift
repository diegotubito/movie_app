//
//  SearchView.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewmodel: SearchViewModel
    
    var body: some View {
        Text("Search View")
    }
}

#Preview {
    SearchView(viewmodel: SearchViewModel())
}
