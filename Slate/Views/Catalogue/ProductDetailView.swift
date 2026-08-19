//
//  ProductDetailView.swift
//  Slate
//

import SwiftUI
import SwiftData

struct ProductDetailView: View {
    let name: String
    let price: Double
    
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: ProductViewModel?
    @State private var selectedSize = "M"
    @State private var addedToCartNotice = false
    
    private let hapticFeedback = UINotificationFeedbackGenerator()
    private let sizes = ["XS", "S", "M", "L", "XL"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Large Visual Canvas
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.08))
                    .frame(height: 280)
                    .overlay(
                        Image(systemName: Product(name: name, price: price).iconName)
                            .font(.system(size: 90))
                            .foregroundColor(.black.opacity(0.75))
                    )
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(name)
                            .font(.title)
                            .bold()
                        Spacer()
                        Text("£\(price, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.pink)
                    }
                    
                    Text("Premium heavy-weight cotton build designed for standard fit and everyday durability.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider().padding(.vertical, 8)
                    
                    // Size Selector
                    Text("Select Size")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        ForEach(sizes, id: \.self) { size in
                            Button(action: { selectedSize = size }) {
                                Text(size)
                                    .fontWeight(.semibold)
                                    .frame(width: 50, height: 50)
                                    .background(selectedSize == size ? Color.pink : Color.gray.opacity(0.12))
                                    .foregroundColor(selectedSize == size ? .white : .primary)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                hapticFeedback.notificationOccurred(.success)
                let sizeTitle = "\(name) (\(selectedSize))"
                viewModel?.addToBasket(name: sizeTitle, price: price)
                
                withAnimation {
                    addedToCartNotice = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        addedToCartNotice = false
                    }
                }
            }) {
                HStack {
                    Image(systemName: addedToCartNotice ? "checkmark.circle.fill" : "bag.badge.plus")
                    Text(addedToCartNotice ? "Added to Basket!" : "Add to Basket — £\(price, specifier: "%.2f")")
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(addedToCartNotice ? Color.green : Color.pink)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            .background(.background)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = ProductViewModel(modelContext: modelContext)
            }
        }
    }
}
