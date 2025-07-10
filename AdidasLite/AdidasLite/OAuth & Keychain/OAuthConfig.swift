//
//  File.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/3/25.
//

import Foundation

struct OAuthConfig {
    static let clientID = "your-client-id"
    static let clientSecret = "your-client-secret"
    static let authorizeURL = URL(string: "https://httpbin.org/redirect-to?url=adidaslite://oauth-callback?code=abc123")!
    static let tokenURL = URL(string: "https://mock.oauth.server/token")!
    static let redirectURI = "adidaslite://oauth-callback"
    static let scope = "profile email"
    static let responseType = "code"
}
