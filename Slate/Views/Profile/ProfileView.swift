//
//  ProfileView.swift
//  Slate
//


//
//  ProfileView.swift
//  Slate
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
        @EnvironmentObject private var theme: ConfigManager
        @Query private var userProfiles: [UserProfile]
        
        @AppStorage("hasSeenWelcome") private var hasSeenWelcome = true
        
        @State private var fullName: String = ""
        @State private var email: String = ""
        @State private var addressLine1: String = ""
        @State private var city: String = ""
        @State private var postCode: String = ""
        
        @State private var showSaveAlert = false
        @State private var showSignOutAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                // Profile Header
                Section {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(theme.primaryColor.opacity(0.15))
                                .frame(width: 60, height: 60)
                            
                            Text(userInitials)
                                .font(.title2)
                                .bold()
                                .foregroundColor(theme.primaryColor)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(fullName.isEmpty ? "Your Name" : fullName)
                                .font(.headline)
                            Text(email.isEmpty ? "add.email@example.com" : email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // White Label Theme Switcher
                Section(header: Text("White Label Theme")) {
                    Picker("Active Client", selection: $theme.selectedBrand) {
                        ForEach(ClientBrand.allCases, id: \.self) { brand in
                            Text(brand.rawValue).tag(brand)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(theme.primaryColor)
                }
                
                // Personal Details
                Section(header: Text("Personal Details")) {
                    TextField("Full Name", text: $fullName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                // Shipping Address
                Section(header: Text("Shipping Address")) {
                    TextField("Address Line 1", text: $addressLine1)
                    TextField("City", text: $city)
                    TextField("Postcode", text: $postCode)
                }
                
                // Save Actions
                Section {
                    Button(action: saveProfile) {
                        Text(userProfiles.isEmpty ? "Save Profile" : "Update Profile")
                            .font(.headline)
                            .foregroundColor(theme.primaryColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                // Sign Out
                Section {
                    Button(action: { showSignOutAlert = true }) {
                        Text("Sign Out")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                // App Information
                Section(header: Text("App Information")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Profile")
            .onAppear(perform: loadProfileData)
            .alert("Profile Saved", isPresented: $showSaveAlert) {
                Button("OK", role: .cancel) { }
            }
            .alert("Sign Out", isPresented: $showSignOutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive, action: performSignOut)
            } message: {
                Text("Are you sure you want to sign out? This will clear your saved personal information, basket, and order history.")
            }
        }
    }
    
    private var userInitials: String {
        let components = fullName.split(separator: " ")
        if components.count >= 2, let first = components.first?.first, let last = components.last?.first {
            return "\(first)\(last)".uppercased()
        } else if let first = fullName.first {
            return String(first).uppercased()
        }
        return "SL"
    }
    
    private func loadProfileData() {
        if let existing = userProfiles.first {
            fullName = existing.fullName
            email = existing.email
            addressLine1 = existing.addressLine1
            city = existing.city
            postCode = existing.postCode
        }
    }
    
    private func saveProfile() {
        if let existing = userProfiles.first {
            existing.fullName = fullName
            existing.email = email
            existing.addressLine1 = addressLine1
            existing.city = city
            existing.postCode = postCode
        } else {
            let newProfile = UserProfile(
                fullName: fullName,
                email: email,
                addressLine1: addressLine1,
                city: city,
                postCode: postCode
            )
            modelContext.insert(newProfile)
        }
        try? modelContext.save()
        showSaveAlert = true
    }
    
    private func performSignOut() {
        try? modelContext.delete(model: UserProfile.self)
        try? modelContext.delete(model: Product.self)
        try? modelContext.delete(model: Order.self)
        try? modelContext.save()
        
        fullName = ""
        email = ""
        addressLine1 = ""
        city = ""
        postCode = ""
        
        withAnimation {
            hasSeenWelcome = false
        }
    }
}
