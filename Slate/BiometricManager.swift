import LocalAuthentication

class BiometricManager {
    static let shared = BiometricManager()
    private init() {}

    func authenticateUser(completion: @escaping (Result<Bool, LAError>) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to complete your purchase securely."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        completion(.success(true))
                    } else if let laError = authError as? LAError {
                        completion(.failure(laError))
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(.failure(LAError(.biometryNotAvailable)))
            }
        }
    }
}
