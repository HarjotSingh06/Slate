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
        HStack(spacing: 12) {
            // 1. Product Image (Fixed size so it never gets squished)
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.15))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: product.iconName)
                        .font(.body)
                        .foregroundColor(.primary)
                )
            
            // 2. Product Info (Layout priority makes sure this gets space first)
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text("£\(product.price, specifier: "%.2f")")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .layoutPriority(1) // CRITICAL: Ensures text gets priority over spacer/stepper
            
            Spacer()
            
            // 3. Stepper Control (Pushed cleanly to the right side)
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
                    .frame(minWidth: 24)
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
        .padding(.vertical, 4)
    }
}
