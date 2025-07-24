//
//  CartItem.swift
//  ShipApp
//
//  Created by Sai Voruganti on 7/17/25.
//

import Foundation

struct CartItem: Identifiable, Codable {
    let id: String
    let name: String
    let imageURL: URL
    let guests: Int
    let day: String
    let time: String
    let price: Double
}

struct CartData: Codable {
    let cartItems: [CartItem]
    let orderSummary: OrderSummary
}

struct OrderSummary: Codable {
    let totalPrice: Double
}
