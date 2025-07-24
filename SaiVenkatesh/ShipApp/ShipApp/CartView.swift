//
//  CartView.swift
//  ShipApp
//
//  Created by Sai Voruganti on 7/17/25.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel = CartViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Cart...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else if viewModel.cartItems.isEmpty {
                    Text("Your cart is empty.")
                        .font(.title2)
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(viewModel.cartItems) { item in
                            CartItemRow(item: item) { action in
                                switch action {
                                case .modify:
                                    viewModel.modifyCartItem(item: item)
                                case .remove:
                                    viewModel.removeCartItem(item: item)
                                case .priceDetails:
                                    print("Show price details for \(item.name)")
                                }
                            }
                            .listRowSeparator(.hidden)
                            .padding(.vertical, 5)
                        }
                    }
                    .listStyle(.plain)
                }

                Spacer()

                OrderSummaryView(totalPrice: viewModel.orderTotal)
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                Button(action: {
                    print("Proceed to Checkout")
                }) {
                    Text("Checkout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        print("Dismiss Cart")
                    }) {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Day 1 • Ship time: 11:41 AM")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Cart")
                            .font(.headline)
                    }
                }
            }
            .onAppear {
                viewModel.fetchCartData()
            }
        }
    }
}
