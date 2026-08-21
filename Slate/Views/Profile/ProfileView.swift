//
//  ProfileView.swift
//  Slate
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var addressLine1 = ""
    @State private var city = ""
    @State private var postCode = ""
    @State private var showSaveAlert = false
    @State private var showSignOutAlert = false

    private var activeProfile: UserProfile? {
        profiles.first
    }

    private var isProfileSaved: Bool {
        activeProfile != nil
    }

    private var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return "SL"
    }

    var body: some View {
        NavigationStack {
            List {
                // Header Profile Card
                Section {
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(Color.pink.opacity(0.15))
                                .frame(width: 72, height: 72)
                            
                            Text(fullName.isEmpty ? "SL" : initials)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.pink)
                        }
                        
                        Text(fullName.isEmpty ? "Your Name" : fullName)
                            .font(.headline)
                        
                        Text(email.isEmpty ? "add.email@example.com" : email)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                .listRowBackground(Color.clear)

                // Personal Details
                Section("Personal Details") {
                    TextField("Full Name", text: $fullName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                // Shipping Address
                Section("Shipping Address") {
                    TextField("Address Line 1", text: $addressLine1)
                    TextField("City", text: $city)
                    TextField("Postcode", text: $postCode)
                        .autocapitalization(.allCharacters)
                }
                
                // Save Action
                Section {
                    Button(action: saveProfile) {
                        Text(isProfileSaved ? "Update Profile" : "Save Profile")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.pink)
                    }
                }
                
                // App Information
                Section("App Information") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
                
                // Sign Out Section (Only visible when a profile is saved)
                if isProfileSaved {
                    Section {
                        Button(action: { showSignOutAlert = true }) {
                            Text("Sign Out")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: loadProfile)
            .alert("Profile Saved", isPresented: $showSaveAlert) {
                Button("OK", role: .cancel) {}
            }
            .alert("Sign Out", isPresented: $showSignOutAlert) {
                Button("Sign Out", role: .destructive, action: signOut)
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to sign out? This will clear your saved personal information and basket.")
            }
        }
    }

    private func loadProfile() {
        if let profile = activeProfile {
            fullName = profile.fullName
            email = profile.email
            addressLine1 = profile.addressLine1
            city = profile.city
            postCode = profile.postCode
        }
    }

    private func saveProfile() {
        if let profile = activeProfile {
            profile.fullName = fullName
            profile.email = email
            profile.addressLine1 = addressLine1
            profile.city = city
            profile.postCode = postCode
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

    private func signOut() {
        // 1. Clear saved user profile
        if let profile = activeProfile {
            modelContext.delete(profile)
        }
        
        // 2. Clear all items from Basket and Order History
        do {
            let fetchProducts = FetchDescriptor<Product>()
            let products = try modelContext.fetch(fetchProducts)
            for product in products {
                modelContext.delete(product)
            }
            
            let fetchOrders = FetchDescriptor<Order>()
            let orders = try modelContext.fetch(fetchOrders)
            for order in orders {
                modelContext.delete(order)
            }
            
            try modelContext.save()
        } catch {
            print("Failed to clear data on sign out: \(error)")
        }
        
        // 3. Reset form text fields
        fullName = ""
        email = ""
        addressLine1 = ""
        city = ""
        postCode = ""
    }
}
