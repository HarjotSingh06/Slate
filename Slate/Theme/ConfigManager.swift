//
//  ConfigManager.swift
//  Slate
//
//  Created by Harjot Singh on 21/08/2026.
//

import SwiftUI
import Combine

enum ClientBrand: String, CaseIterable, Identifiable {
    case slate = "Slate (Pink)"
    case ocean = "Luxe Ocean (Blue)"
    case emerald = "Emerald Supply (Green)"
    
    var id: String { rawValue }
    
    var primaryColor: Color {
        switch self {
        case .slate: return Color(hex: "#FF007A")
        case .ocean: return Color(hex: "#007AFF")
        case .emerald: return Color(hex: "#10B981")
        }
    }
}

class ConfigManager: ObservableObject {
    static let shared = ConfigManager()
    
    @Published var selectedBrand: ClientBrand = .slate
    
    var primaryColor: Color {
        selectedBrand.primaryColor
    }
}
