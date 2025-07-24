//
//  AuthViewModel.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/3/25.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    
    var oauthManager = OAuthManager()
    
    func login() {
        oauthManager.startLogin { success in
            DispatchQueue.main.async {
                self.isLoggedIn = success
            }
        }
    }
}

