//
//  ProductRow.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//
import SwiftUI

struct ProductRow: View {
    let product: Product // Uses the Product model we updated
    
    var body: some View {
        HStack(spacing: 16) {
            // Placeholder for Product Image as seen in your catalogue grid
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "tshirt")
                        .foregroundColor(.gray)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.system(size: 16, weight: .semibold))
                
                // Formatting currency to 2 decimal places
                Text("£\(product.price, specifier: "%.2f")")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Stepper Control to match your 'Basket' screen recording
            HStack(spacing: 12) {
                Button(action: { /* Decrease logic */ }) {
                    Image(systemName: "minus.circle")
                        .font(.title3)
                }
                
                Text("1") // Quantity placeholder
                    .font(.headline)
                    .frame(minWidth: 20)
                
                Button(action: { /* Increase logic */ }) {
                    Image(systemName: "plus.circle")
                        .font(.title3)
                }
            }
            .foregroundColor(.blue) // Matches the button color in your video
        }
        .padding(.vertical, 8)
    }
}
