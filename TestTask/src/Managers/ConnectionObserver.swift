//
//  ConnectionObserver.swift
//  TestTask
//
//  Created by Danil Velanskiy on 10.07.2023.
//

import Foundation
import Network
import UIKit

class ConnectionObserver {
    static let instance = ConnectionObserver()

    private let monitorQueue = DispatchQueue.global()
    private let pathMonitor: NWPathMonitor

    public private(set) var isConnectedToInternet: Bool = false {
        didSet {
            if !isConnectedToInternet {
                print("No internet connection. 😢")
            } else {
                print("Internet connection is active. 😊")
            }
        }
    }

    private init() {
        pathMonitor = NWPathMonitor()
    }

    func beginMonitoring() {
        pathMonitor.start(queue: monitorQueue)
        pathMonitor.pathUpdateHandler = { path in
            self.isConnectedToInternet = path.status == .satisfied
        }
    }

    func endMonitoring() {
        pathMonitor.cancel()
    }
}
