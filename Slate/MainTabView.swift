//
//  MainTabView.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//
import SwiftUI

struct MainTabView: View {
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
        }
    }
}
