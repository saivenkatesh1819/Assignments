//
//  ShipAppTests.swift
//  ShipAppTests
//
//  Created by Sai Voruganti on 7/17/25.
//

import XCTest
import Testing
@testable import ShipApp


class CartViewModelTests: XCTestCase {

    var viewModel: CartViewModel!

    override func setUpWithError() throws {
        viewModel = CartViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFetchCartDataSuccess() {
        let expectation = XCTestExpectation(description: "Fetch cart data successfully")
        viewModel.fetchCartData()

        // Wait for a short period to allow async operation to complete
        // Adjust timeout if the async operation takes longer
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.errorMessage)
            XCTAssertFalse(self.viewModel.cartItems.isEmpty)
            XCTAssertEqual(self.viewModel.cartItems.count, 2, "Expected 2 items in cart based on mock data")
            XCTAssertEqual(self.viewModel.orderTotal, 447.00, "Expected order total to match mock data")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testRemoveCartItem() {
        // Initialize with some mock data for testing removal
        viewModel.cartItems = [
            CartItem(id: "1", name: "Test Item 1", imageURL: URL(string: "https://example.com")!, guests: 1, day: "Day 1", time: "10:00am", price: 100.00),
            CartItem(id: "2", name: "Test Item 2", imageURL: URL(string: "https://example.com")!, guests: 2, day: "Day 2", time: "11:00am", price: 200.00)
        ]
        viewModel.orderTotal = 300.00

        let itemToRemove = viewModel.cartItems[0]
        viewModel.removeCartItem(item: itemToRemove)

        XCTAssertEqual(viewModel.cartItems.count, 1, "Expected one item to be removed")
        XCTAssertEqual(viewModel.orderTotal, 200.00, "Expected order total to decrease by removed item's price")
        XCTAssertFalse(viewModel.cartItems.contains(where: { $0.id == itemToRemove.id }), "Removed item should not be in cart")
    }

    func testRemoveNonExistentCartItem() {
        viewModel.cartItems = [
            CartItem(id: "1", name: "Test Item 1", imageURL: URL(string: "https://example.com")!, guests: 1, day: "Day 1", time: "10:00am", price: 100.00)
        ]
        viewModel.orderTotal = 100.00

        let nonExistentItem = CartItem(id: "99", name: "Non Existent", imageURL: URL(string: "https://example.com")!, guests: 1, day: "Day X", time: "00:00am", price: 50.00)
        viewModel.removeCartItem(item: nonExistentItem)

        XCTAssertEqual(viewModel.cartItems.count, 1, "Cart item count should remain unchanged")
        XCTAssertEqual(viewModel.orderTotal, 100.00, "Order total should remain unchanged")
    }
}
