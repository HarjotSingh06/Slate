//
//  ProductRow.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    let quantity: Int
    
    var onIncrement: () -> Void
    var onDecrement: () -> Void
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        HStack(spacing: 16) { // Increased spacing slightly for better visual separation
            // 1. Product Image - Switched to a standard frame with fixed dimensions
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.15))
                
                Image(systemName: product.iconName)
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
            }
            .frame(width: 50, height: 50) // Strictly bounds the ZStack container
            
            // 2. Product Info - Wrapped text in a fixed-width-friendly structure
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text("£\(product.price, specifier: "%.2f")")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Forces text to claim all available left-side space
            
            // 3. Stepper Control
            HStack(spacing: 12) {
                Button(action: {
                    impactFeedback.impactOccurred()
                    onDecrement()
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title3)
                }
                .buttonStyle(.borderless)
                
                Text("\(quantity)")
                    .font(.headline)
                    .frame(width: 24) // Replaced minWidth with fixed width to prevent shifting
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    impactFeedback.impactOccurred()
                    onIncrement()
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title3)
                }
                .buttonStyle(.borderless)
            }
            .foregroundColor(.blue)
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle()) // Ensures the whole row block behaves correctly under List selection
    }
}
