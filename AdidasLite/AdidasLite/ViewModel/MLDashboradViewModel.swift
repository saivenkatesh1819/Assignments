//
//  MLDashboradViewModel.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/2/25.
//
import SwiftUI

class ProductListViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var images: [UUID: UIImage] = [:]
    @Published var predictions: [UUID: String] = [:]
    
    private var footwearService = FootwearService()
    private var imageLoader = ImageLoader()
    private var imageClassifier = ImageClassifier()
    
    func fetchProductsAndClassify() {
        footwearService.fetchMaleFootwear { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                    self?.loadImagesAndClassify(products: products)
                case .failure(let error):
                    print("API Error:", error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImagesAndClassify(products: [ProductModel]) {
        for product in products {
            imageLoader.loadImage(from: product.image) { [weak self] image in
                DispatchQueue.main.async {
                    if let image = image {
                        self?.images[product.id] = image
                        self?.classifyImage(image, for: product)
                    } else {
                        print("Failed to load image for \(product.description)")
                    }
                }
            }
        }
    }
    
    private func classifyImage(_ image: UIImage, for product: ProductModel) {
        imageClassifier.classify(image: image) { [weak self] prediction in
            DispatchQueue.main.async {
                self?.predictions[product.id] = prediction
            }
        }
    }
}

extension ProductListViewModel {
    func setDependencies(footwearService: FootwearService, imageLoader: ImageLoader, imageClassifier: ImageClassifier) {
         self.footwearService = footwearService
         self.imageLoader = imageLoader
         self.imageClassifier = imageClassifier
    }
}

