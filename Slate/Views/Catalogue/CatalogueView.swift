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
    @State private var searchText = ""
    
    private let availableProducts: [(name: String, price: Double, imageName: String)] = [
        ("Oversized Cotton Tee", 28.00, "cotton_tee"),
        ("Classic Denim Jacket", 65.00, "denim_jacket"),
        ("Tailored Trousers", 45.00, "tailored_trousers"),
        ("Minimalist Sneakers", 80.00, "minimalist_sneakers")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 6) {
                        Text("SLATE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .tracking(3)
                            .foregroundStyle(theme.primaryColor)

                        Text("Discover something new.")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Curated essentials for everyday life.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    // MARK: - Search
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)

                        TextField("Search products", text: $searchText)
                            .textInputAutocapitalization(.never)

                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 52)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // MARK: - Products Header
                    HStack {
                        Text("New & Trending")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()

                        Button("See all") {
                            // We'll wire this later
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(theme.primaryColor)
                    }

                    // MARK: - Existing Product Grid
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        ForEach(availableProducts, id: \.name) { item in
                            NavigationLink(
                                destination: ProductDetailView(
                                    name: item.name,
                                    price: item.price,
                                    imageName: item.imageName
                                )
                            ) {
                                ProductCardView(
                                    name: item.name,
                                    price: item.price,
                                    imageName: item.imageName,
                                    accentColor: theme.primaryColor
                                ) {
                                    addToBasket(item: item)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(
                                    color: .black.opacity(0.05),
                                    radius: 4,
                                    x: 0,
                                    y: 2
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .navigationBarTitleDisplayMode(.inline)
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
