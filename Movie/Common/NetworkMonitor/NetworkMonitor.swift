//
//  NetworkMonitor.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Network
import Combine

class NetworkMonitor: ObservableObject {
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global()
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
}
