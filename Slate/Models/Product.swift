//
//  Product.swift
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
    
    // This MUST sit inside the class brackets to access the `name` property!
    var iconName: String {
        let lowerName = name.lowercased()
        if lowerName.contains("shoe") || lowerName.contains("boot") || lowerName.contains("trainer") {
            return "shoe"
        } else if lowerName.contains("pant") || lowerName.contains("trouser") || lowerName.contains("jean") {
            return "hanger" // Universally supported clothing icon!
        } else {
            return "tshirt"
        }
    }
}
