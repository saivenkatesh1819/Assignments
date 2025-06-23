//
//  NetworkManager.swift
//  Countries
//
//  Created by Yenat Feyyisa on 4/1/25.
//

import Foundation
protocol NetworkManagerProtocol {
    func fetchCountries<T: Decodable>(url: String, completion: @escaping (Result<T, Error>)-> Void)
}
final class NetworkManager: NetworkManagerProtocol {
    let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    func fetchCountries<T: Decodable>(url: String, completion: @escaping (Result<T, any Error>) -> Void)  {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        guard url.host != nil && url.scheme != nil else {
            completion(.failure(NetworkError.invalidURL))
            return 
        }
        URLSession.shared.dataTask(with: url) {data, _, _  in
            guard let data = data else {
                completion(.failure(NetworkError.decodingError))
                return 
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }

    
}

enum NetworkError: Error {
    case invalidURL, decodingError
}
