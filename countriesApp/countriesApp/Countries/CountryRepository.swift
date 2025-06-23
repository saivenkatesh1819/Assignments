//
//  CountryRepository.swift
//  CountriesApp
//
//  Created by Sai Voruganti on 5/25/25.
//


import Foundation

protocol CountryRepository {
    func fetchCountries(completion: @escaping ([Country]) -> Void)
}

final class CountryRepositoryImpl: CountryRepository {
    
    private let coreDataManager: CoreDataManager
    private let countryService: CountryServiceProtocol

    init(
        coreDataManager: CoreDataManager = .shared,
        countryService: CountryServiceProtocol = CountryService()
    ) {
        self.coreDataManager = coreDataManager
        self.countryService = countryService
    }

    func fetchCountries(completion: @escaping ([Country]) -> Void) {
        countryService.fetchCountries { [weak self] result in
            guard let self = self else { return }

            let context = self.coreDataManager.persistentContainer.viewContext

            switch result {
            case .success(let countries):
                CountryEntity.saveCountries(countries, moc: context)
                self.coreDataManager.saveContext()
                completion(countries)

            case .failure:
                let country = CountryEntity.getCountries(moc: context)
                completion(country)
            }
        }
    }
}
