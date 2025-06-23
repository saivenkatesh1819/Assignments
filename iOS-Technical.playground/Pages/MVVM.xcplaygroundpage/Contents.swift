//: [Previous](@previous)
/*:
 ## MVVM
 Given the following **model** `ContentModel` and [MECE](https://en.wikipedia.org/wiki/MECE_principle) **view** previews, write an accompanying **view model** practicing a TDD approach.
 */
import Foundation
import UIKit
/*
 An immutable representation of the `Content` data type.
 */
import Foundation

struct ContentModel {
    let id: String
    let imageURL: URL
    let brand: String
    let title: String
    let subtitle: String?
    let expiryDate: Date
}

class ContentViewModel {
    var contentView: [ContentModel] = [
        ContentModel(
            id: "001",
            imageURL: URL(string: "https://example.com/image1.jpg")!,
            brand: "Nike",
            title: "Air Max 90",
            subtitle: "Limited Edition",
            expiryDate: Date(timeIntervalSinceNow: 86400 * 30) // 30 days from now
        ),
        ContentModel(
            id: "002",
            imageURL: URL(string: "https://example.com/image2.jpg")!,
            brand: "Adidas",
            title: "Ultraboost",
            subtitle: nil,
            expiryDate: Date(timeIntervalSinceNow: -86400 * 60) // 60 days ago
        ),
        ContentModel(
            id: "003",
            imageURL: URL(string: "https://example.com/image3.jpg")!,
            brand: "Apple",
            title: "iPhone Case",
            subtitle: "New Arrival",
            expiryDate: Date(timeIntervalSinceNow: 86400 * 15) // 15 days from now
        )
    ]
    func expiredContentStatus() -> [String] {
        let now = Date()
        let calendar = Calendar.current
        
        return contentView.map { content in
            if content.expiryDate <= now {
                return "\(content.title): Expired"
            } else {
                let days = calendar.dateComponents([.day], from: now, to: content.expiryDate).day ?? 0
                return "\(content.title): Expires in \(days) day\(days == 1 ? "" : "s")"
            }
        }
    }
    
}

/*:
 ## View preview
 When content `expiryDate` is in the future.
 
 ![Content Card Active](active.png)
 
 When content `expiryDate` is now or in the past.
 
 ![Content Card Expired](expired.png)
 */
import XCTest

class ContentViewModelTests: XCTestCase {

    func test_expiredContentStatus_returnsCorrectMessages() {
        let viewModel = ContentViewModel()
        let result = viewModel.expiredContentStatus()

        XCTAssertTrue(result.contains("Ultraboost: Expired"))
        XCTAssertTrue(result.contains(where: { $0.starts(with: "Air Max 90: Expires in") }))
        XCTAssertTrue(result.contains(where: { $0.starts(with: "iPhone Case: Expires in") }))
    }
}

ContentViewModelTests.defaultTestSuite.run()
//: [Next](@next)
