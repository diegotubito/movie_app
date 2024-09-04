//
//  SplashViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var onInitialValuesDidLoad = false
    
    func loadInitialValues() {
        // fake delay to show splah view, here we could load some usefull values.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.onInitialValuesDidLoad = true
        })
    }
}
