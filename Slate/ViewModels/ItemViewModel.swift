//
//  ItemViewModel.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//
import Foundation
import Observation
import SwiftData

@Observable
@MainActor
class ItemViewModel {
    var items: [Product] = []
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchLocalItems()
    }
    
    func fetchLocalItems() {
        // Sorting by name to avoid the missing 'timestamp' crash
        let descriptor = FetchDescriptor<Product>(sortBy: [SortDescriptor(\.name)])
        items = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func addToBasket(name: String, price: Double) {
        // Senior-level approach: check if item exists, update quantity, or insert fresh
        if let existingItem = items.first(where: { $0.name == name }) {
            existingItem.quantity += 1
        } else {
            let newItem = Product(name: name, price: price, quantity: 1)
            modelContext.insert(newItem)
        }
        
        try? modelContext.save()
        fetchLocalItems() // Instantly syncs across tabs
    }
    
    func deleteProduct(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(items[index])
        }
        fetchLocalItems()
    }
}
