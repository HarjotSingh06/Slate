//
//  OrderSuccessView.swift
//  Slate
//
//  Created by Harjot Singh on 14/07/2026.
//

import SwiftUI

struct OrderSuccessView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var animateCheckmark = false
    @State private var animateText = false
    
    var onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Animated Checkmark Ring
            ZStack {
                Circle()
                    .stroke(Color.pink.opacity(0.2), lineWidth: 4)
                    .frame(width: 100, height: 100)
                
                Circle()
                    .trim(from: 0, to: animateCheckmark ? 1 : 0)
                    .stroke(Color.pink, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                
                Image(systemName: "checkmark")
                    .font(.system(size: 44, weight: .bold))
                    .foregroundColor(.pink)
                    .scaleEffect(animateCheckmark ? 1.0 : 0.2)
            }
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0)) {
                    animateCheckmark = true
                }
            }
            
            VStack(spacing: 8) {
                Text("Order Placed Successfully!")
                    .font(.title2)
                    .bold()
                    .opacity(animateText ? 1 : 0)
                    .offset(y: animateText ? 0 : 10)
                
                Text("Your items are on the way. Order reference: #SL-\(Int.random(in: 100000...999999))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .opacity(animateText ? 1 : 0)
                    .offset(y: animateText ? 0 : 10)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.5).delay(0.3)) {
                    animateText = true
                }
            }
            
            Spacer()
            
            Button(action: {
                onDismiss()
                dismiss()
            }) {
                Text("Keep Shopping")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .background(Color(.systemBackground))
    }
}
