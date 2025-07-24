//
//  APIService.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/1/25.
//


import Foundation
import Alamofire
import Moya

class APIService {
    
    static let shared = APIService()
    
    private init() {}

    func fetchMaleFootwear(completion: @escaping (Result<[ProductModel], AFError>) -> Void) {
        let url = "https://ecommerce-api3.p.rapidapi.com/malefootwear"
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "97693c5c7fmsh75b8af4b9022e60p1872a6jsnc113335c4d34",
            "x-rapidapi-host": "ecommerce-api3.p.rapidapi.com"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [ProductModel].self) { response in
                completion(response.result)
            }
            }
}





public class FootwearService {
    
    private let provider = MoyaProvider<FootwearAPI>()
    
    func fetchMaleFootwear(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        provider.request(.getMaleFootwear) { result in
            switch result {
            case .success(let response):
                do {
                    let products = try JSONDecoder().decode([ProductModel].self, from: response.data)
                    completion(.success(products))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let moyaError):
                completion(.failure(moyaError))
            }
        }
    }
}
