//
//  OAuthManager.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/3/25.
//


import Foundation
import AuthenticationServices
import KeychainAccess

class OAuthManager: NSObject {
    
    private var session: ASWebAuthenticationSession?
    private let keychain = Keychain(service: "com.adidaslite.app")

    func startLogin(completion: @escaping (Bool) -> Void) {
        let authURL = OAuthConfig.authorizeURL

        session = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: "adidaslite"
        ) { callbackURL, error in
            guard error == nil else {
                completion(false)
                return
            }

            // Simulate receiving code from redirect URL
            let code = "abc123"
            self.exchangeCodeForToken(code: code) { success in
                completion(success)
            }
        }

        session?.presentationContextProvider = self
        session?.start()
    }

    private func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        let mockToken = "mock_access_token_\(code)"

        do {
            try keychain.set(mockToken, key: "access_token")
            print("💾 Saved token to Keychain: \(mockToken)")
            completion(true)
        } catch {
            print("❌ Failed to save token: \(error.localizedDescription)")
            completion(false)
        }
    }
}

extension OAuthManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first ?? UIWindow()
    }
}
