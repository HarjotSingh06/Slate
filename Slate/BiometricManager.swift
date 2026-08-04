//
//  BiometricManager.swift
//  Slate
//
//  Created by Harjot Singh on 14/07/2026.
//

import Foundation
import LocalAuthentication

class BiometricManager {
    static let shared = BiometricManager()
    private init() {}
    
    /// Checks if FaceID or TouchID is configured and available on the device.
    var isBiometricsAvailable: Bool {
        let context = LAContext()
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    /// Requests the user to authenticate using biometrics.
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // Ensure biometrics can be evaluated
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authorize your secure checkout."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // Return result on the main queue to safely update SwiftUI states
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        } else {
            // Biometrics not available on device (e.g. Simulator without it enrolled, or disabled)
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}
