//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Yenat Feyyisa on 4/1/25.
//

import Foundation
final class CountriesViewModel: ObservableObject  {
    // MARK: - Properties
    var countries: [Country] = []
    @Published var filteredCountries: [Country] = []
    @Published var errorMessage: String?
    private let networkManager: NetworkManagerProtocol
    // MARK: - initialization
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
        fetchCountries()
    }
}
// MARK: - fetching and filtering logic
extension CountriesViewModel {
    func fetchCountries() {
        networkManager
            .fetchCountries(url: EndPoint.countriesEndPoint) { [weak self] (result: Result<[Country], Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let countries):
                    self.countries = countries
                    self.filteredCountries = countries
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
    }
    func searchCountries(searchText text: String) {
        filteredCountries = text.isEmpty ? countries :
        countries.filter {
            $0.name.lowercased().contains(text.lowercased()) ||
            $0.capital.lowercased().contains(text.lowercased())
        }
    }
}


