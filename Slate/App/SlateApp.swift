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
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [Product.self, Order.self])
    }
}
