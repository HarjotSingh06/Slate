//
//  CheckoutLoginView.swift
//  Slate
//
//  Created by Harjot Singh on 15/05/2026.
//

import SwiftUI

struct CheckoutLoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Header / Branding
                VStack(spacing: 8) {
                    Image(systemName: "lock.shield")
                        .font(.system(size: 60))
                        .foregroundColor(.pink)
                        .padding(.top, 40)
                    
                    Text("Secure Checkout")
                        .font(.title2)
                        .bold()
                    
                    Text("Please sign in or continue as a guest to finish your secure payment.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                
                // WIP Notice Banner
                HStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Feature Under Development")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("Secure transactional integrations (WIP) are currently being finalized.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 24)
                
                VStack(spacing: 16) {
                    TextField("Email Address", text: $email) // Fixed: Using '$' instead of '&'
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password) // Fixed: Using '$' instead of '&'
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 24)
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        // Action placeholder for future logic
                    }) {
                        Text("Sign In & Continue")
                            .frame(maxWidth: .infinity)
                            .bold()
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Action placeholder for future logic
                    }) {
                        Text("Checkout as Guest")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear)
                            .foregroundColor(.pink)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.pink, lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.pink)
                }
            }
        }
    }
}
