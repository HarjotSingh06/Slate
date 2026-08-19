//
//  MainTabView.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//
import SwiftUI
import SwiftData

struct MainTabView: View {
    // Fetch live products directly from SwiftData so badge updates instantaneously
    @Query private var products: [Product]

    var totalItemsCount: Int {
        products.reduce(0) { $0 + $1.quantity }
    }

    var body: some View {
        TabView {
            CatalogueView()
                .tabItem {
                    Label("Shop", systemImage: "bag.fill")
                }

            ContentView()
                .tabItem {
                    Label("Basket", systemImage: "cart.fill")
                }
                .badge(totalItemsCount > 0 ? totalItemsCount : 0)
        }
    }
}
