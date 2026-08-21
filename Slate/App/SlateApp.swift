//
//  SlateApp.swift
//  Slate
//
//  Created by Harjot Singh on 08/05/2026.
//


import SwiftUI
import SwiftData

@main
struct SlateApp: App {
    @StateObject private var theme = ConfigManager.shared
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = false

    var body: some Scene {
        WindowGroup {
            Group {
                if !hasSeenWelcome {
                    WelcomeView(onGetStarted: {
                        withAnimation {
                            hasSeenWelcome = true
                        }
                    })
                } else {
                    MainTabView()
                }
            }
            .environmentObject(theme)
        }
        .modelContainer(for: [Product.self, UserProfile.self, Order.self])
    }
}
