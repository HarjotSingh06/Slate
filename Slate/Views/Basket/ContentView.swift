//
//  ContentView.swift
//  Slate
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var products: [Product]
    @Query private var profiles: [UserProfile]
    
    @State private var showCheckoutLogin = false
    @State private var showSuccessScreen = false

    var basketTotal: Double {
        products.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if products.isEmpty {
                    ContentUnavailableView(
                        "Your Basket is Empty",
                        systemImage: "cart",
                        description: Text("Start adding some clothes from the Shop!")
                    )
                } else {
                    List {
                        ForEach(products) { product in
                            ProductRow(
                                product: product,
                                quantity: product.quantity,
                                onIncrement: {
                                    product.quantity += 1
                                    try? modelContext.save()
                                },
                                onDecrement: {
                                    if product.quantity > 1 {
                                        product.quantity -= 1
                                    } else {
                                        modelContext.delete(product)
                                    }
                                    try? modelContext.save()
                                }
                            )
                        }
                        .onDelete(perform: deleteProducts)
                    }
                    .listStyle(.plain)

                    VStack(spacing: 12) {
                        HStack {
                            Text("Total:")
                                .font(.headline)
                            Spacer()
                            Text("£\(basketTotal, specifier: "%.2f")")
                                .font(.title2)
                                .bold()
                        }
                        .padding(.horizontal)

                        Button(action: { showCheckoutLogin = true }) {
                            Text("CHECKOUT")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.pink)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    .background(.background)
                }
            }
            .navigationTitle("Basket")
            .sheet(isPresented: $showCheckoutLogin) {
                CheckoutLoginView(onCheckoutComplete: {
                    let refNumber = "#SL-\(Int.random(in: 100000...999999))"
                    let totalItems = products.reduce(0) { $0 + $1.quantity }

                    // Save to Order History ONLY if user profile exists
                    if !profiles.isEmpty {
                        let newOrder = Order(orderReference: refNumber, totalAmount: basketTotal, itemCount: totalItems)
                        modelContext.insert(newOrder)
                    }

                    // Always clear Basket
                    for product in products {
                        modelContext.delete(product)
                    }
                    try? modelContext.save()

                    showCheckoutLogin = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showSuccessScreen = true
                    }
                })
            }
            .fullScreenCover(isPresented: $showSuccessScreen) {
                OrderSuccessView(onDismiss: {
                    showSuccessScreen = false
                })
            }
        }
    }

    private func deleteProducts(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(products[index])
        }
        try? modelContext.save()
    }
}
