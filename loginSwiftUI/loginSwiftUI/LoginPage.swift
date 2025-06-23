//
//  LoginPage.swift
//  loginSwiftUI
//
//  Created by Sai Voruganti on 5/27/25.
//

import SwiftUI

struct LoginPage: View {
    @Binding var userName: String
    @Binding var password: String
    
    let onLogin: () -> Void
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            TextField("UserName", text: $userName)
                .overlay {
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(Color.blue, lineWidth: 1)
                }
                .cornerRadius(2.0)
                .padding()
            TextField("Password", text: $password)
                .overlay {
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(Color.blue, lineWidth: 1)
                }
                .cornerRadius(2.0)
                .padding()
            Button(action: onLogin){
                Text("Login")
            }
        }
        .padding()
    }
}

#Preview {
    //LoginPage()
}
