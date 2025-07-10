//
//  AdidasLiteTests.swift
//  AdidasLiteTests
//
//  Created by Sai Voruganti on 7/1/25.
//

import Testing
@testable import AdidasLite

import XCTest
@testable import AdidasLite

final class ProductListViewModelTests: XCTestCase {
    
    func testFetchProductsAndClassifyLoadsData() {
        // Given
        let viewModel = ProductListViewModel()
        viewModel.setDependencies(
            footwearService: MockFootwearService(),
            imageLoader: MockImageLoader(),
            imageClassifier: MockImageClassifier()
        )
        
        let expectation = XCTestExpectation(description: "Fetch and classify products")
        
        // When
        viewModel.fetchProductsAndClassify()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Then
            XCTAssertEqual(viewModel.products.count, 1)
            let product = viewModel.products.first!
            XCTAssertNotNil(viewModel.images[product.id])
            XCTAssertEqual(viewModel.predictions[product.id], "Sneaker")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}

