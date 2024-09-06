//
//  MovieApp.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

@main
struct YourApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .onChange(of: scenePhase) { oldValue, newScenePhase in
                    switch newScenePhase {
                    case .active:
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            windowScene.windows.forEach { window in
                                window.overrideUserInterfaceStyle = .dark
                            }
                        }
                    default:
                        break
                    }
                }
                .environmentObject(networkMonitor)
        }
    }
}
