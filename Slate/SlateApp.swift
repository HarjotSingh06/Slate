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
    // Keep your sharedModelContainer as is
    
    var body: some Scene {
        WindowGroup {
            MainTabView() // Change this from ContentView()
                .modelContainer(for: Product.self)
        }
    }
}
