//
//  OrdersView.swift
//  Slate
//
//  Created by Harjot Singh on 21/08/2026.
//


import SwiftUI
import SwiftData

struct OrdersView: View {
    @Query private var orders: [Order]

    var body: some View {
        NavigationStack {
            Group {
                if orders.isEmpty {
                    ContentUnavailableView(
                        "No Past Orders",
                        systemImage: "bag",
                        description: Text("Complete a purchase from your Basket to view order history.")
                    )
                } else {
                    List(orders) { order in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(order.orderReference)
                                    .font(.headline)
                                Spacer()
                                Text("£\(order.totalAmount, specifier: "%.2f")")
                                    .font(.headline)
                            }
                            
                            HStack {
                                Text("\(order.itemCount) item(s)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Orders")
        }
    }
}
