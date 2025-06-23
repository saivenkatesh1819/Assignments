//
//  CountriesUITests.swift
//  CountriesUITests
//
//  Created by Yenat Feyyisa on 4/1/25.
//
//
//import XCTest
//import Combine
//@testable import Countries
//
//final class CountriesTests: XCTestCase {
//    
//    var viewModel: CountriesViewModel!
//    var mockNetworkManager: MockNetworkManager!
//    var cancellables: Set<AnyCancellable>!
//
//    override func setUp() {
//        super.setUp()
//        mockNetworkManager = MockNetworkManager()
//        viewModel = CountriesViewModel(networkManager: mockNetworkManager)
//        cancellables = []
//        continueAfterFailure = false
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDown() {
//        viewModel = nil
//        mockNetworkManager = nil
//        cancellables = nil
//        super.tearDown()
//    }
//    
//    func test_fetchCountries_returnsTrue() {
//        let expectedCountries = [
//            Country(capital: "Addis Ababa", code: "ET", name: "Ethiopia", region: "North Africa"),
//            Country(capital: "Tokyo", code: "JP", name: "Japan", region: "Pacific"),
//        ]
//        mockNetworkManager.mockCountries = expectedCountries
//
//        viewModel.$filteredCountries
//            .dropFirst()
//            .sink { countries in
//                XCTAssertEqual(countries.count, expectedCountries.count)
//                XCTAssertEqual(countries.first?.name, "Ethiopia")
//            }
//            .store(in: &cancellables)
//    }
//}
import XCTest
import Combine
@testable import Countries

final class CountriesTests: XCTestCase {

    var viewModel: CountriesViewModel!
    var mockNetworkManager: MockNetworkManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = CountriesViewModel(networkManager: mockNetworkManager)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchCountries_returnsExpectedResults() {
        let expectation = self.expectation(description: "Countries fetched")

        let expectedCountries = [
            Country(capital: "Addis Ababa", code: "ET", name: "Ethiopia", region: "North Africa"),
            Country(capital: "Tokyo", code: "JP", name: "Japan", region: "Pacific"),
        ]

        mockNetworkManager.mockCountries = expectedCountries

        viewModel = CountriesViewModel(networkManager: mockNetworkManager) // recreate with correct mock

        viewModel.$filteredCountries
            .dropFirst()
            .sink { countries in
                XCTAssertEqual(countries.count, expectedCountries.count)
                XCTAssertEqual(countries.first?.name, "Ethiopia")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchCountries() // ✅ must be after setting mockCountries

        wait(for: [expectation], timeout: 2.0)
    }


}
