//
//  LoginView.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/3/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Adidas Lite")
                .font(.largeTitle)
            Button("Login with Adidas") {
                authVM.login()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}
