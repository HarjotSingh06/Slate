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
    @State private var viewModel: ItemViewModel?
    @State private var showCheckoutLogin = false // Controls the sheet presentation

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    if let vm = viewModel, !vm.items.isEmpty {
                        ForEach(vm.items) { product in
                            HStack {
                                Image(systemName: "tshirt")
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading) {
                                    Text(product.name).font(.headline)
                                    Text("£\(product.price, specifier: "%.2f")").font(.subheadline).foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("x\(product.quantity)").fontWeight(.semibold)
                            }
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
                if let vm = viewModel, !vm.items.isEmpty {
                    VStack(spacing: 12) {
                        Divider()
                        HStack {
                            Text("Total:").font(.headline)
                            Spacer()
                            Text("£\(vm.items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }, specifier: "%.2f")")
                                .font(.title2)
                                .bold()
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            showCheckoutLogin = true // Trigger the login view modal
                        }) {
                            Text("CHECKOUT")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    .background(.background)
                }
            }
            // Present the modern Login/WIP screen as a modal sheet
            .sheet(isPresented: $showCheckoutLogin) { // Fixed: Changed '&' to '$'
                CheckoutLoginView()
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = ItemViewModel(modelContext: modelContext)
            } else {
                viewModel?.fetchLocalItems()
            }
        }
    }
}
