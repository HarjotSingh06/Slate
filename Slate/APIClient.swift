//
//  APIClient.swift
//  Slate
//
//  Created by Harjot Singh on 14/05/2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class APIClient {
    // Mocking a retail product fetch
    func fetchProducts() async throws -> [String] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        return ["iPhone 17 Pro", "MacBook Pro M4", "iPad Air", "Apple Watch"]
    }
}
