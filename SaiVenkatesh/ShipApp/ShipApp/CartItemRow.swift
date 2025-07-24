//
//  CartItemRow.swift
//  ShipApp
//
//  Created by Sai Voruganti on 7/17/25.
//

import SwiftUI

enum CartItemAction {
    case modify
    case remove
    case priceDetails // Added for the "Price details >" button
}

struct CartItemRow: View {
    let item: CartItem
    let actionHandler: (CartItemAction) -> Void

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .lineLimit(1)

                HStack {
                    Text("Guests")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(item.guests) guests")
                        .font(.subheadline)
                }
                HStack {
                    Text("Day")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(item.day)
                        .font(.subheadline)
                }
                HStack {
                    Text("Time")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(item.time)
                        .font(.subheadline)
                }
                Text("$\(item.price, specifier: "%.2f")")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 5)

                Button(action: {
                    actionHandler(.priceDetails)
                }) {
                    Text("Price details >")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }

            Spacer()

            VStack {
                AsyncImage(url: item.imageURL) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 80, height: 80)
                         .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }

                Button(action: {
                    actionHandler(.modify)
                }) {
                    Text("Modify")
                        .font(.caption)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                }
                .padding(.top, 5)

                Button(action: {
                    actionHandler(.remove)
                }) {
                    Text("Remove")
                        .font(.caption)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(5)
                }
                .padding(.top, 2)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
