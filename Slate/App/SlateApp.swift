//
//  SlateApp.swift
//  Slate
//
//  Created by Harjot Singh on 08/05/2026.
//

import SwiftUI
import SwiftData
import Combine

@main
struct SlateApp: App {
    @StateObject private var configManager = ConfigManager.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(configManager)
        }
        .modelContainer(for: [Product.self, Order.self, UserProfile.self])
    }
}
