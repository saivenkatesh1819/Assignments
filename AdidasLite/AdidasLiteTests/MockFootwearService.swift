//
//  MockFootwearService.swift
//  AdidasLiteTests
//
//  Created by Sai Voruganti on 7/7/25.
//

import Foundation
@testable import AdidasLite

class MockFootwearService: FootwearService {
    override func fetchMaleFootwear(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let sample = ProductModel(
            brand: "TestBrand",
            description: "Test Shoe",
            image: "https://example.com/test.jpg",
            price: "$100",
            tag: "Men"
        )
        completion(.success([sample]))
    }
}
