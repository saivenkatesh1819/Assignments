//
//  AuthViewModelTests.swift
//  AdidasLiteTests
//
//  Created by Sai Voruganti on 7/7/25.
//

import XCTest
@testable import AdidasLite

final class AuthViewModelTests: XCTestCase {
    
    func testLoginSetsIsLoggedInTrue() {
        let viewModel = AuthViewModel()
        viewModel.oauthManager = MockOAuthManager()
        
        let expectation = XCTestExpectation(description: "OAuth login success")
        
        viewModel.login()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(viewModel.isLoggedIn)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}

