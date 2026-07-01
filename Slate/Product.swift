//
//  Item.swift
//  Slate
//
//  Created by Harjot Singh on 08/05/2026.
//

import Foundation
import SwiftData

@Model
class Product {
    var name: String
    var price: Double
    var quantity: Int
    
    init(name: String, price: Double, quantity: Int = 1) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}
