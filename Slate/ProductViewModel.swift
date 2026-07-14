//
//  ProductViewModel.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//
import Foundation
import Observation
import SwiftData

@Observable
class ProductViewModel {
    var products: [Product] = []
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchProducts()
    }
    
    func fetchProducts() {
        let descriptor = FetchDescriptor<Product>(sortBy: [SortDescriptor(\.name)])
        products = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func addToBasket(name: String, price: Double) {
        // Logic: If already in basket, just add to quantity. Otherwise, insert new.
        if let existing = products.first(where: { $0.name == name }) {
            existing.quantity += 1
        } else {
            let newProduct = Product(name: name, price: price, quantity: 1)
            modelContext.insert(newProduct)
        }
        fetchProducts() // CRITICAL: Updates the list for the Basket tab
    }
    
    func deleteProduct(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(products[index])
        }
        fetchProducts()
    }
    
    func incrementQuantity(for product: Product) {
        product.quantity += 1
        try? modelContext.save() // Force save the update
        fetchProducts()
    }

    func decrementQuantity(for product: Product) {
        if product.quantity > 1 {
            product.quantity -= 1
            try? modelContext.save() // Force save the update
        } else {
            modelContext.delete(product)
            try? modelContext.save() // Force save the update
        }
        fetchProducts()
    }

    var basketTotal: Double {
        products.reduce(0) { total, product in
            total + (product.price * Double(product.quantity))
        }
    }
    
    func clearBasket() {
        for product in products {
            modelContext.delete(product)
        }
        try? modelContext.save()
        fetchProducts()
    }
}

