//
//  LoginView.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/3/25.
////

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var biometricAuth: BiometricAuthManager

    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome to Adidas Lite")
                .font(.largeTitle)
                .multilineTextAlignment(.center)

            // 🔐 Face ID Button
            Button("Unlock with Face ID") {
                biometricAuth.authenticateWithBiometrics()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            // 👤 Adidas Login Button
            Button("Login with Adidas") {
                authVM.login()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            // ❗️ Show biometric error (if any)
            if let error = biometricAuth.authError {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}
