//
//  BaseViewModel.swift
//  Movie
//
//  Created by David Diego Gomez on 05/09/2024.
//

import SwiftUI

class BaseViewModel: ObservableObject {
    var errorTitle: LocalizedStringKey = ""
    var errorMessage: LocalizedStringKey = ""
    @Published var showError = false
    @Published var isLoading: Bool = false
    
    @Published var errorDisplayType: ErrorDisplayType = .none
    
    enum ErrorDisplayType {
        case alert(routeBack: RouteBack)
        case none
    }
    
    enum RouteBack {
        case none
        case root
        case pop
    }
    
    func handleError(error: Error,_ errorDisplayType: ErrorDisplayType = .none) {
        
        if let apiError = error as? APIError {
            switch apiError {
            case .customError(message: let message):
                errorTitle = LocalizedStringKey(("Error"))
                errorMessage = LocalizedStringKey((message ?? ""))
                break
            case .badRequest:
                errorTitle = LocalizedStringKey("Bad Requet")
                errorMessage = LocalizedStringKey("Some Parameters Are Missing")
                break
            case .invalidURL:
                break
            case .notFound(let url):
                errorTitle = LocalizedStringKey("_404_TITLE")
                errorMessage = LocalizedStringKey("_404_MESSAGE")
                break
            case .rateLimitExceeded:
                break
            case .serverError(let message):
                errorTitle = LocalizedStringKey("Server Error")
                errorMessage = LocalizedStringKey(message)
                break
            case .serialization:
                errorTitle = LocalizedStringKey("_SERIALIZE_TITLE")
                errorMessage = LocalizedStringKey("_SERIALIZE_MESSAGE")
                break
            case .mockFailed:
                break
                
            case .authentication, .notAuthorized:
                errorTitle = LocalizedStringKey("Authentication")
                errorMessage = LocalizedStringKey("Access Token Not Found Or Expired")
            }
        } else {
            errorTitle = LocalizedStringKey("_SERVER_ERROR_TITLE")
            errorMessage = LocalizedStringKey("_SERVER_ERROR_MESSAGE")
        }
        
        self.errorDisplayType = errorDisplayType

    }
}

