//
//  WelcomeView..swift
//  Slate
//
//  Created by Harjot Singh on 21/08/2026.
//
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject private var theme: ConfigManager
    var onGetStarted: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            // Dynamic Brand Hero Icon
            ZStack {
                Circle()
                    .fill(theme.primaryColor.opacity(0.12))
                    .frame(width: 120, height: 120)

                Image(systemName: "bag.fill.badge.plus")
                    .font(.system(size: 50))
                    .foregroundColor(theme.primaryColor)
            }

            // Welcome Text
            VStack(spacing: 8) {
                Text("Welcome to \(theme.selectedBrand.rawValue.components(separatedBy: " ").first ?? "Slate")")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

                Text("Discover curated collections, instant checkout, and personalized shopping tailored for you.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()

            // Get Started Action Button
            Button(action: onGetStarted) {
                Text("GET STARTED")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(theme.primaryColor)
                    .cornerRadius(12)
                    .shadow(color: theme.primaryColor.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
    }
}
