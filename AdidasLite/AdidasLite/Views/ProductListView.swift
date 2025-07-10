//
//  ProductListView.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/2/25.
//


import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                HStack(spacing: 15) {
                    if let uiImage = viewModel.images[product.id] {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                            .overlay(Text("Loading...").font(.caption))
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.brand)
                            .font(.headline)
                            .accessibilityIdentifier("Brand_\(product.id)")

                        Text(product.description)
                            .font(.subheadline)
                        Text(product.price)
                            .font(.subheadline)
                            .foregroundColor(.green)
                        
                        if let prediction = viewModel.predictions[product.id] {
                            Text("ML Prediction: \(prediction)")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .lineLimit(1)
                                .accessibilityIdentifier("Prediction_\(product.id)")

                        } else {
                            Text("Classifying...")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Adidas Lite")
            .onAppear {
                viewModel.fetchProductsAndClassify()
            }
        }
    }
}
