//
//  CheckoutLoginView.swift
//  Slate
//
//  Created by Harjot Singh on 14/07/2026.
//

import SwiftUI

struct CheckoutLoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showSuccessScreen = false // Toggles the checkout success screen
    
    // Callback to empty the basket in the parent view
    var onCheckoutComplete: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                
                // Keep your gorgeous custom Header
                Image(systemName: "lock.shield")
                    .font(.system(size: 72))
                    .foregroundColor(.pink)
                
                Text("Secure Checkout")
                    .font(.title)
                    .bold()
                
                // Interactive guest checkout buttons
                VStack(spacing: 16) {
                    Button(action: {
                        // 1. Clear the basket database
                        onCheckoutComplete()
                        // 2. Trigger success overlay sheet
                        showSuccessScreen = true
                    }) {
                        Text("Checkout as Guest")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            // Presents the Order Success screen over the login sheet seamlessly!
            .fullScreenCover(isPresented: $showSuccessScreen) {
                OrderSuccessView(onDismiss: {
                    dismiss() // Dismisses this login screen too, returning back to the Shop tab!
                })
            }
        }
    }
}
