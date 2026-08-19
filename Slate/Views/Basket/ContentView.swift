//
//  ContentView.swift
//  Slate
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var products: [Product]
    @State private var viewModel: ProductViewModel?
    
    // Checkout sheet navigation states
    @State private var showCheckoutLogin = false
    @State private var showSuccessScreen = false

    var basketTotal: Double {
        products.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    var body: some View {
        NavigationStack {
            Group {
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
                                    viewModel?.incrementQuantity(for: product)
                                },
                                onDecrement: {
                                    viewModel?.decrementQuantity(for: product)
                                }
                            )
                        }
                        .onDelete { indexSet in
                            viewModel?.deleteProduct(at: indexSet)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Basket")
            .safeAreaInset(edge: .bottom) {
                if !products.isEmpty {
                    VStack(spacing: 12) {
                        Divider()
                        
                        HStack {
                            Text("Total:").font(.headline)
                            Spacer()
                            Text("£\(basketTotal, specifier: "%.2f")")
                                .font(.title2)
                                .bold()
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            showCheckoutLogin = true
                        }) {
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
            .sheet(isPresented: $showCheckoutLogin) {
                CheckoutLoginView(onCheckoutComplete: {
                    // Save to Order History
                    let refNumber = "#SL-\(Int.random(in: 100000...999999))"
                    let totalItems = products.reduce(0) { $0 + $1.quantity }
                    let newOrder = Order(orderReference: refNumber, totalAmount: basketTotal, itemCount: totalItems)
                    modelContext.insert(newOrder)

                    // Clear Basket
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
        .onAppear {
            if viewModel == nil {
                viewModel = ProductViewModel(modelContext: modelContext)
            }
        }
    }
}
