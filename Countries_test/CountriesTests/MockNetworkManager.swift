//
//  MockNetworkManager.swift
//  Countries
//
//  Created by Hasan Zaidi on 6/2/25.
//

import Foundation
//@testable import Countries
//
//class MockNetworkManager: NetworkManagerProtocol {
//    var mockCountries: [Country] = []
//    public func fetchCountries<T>(url: String, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
//        completion(.failure(NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])))
//        completion(.success(mockCountries as! T))
//    }
//}

class MockNetworkManager: NetworkManagerProtocol {
    var mockCountries: [Country] = []

    func fetchCountries<T>(url: String, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        let result = mockCountries as! T
        completion(.success(result))
    }
}

