//
//  OrderSummaryView.swift
//  ShipApp
//
//  Created by Sai Voruganti on 7/17/25.
//

import SwiftUI

struct OrderSummaryView: View {
    let totalPrice: Double

    var body: some View {
        VStack {
            Divider()
            HStack {
                Text("Order summary")
                    .font(.headline)
                Spacer()
                Text("$\(totalPrice, specifier: "%.2f")")
                    .font(.headline)
            }
            .padding(.vertical, 10)
        }
    }
}
