//
//  MockOAuthManager.swift
//  AdidasLiteTests
//
//  Created by Sai Voruganti on 7/7/25.
//

import Foundation
@testable import AdidasLite

class MockOAuthManager: OAuthManager {
    override func startLogin(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
