//
//  CustomProgressView.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

struct CustomProgressView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        if isLoading {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ProgressView()
                    .scaleEffect(1.3)
                    .colorInvert()
            }
        }
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(isLoading: .constant(false))
    }
}
