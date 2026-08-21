//
//  ConfigManager.swift
//  Slate
//
//  Created by Harjot Singh on 21/08/2026.
//

import SwiftUI
import Combine // Added to fix ObservableObject and @Published errors

class ConfigManager: ObservableObject {
    static let shared = ConfigManager()
    
    @Published var config: ThemeConfig
    
    init() {
        // Default Mock Configuration (Pink Theme)
        self.config = ThemeConfig(
            brandName: "Slate",
            primaryColorHex: "#FF007A",
            secondaryColorHex: "#1C1C1E",
            fontName: "System",
            showWishlistFeature: true
        )
    }
    
    var primaryColor: Color {
        Color(hex: config.primaryColorHex)
    }
    
    func applyClientTheme(hex: String, brand: String) {
        self.config = ThemeConfig(
            brandName: brand,
            primaryColorHex: hex,
            secondaryColorHex: "#000000",
            fontName: "System",
            showWishlistFeature: true
        )
    }
}
