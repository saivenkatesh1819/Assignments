//
//  ImageClassifier.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/2/25.
//

import UIKit
import Vision
import CoreML

class ImageClassifier {
    private let model: VNCoreMLModel?

    init() {
        self.model = try? VNCoreMLModel(for: MobileNetV2().model)
    }

    func classify(image: UIImage, completion: @escaping (String) -> Void) {
        guard let ciImage = CIImage(image: image),
              let model = model else {
            completion("Failed to load image or model")
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation],
               let topResult = results.first {
                completion("\(topResult.identifier) (\(Int(topResult.confidence * 100))%)")
            } else {
                completion("Unable to classify image")
            }
        }

        let handler = VNImageRequestHandler(ciImage: ciImage)
        try? handler.perform([request])
    }
}
