
//
//  OrderHistoryView.swift
//  Slate
//

import SwiftUI
import SwiftData

struct OrderHistoryView: View {
    @Query(sort: \Order.date, order: .reverse) private var orders: [Order]

    var body: some View {
        NavigationStack {
            Group {
                if orders.isEmpty {
                    ContentUnavailableView(
                        "No Orders Yet",
                        systemImage: "clock",
                        description: Text("Completed purchases will appear here.")
                    )
                } else {
                    List(orders) { order in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Order \(order.orderReference)")
                                    .font(.headline)
                                Spacer()
                                Text("£\(order.totalAmount, specifier: "%.2f")")
                                    .font(.headline)
                                    .foregroundColor(.pink)
                            }
                            
                            HStack {
                                Text("\(order.itemCount) \(order.itemCount == 1 ? "item" : "items")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(order.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Order History")
        }
    }
}
