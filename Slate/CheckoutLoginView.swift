//
//  CheckoutLoginView.swift
//  Slate
//
//  Created by Harjot Singh on 14/07/2026.
//

import SwiftUI

struct CheckoutLoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showSuccessScreen = false
    @State private var isProcessing = false // Triggers a mock processing/spinner phase
    
    var onCheckoutComplete: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Spacer()
                
                // Security Icon & Header
                VStack(spacing: 12) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.pink)
                    
                    Text("Secure Checkout")
                        .font(.title2)
                        .bold()
                    
                    Text("Authenticate with your device biometric credential to finalize your secure transaction.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Active Checkout Action Area
                VStack(spacing: 16) {
                    if isProcessing {
                        // High-fidelity loading state
                        ProgressView()
                            .scaleEffect(1.3)
                            .tint(.pink)
                            .frame(height: 56)
                    } else {
                        // One-Click Biometric Checkout Button
                        Button(action: {
                            handleBiometricCheckout()
                        }) {
                            HStack(spacing: 10) {
                                Image(systemName: "faceid")
                                    .font(.title3)
                                Text("Pay with Face ID")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.pink)
                            .cornerRadius(14)
                            .shadow(color: Color.pink.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        
                        // Guest Fallback Button
                        Button(action: {
                            handleManualCheckout()
                        }) {
                            Text("Checkout manually as Guest")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 4)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .fullScreenCover(isPresented: $showSuccessScreen) {
                OrderSuccessView(onDismiss: {
                    dismiss()
                })
            }
        }
    }
    
    private func handleBiometricCheckout() {
        // Trigger haptic rumble
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        
        BiometricManager.shared.authenticateUser { success in
            if success {
                isProcessing = true
                generator.notificationOccurred(.success)
                
                // Simulate a 1-second background transaction confirmation
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    isProcessing = false
                    onCheckoutComplete()
                    showSuccessScreen = true
                }
            } else {
                // If FaceID fails or isn't enabled (e.g. on your Simulator), fall back directly to manual guest checkout so your demo doesn't get stuck!
                handleManualCheckout()
            }
        }
    }
    
    private func handleManualCheckout() {
        isProcessing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            isProcessing = false
            onCheckoutComplete()
            showSuccessScreen = true
        }
    }
}
