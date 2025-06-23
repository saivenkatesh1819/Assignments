//
//  Networkmanager.swift
//  CountriesApp
//
//  Created by Sai Voruganti on 5/25/25.
//



import Foundation

protocol CountryServiceProtocol {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}

class CountryService: CountryServiceProtocol {
    
    private let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json s"
    
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}

