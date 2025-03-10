//
//  NetworkMonitor.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import Foundation
import Network
import Combine

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue
    
    @Published var isConnected: Bool = true
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitor")
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                debugPrint("Network connection status: \(self?.isConnected ?? false)")
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
