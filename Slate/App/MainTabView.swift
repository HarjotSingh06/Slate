

//
//  MainTabView.swift
//  Slate
//


import SwiftUI
import SwiftData

struct MainTabView: View {
    @EnvironmentObject private var theme: ConfigManager
    @Query private var products: [Product] // 1. Query current products in basket

    // 2. Calculate total item count across all quantities
    private var totalBasketCount: Int {
        products.reduce(0) { $0 + $1.quantity }
    }

    var body: some View {
        TabView {
            CatalogueView()
                .tabItem {
                    Label("Shop", systemImage: "storefront")
                }

            ContentView()
                .tabItem {
                    Label("Basket", systemImage: "cart")
                }
                .badge(totalBasketCount > 0 ? totalBasketCount : 0) // 3. Dynamic Badge

            OrdersView()
                .tabItem {
                    Label("Bag", systemImage: "bag")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(theme.primaryColor)
    }
}
