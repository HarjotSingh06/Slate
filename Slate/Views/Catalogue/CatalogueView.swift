//
//  CatalogueView.swift
//  Slate
//
 

//
//  CatalogueView.swift
//  Slate
//

import SwiftUI
import SwiftData

struct CatalogueView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var theme: ConfigManager
    @Query private var products: [Product]

    private let availableProducts: [(name: String, price: Double, imageName: String)] = [
        ("Oversized Cotton Tee", 28.00, "tshirt.fill"),
        ("Classic Denim Jacket", 65.00, "jacket.fill"),
        ("Tailored Trousers", 45.00, "figure.walk"),
        ("Minimalist Sneakers", 80.00, "shoe.fill")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(availableProducts, id: \.name) { item in
                        // Wrap card in NavigationLink to push ProductDetailView
                        NavigationLink(destination: ProductDetailView(name: item.name, price: item.price)) {
                            VStack(alignment: .leading, spacing: 8) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemGray6))
                                        .frame(height: 120)
                                    
                                    Image(systemName: item.imageName)
                                        .font(.system(size: 40))
                                        .foregroundColor(theme.primaryColor)
                                }

                                Text(item.name)
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.primary)
                                    .lineLimit(1)

                                HStack {
                                    Text("£\(item.price, specifier: "%.2f")")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)

                                    Spacer()

                                    // Direct Add-to-Basket Button
                                    Button(action: { addToBasket(item: item) }) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.title3)
                                            .foregroundColor(theme.primaryColor)
                                    }
                                    .buttonStyle(.plain) // Prevents button tap from triggering row navigation
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        }
                        .buttonStyle(.plain) // Keeps card styling clean
                    }
                }
                .padding()
            }
            .navigationTitle("Shop")
        }
    }

    private func addToBasket(item: (name: String, price: Double, imageName: String)) {
        if let existingProduct = products.first(where: { $0.name == item.name }) {
            existingProduct.quantity += 1
        } else {
            let newProduct = Product(name: item.name, price: item.price, quantity: 1)
            modelContext.insert(newProduct)
        }
        try? modelContext.save()
    }
}
