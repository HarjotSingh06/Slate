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
    // Instantiate the global application coordinator
    @StateObject private var coordinator = NavigationCoordinator()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(coordinator) // Injects it down the entire view hierarchy
                .modelContainer(for: Product.self)
        }
    }
}
