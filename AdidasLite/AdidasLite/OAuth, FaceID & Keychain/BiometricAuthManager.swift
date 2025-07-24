//
//  BiometricAuthManager.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/24/25.
//

import LocalAuthentication
import Foundation

class BiometricAuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var authError: String?

    func authenticateWithBiometrics(completion: (() -> Void)? = nil) {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            authError = "Biometric authentication not available"
            completion?()
            return
        }

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login with Face ID") { success, authError in
            DispatchQueue.main.async {
                if success {
                    self.isAuthenticated = true
                    self.authError = nil
                } else {
                    self.isAuthenticated = false
                    self.authError = authError?.localizedDescription ?? "Unknown error"
                }
                completion?()
            }
        }
    }
}
