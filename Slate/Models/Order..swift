//
//  Order.swift
//  Slate
//

import Foundation
import SwiftData

@Model
final class Order {
    var id: UUID
    var orderReference: String
    var date: Date
    var totalAmount: Double
    var itemCount: Int
    
    init(orderReference: String, totalAmount: Double, itemCount: Int) {
        self.id = UUID()
        self.orderReference = orderReference
        self.date = Date()
        self.totalAmount = totalAmount
        self.itemCount = itemCount
    }
}
