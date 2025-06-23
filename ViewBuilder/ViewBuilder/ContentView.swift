//
//  ContentView.swift
//  ViewBuilder
//
//  Created by Sai Voruganti on 6/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height

            orientationStack(isLandscape: isLandscape)
                .padding()
        }
    }

    @ViewBuilder
    func orientationStack(isLandscape: Bool) -> some View {
        if isLandscape {
            HStack(spacing: 16) {
                let names = ["Apple", "Book", "Car", "Dog"]

                ForEach(names, id: \.self) { name in
                    Text(name)
                        .padding()
                        .frame(width: 100, height: 50)
                        
                }
            }
        } else {
            VStack(spacing: 16) {
                let names = ["Apple", "Book", "Car", "Dog"]

                ForEach(names, id: \.self) { name in
                    Text(name)
                        .padding()
                        .frame(width: 100, height: 50)
                        
                }
            }
        }
    }

}

#Preview {
    ContentView()
}

