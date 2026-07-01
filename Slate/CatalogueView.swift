//
//  CatalogueView.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//

import SwiftUI

struct CatalogueView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: ItemViewModel?
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
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
                        VStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 120)
                                .overlay(Image(systemName: "tshirt").font(.title))
                            
                            Text(item.0).font(.headline)
                            Text("£\(item.1, specifier: "%.2f")").font(.subheadline)
                            
                            Button(action: {
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
