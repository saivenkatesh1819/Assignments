//
//  AdidasLiteApp.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/1/25.
//

import SwiftUI

@main
struct AdidasLiteApp: App {
    @StateObject private var authVM = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if authVM.isLoggedIn {
                    ProductListView()
                } else {
                    LoginView()
                        .environmentObject(authVM)
                }
            }
           
        }
    }
}
