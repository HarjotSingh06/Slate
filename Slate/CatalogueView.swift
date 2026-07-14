//
//  CatalogueView.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//

import SwiftUI
import SwiftData

struct CatalogueView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: ItemViewModel?
    
    // UI Impact feedback for premium add-to-basket button taps!
    private let hapticFeedback = UINotificationFeedbackGenerator()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // Shop item list
    let shopItems: [(String, Double)] = [
        ("Blue Shirt", 7.99),
        ("White Shoes", 9.99),
        ("Red Pants", 12.50),
        ("White Pants", 9.99)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(shopItems, id: \.0) { item in
                        // Create a temporary Product model representation to extract our dynamic icon
                        let tempProduct = Product(name: item.0, price: item.1)
                        
                        VStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 120)
                                .overlay(
                                    // Dynamic icon based on product name instead of static "tshirt"!
                                    Image(systemName: tempProduct.iconName)
                                        .font(.system(size: 44))
                                        .foregroundColor(.black.opacity(0.8))
                                )
                            
                            Text(item.0)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("£\(item.1, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                // Trigger subtle haptic success pop
                                hapticFeedback.notificationOccurred(.success)
                                
                                viewModel?.addToBasket(name: item.0, price: item.1)
                            }) {
                                Text("Add to Basket")
                                    .frame(maxWidth: .infinity)
                                    .fontWeight(.medium)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.pink)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.2))
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Shop")
        }
        .onAppear {
            if viewModel == nil {
                viewModel = ItemViewModel(modelContext: modelContext)
            }
        }
    }
}
