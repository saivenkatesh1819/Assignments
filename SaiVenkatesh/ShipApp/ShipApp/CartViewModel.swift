//
//  CartViewModel.swift
//  ShipApp
//
//  Created by Sai Voruganti on 7/17/25.
//

import Foundation
import Combine

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var orderTotal: Double = 0.0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchCartData() {
        isLoading = true
        errorMessage = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let url = Bundle.main.url(forResource: "mockCartData", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decodedData = try JSONDecoder().decode(CartData.self, from: data)
                    self.cartItems = decodedData.cartItems
                    self.orderTotal = decodedData.orderSummary.totalPrice
                    self.isLoading = false
                } catch {
                    self.errorMessage = "Failed to decode cart data: \(error.localizedDescription)"
                    self.isLoading = false
                    print(error.localizedDescription)
                }
            } else {
                self.errorMessage = "Mock JSON file not found."
                self.isLoading = false
            }
        }
    }

    func removeCartItem(item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            let removedItem = cartItems.remove(at: index)
            orderTotal -= removedItem.price
        }
    }

    func modifyCartItem(item: CartItem) {
        print("Modify item: \(item.name)")
        // In a real app, you would navigate to a modification screen or show a modal here.
    }
}
