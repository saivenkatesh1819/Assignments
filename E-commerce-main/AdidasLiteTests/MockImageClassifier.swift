//
//  MockImageClassifier.swift
//  AdidasLiteTests
//
//  Created by Sai Voruganti on 7/7/25.
//

import UIKit
import Foundation
@testable import AdidasLite


class MockImageClassifier: ImageClassifier {
    override func classify(image: UIImage, completion: @escaping (String) -> Void) {
        completion("Sneaker")
    }
}
