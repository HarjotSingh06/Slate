//
//  ContentView.swift
//  Slate
//
//  Created by Harjot Singh on 08/05/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    // Switched to ProductViewModel to unify your shopping cart state!
    @State private var viewModel: ProductViewModel?
    @State private var showCheckoutLogin = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    if let vm = viewModel, !vm.products.isEmpty {
                        ForEach(vm.products) { product in
                            // Insert our gorgeous interactive ProductRow!
                            ProductRow(
                                product: product,
                                quantity: product.quantity,
                                onIncrement: {
                                    vm.incrementQuantity(for: product)
                                },
                                onDecrement: {
                                    vm.decrementQuantity(for: product)
                                }
                            )
                        }
                        .onDelete(perform: vm.deleteProduct)
                    } else {
                        ContentUnavailableView(
                            "Your Basket is Empty",
                            systemImage: "cart",
                            description: Text("Start adding some clothes from the Shop!")
                        )
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Basket")
            .safeAreaInset(edge: .bottom) {
                if let vm = viewModel, !vm.products.isEmpty {
                    VStack(spacing: 12) {
                        Divider()
                        HStack {
                            Text("Total:").font(.headline)
                            Spacer()
                            // Uses our clean computed basketTotal property from the ViewModel!
                            Text("£\(vm.basketTotal, specifier: "%.2f")")
                                .font(.title2)
                                .bold()
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            showCheckoutLogin = true
                        }) {
                            Text("CHECKOUT")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    .background(.background)
                }
            }
            .sheet(isPresented: $showCheckoutLogin) {
                            CheckoutLoginView(onCheckoutComplete: {
                                viewModel?.clearBasket() // Empties SwiftData when checkout succeeds!
                            })
                }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = ProductViewModel(modelContext: modelContext)
            } else {
                viewModel?.fetchProducts()
            }
        }
    }
}
