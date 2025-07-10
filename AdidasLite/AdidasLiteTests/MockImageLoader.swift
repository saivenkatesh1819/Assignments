//
//  MockImageLoader.swift
//  AdidasLiteTests
//
//  Created by Sai Voruganti on 7/7/25.
//

import UIKit
import Foundation
@testable import AdidasLite


class MockImageLoader: ImageLoader {
    override func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let dummyImage = UIImage(systemName: "photo")!
        completion(dummyImage)
    }
}
