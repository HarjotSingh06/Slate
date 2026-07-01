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
}
