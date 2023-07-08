//
//  CardsManagementApp.swift
//  CardsManagement
//
//  Created by Mac on 01/07/2023.
//

import SwiftUI

@main
struct CardsManagementApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            CardsScreen()
                .environmentObject(networkMonitor)
                .preferredColorScheme(.light)
        }
    }
}
