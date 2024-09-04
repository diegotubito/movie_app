//
//  Coordinator.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

protocol CoordinatorProtocol {
    associatedtype Screen
    
    var path: [Screen] { get set }
    func pop()
    func push(_ screen: Screen)
    func popToRoot()
    func popLast(number: Int)
}

class Coordinator<Screen: Hashable>: CoordinatorProtocol, ObservableObject {
    @Published var path: [Screen] = []
    
    func pop() {
        path.removeLast()
    }
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func popLast(number: Int) {
        path.removeLast(number)
    }
}

