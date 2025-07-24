//
//  BiometricAuthView.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/24/25.
//

import SwiftUI

struct BiometricAuthView: View {
    @EnvironmentObject var biometricAuth: BiometricAuthManager

    var body: some View {
        VStack(spacing: 20) {
            Button("Unlock with Face ID") {
                biometricAuth.authenticateWithBiometrics()
            }
            .buttonStyle(.borderedProminent)

            if let error = biometricAuth.authError {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .onAppear {
            biometricAuth.authenticateWithBiometrics()
        }
    }
}
 
