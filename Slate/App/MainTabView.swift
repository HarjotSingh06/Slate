//
//  MainTabView.swift
//
//  MainTabView.swift
//  Slate
//

import SwiftUI
import SwiftData

struct MainTabView: View {
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
                .badge(totalItemsCount > 0 ? totalItemsCount : 0) // Attached to Basket tab

            OrderHistoryView()
                .tabItem {
                    Label("Orders", systemImage: "clock.fill")
                }
        }
    }
}
