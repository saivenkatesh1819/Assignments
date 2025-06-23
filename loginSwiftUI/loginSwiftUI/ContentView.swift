//
//  ContentView.swift
//  loginSwiftUI
//
//  Created by Sai Voruganti on 5/27/25.
//

import SwiftUI

enum Screen {
    case countryListView
    case loginFailed
}

struct ContentView: View {
    @State var userName = ""
    @State var password = ""
    @State private var isLogin: Bool = false
    @State var path: [Screen] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack{
                LoginPage(userName: $userName, password: $password, onLogin: onLogin)
            }.navigationDestination(for: Screen.self ) { screen in
                switch screen {
                case .countryListView:
                    CountryListView()
                    
                case .loginFailed :
                    Text("Error Screen")
                }
            }
        }
    }
        func onLogin() {
            if userName == "123" && password == "123" {
                print("Login Successfully")
                path.append(.countryListView)
            } else {
                print("Login Failed")
                path.append(.loginFailed)
            }
        }
    
    
}
#Preview {
    ContentView()
}
