//
//  NavigationCoordinator.swift
//  Slate
//
//  Created by Harjot Singh on 02/07/2026.
//

import SwiftUI
import Combine

enum SlateRoute: Hashable {
    case catalogue
    case productDetail(id: String) // Using ID or a Hashable Product model
}

@MainActor
final class NavigationCoordinator: ObservableObject {
    /// Manages the navigation stack path for NavigationStack
    @Published var path = NavigationPath()
    
    /// Manages sheet presentations independently (like your Checkout screen)
    @Published var presentCheckout = false
    
    // MARK: - Navigation Actions
    
    func navigate(to route: SlateRoute) {
        path.append(route)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func openCheckout() {
        presentCheckout = true
    }
    
    func closeCheckout() {
        presentCheckout = false
    }
}
