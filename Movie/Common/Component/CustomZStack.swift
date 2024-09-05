//
//  CustomZStack.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//
import SwiftUI

struct CustomZStack<Content: View, Screen: Hashable>: View  {
    let coordinator: Coordinator<Screen>
    @ObservedObject var viewmodel: BaseViewModel
    @State var alertIsPresented = false
    @State var routeBack: BaseViewModel.RouteBack = .none
    
    let content: Content
        
    init(coordinator: Coordinator<Screen>, viewmodel: BaseViewModel, @ViewBuilder content: () -> Content) {
        self.coordinator = coordinator
        self.viewmodel = viewmodel
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.Movie.primary
                .ignoresSafeArea(.all)
            
            content
        }
        .onReceive(viewmodel.$errorDisplayType, perform: { errorDisplayType in
            switch errorDisplayType {
            case .alert(routeBack: let routeBack):
                alertIsPresented = true
                self.routeBack = routeBack
                break
            case .none:
                break
            }
        })
        .overlay(
            Group {
                CustomProgressView(isLoading: $viewmodel.isLoading)
                CustomAlertView(isPresented: $alertIsPresented, title: $viewmodel.errorTitle, message: $viewmodel.errorMessage, onAcceptDidTapped: {
                    switch routeBack {
                    case .none:
                        break
                    case .root:
                        coordinator.popToRoot()
                    case .pop:
                        coordinator.pop()
                    }
                })
            }
        )
    }
}
