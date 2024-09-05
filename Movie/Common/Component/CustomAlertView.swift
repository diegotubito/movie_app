//
//  CustomAlertView.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var isPresented: Bool
    @Binding var title: LocalizedStringKey
    @Binding var message: LocalizedStringKey
    
    var onAcceptDidTapped: (() -> Void)? = nil
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.clear
                        .ignoresSafeArea()
                
                VStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color.Movie.gray)
                 
                    Text(message)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                        .foregroundColor(Color.Movie.gray)
                        .font(.subheadline)
        
                    Divider()
                    
                    Button {
                        isPresented = false
                        onAcceptDidTapped?()
                    } label: {
                        VStack {
                            Text("Accept")
                        }
                    }
                }
                .padding()
                .background(Color.Movie.paleWhite)
                .cornerRadius(15)
                .padding(64)
            }
            .navigationBarBackButtonHidden(isPresented)
        }
    }
}
struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isPresented: .constant(true), title: .constant("Title"), message: .constant("Message"), onAcceptDidTapped: {
            
        })
    }
}
