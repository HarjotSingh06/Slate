//
//  ProductDetailView.swift
//  Slate
//
//  Created by Harjot Singh on 19/08/2026.
//

import SwiftUI
import SwiftData

struct ProductDetailView: View {
    let name: String
    let price: Double
    @Environment(\.modelContext) private var modelContext
    @State private var selectedSize = "M"
    
    let sizes = ["XS", "S", "M", "L", "XL"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 260)
                    .overlay(
                        Image(systemName: Product(name: name, price: price).iconName)
                            .font(.system(size: 80))
                    )
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text("£\(price, specifier: "%.2f")")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text("Select Size")
                        .font(.headline)
                        .padding(.top)
                    
                    HStack {
                        ForEach(sizes, id: \.self) { size in
                            Button(action: { selectedSize = size }) {
                                Text(size)
                                    .fontWeight(.semibold)
                                    .frame(width: 48, height: 48)
                                    .background(selectedSize == size ? Color.pink : Color.gray.opacity(0.15))
                                    .foregroundColor(selectedSize == size ? .white : .primary)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
