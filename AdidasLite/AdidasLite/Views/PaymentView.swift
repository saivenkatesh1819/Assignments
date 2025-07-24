//
//  SwiftUIView.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/10/25.
//

import SwiftUI

struct PaymentView: View {
    @StateObject var viewModel = PaymentViewModel()
    let product: ProductModel   

    var body: some View {
        VStack(spacing: 20) {
            Button("Pay \(product.price) with Stripe") {
                viewModel.presentPaymentSheet(for: product)              }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .alert(isPresented: $viewModel.isPaymentCompleted) {
            Alert(title: Text("Payment Successful"),
                  message: Text("Thank you for buying \(product.description)!"),
                  dismissButton: .default(Text("OK")))
        }
    }
}
