//
//  CountriesViewModel.swift
//  CountriesApp
//

import Foundation
class CountriesViewModel {
    
    private let repository: CountryRepository
    private(set) var countries: [Country] = []
    var didUpdate: (() -> Void)?

    init(repository: CountryRepository = CountryRepositoryImpl()) {
        self.repository = repository
    }

    func fetchCountries() {
        repository.fetchCountries { [weak self] countries in
            DispatchQueue.main.async {
                self?.countries = countries
                self?.didUpdate?()
            }
        }
    }

    func country(at index: Int) -> Country {
        countries[index]
    }

    var count: Int {
        countries.count
    }
}
