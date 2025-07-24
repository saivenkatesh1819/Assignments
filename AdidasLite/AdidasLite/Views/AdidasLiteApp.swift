//
//  AdidasLiteApp.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/1/25.
//
//
import SwiftUI
import StripeCore

@main
struct AdidasLiteApp: App {
    init() {
        StripeAPI.defaultPublishableKey = "pk_test_51RjPHXRuYJaM4uYeS1R0VryCznn7UfIt9c8po6PqZSZsu7BUTbYMql6X7GBfEvzdhSuq2CWV9FY7KSLUIzZVEoYl007p5NHy4G"
    }

    @StateObject private var authVM = AuthViewModel()
    @StateObject private var biometricAuth = BiometricAuthManager()

    var body: some Scene {
            WindowGroup {
                NavigationStack {
                    if authVM.isLoggedIn || biometricAuth.isAuthenticated {
                        ProductListView()
                            .navigationBarBackButtonHidden(true)
                    } else {
                        LoginView()
                            .environmentObject(authVM)
                            .environmentObject(biometricAuth)
                    }
                }
            }
        }
    }
