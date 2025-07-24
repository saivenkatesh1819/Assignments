//
//  PaymentViewModel.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/11/25.
//


//run in terminal
//stripe login
//curl https://api.stripe.com/v1/payment_intents \
// -u sk_test_SecretKey: \
// -d amount=3000 \
// -d currency=usd \
// -d "payment_method_types[]"=card

import Stripe
import Foundation
import SwiftUI
import StripePaymentSheet



class PaymentViewModel: ObservableObject {
    @Published var isPaymentCompleted = false
    private var paymentSheet: PaymentSheet?

    func presentPaymentSheet(for product: ProductModel) {
        let clientSecret = "pi_3RjmXfRuYJaM4uYe0yynS49O_secret_VPGCIWB1Op2RpE8EJtLXSxwvS" // Replace with your PaymentIntent client secret

        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Adidas Lite"
        // Apple Pay configuration commented out for now
        // configuration.applePay = .init(merchantId: "your.merchant.id", merchantCountryCode: "US")

        DispatchQueue.main.async {
            self.paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: configuration)

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                self.paymentSheet?.present(from: rootVC) { result in
                    switch result {
                    case .completed:
                        self.isPaymentCompleted = true
                        print("✅ Payment completed")
                    case .canceled:
                        print("❌ Payment canceled")
                    case .failed(let error):
                        print("❌ Payment failed: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

