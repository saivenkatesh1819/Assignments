//
//  AdidasLiteUITests.swift
//  AdidasLiteUITests
//
//  Created by Sai Voruganti on 7/1/25.
//
import XCTest

final class AdidasLiteUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testProductListViewDisplaysProducts() throws {
    // Check for at least one product brand
        let brandElements = app.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH 'Brand_'"))
        let cell = brandElements.firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 5), "At least one product brand should be visible")

        // Optional: check ML prediction
        let predictionElements = app.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH 'Prediction_'"))
        let prediction = predictionElements.firstMatch
        XCTAssertTrue(prediction.exists, "Prediction label should be visible")
    }

}
