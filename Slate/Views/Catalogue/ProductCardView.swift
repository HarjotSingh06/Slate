//
//  ProductCardView.swift
//  Slate
//
//  Created by Harjot Singh on 09/09/2026.
//

import SwiftUI

struct ProductCardView: View {
    let name: String
    let price: Double
    let imageName: String
    let accentColor: Color
    let onAdd: () -> Void
 
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.secondarySystemBackground))
                    .aspectRatio(0.82, contentMode: .fit)

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                Button {
                    // Favourite behaviour comes later
                } label: {
                    Image(systemName: "heart")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.primary)
                        .frame(width: 36, height: 36)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .padding(10)
            }

            Text(name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            HStack {
                Text("£\(price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)

                Spacer()

                Button(action: onAdd) {
                    Image(systemName: "plus")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 34, height: 34)
                        .background(accentColor)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
        }
    }
}
