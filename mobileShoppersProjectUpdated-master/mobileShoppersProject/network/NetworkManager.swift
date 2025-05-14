//
//  NetworkManager.swift
//  mobileShoppersProject
//
//  Created by Hasan Zaidi on 5/7/25.
//

import Foundation


protocol ServiceManager {
    func performApiCall<T: Decodable>(
        request: RequestType,
        modelName: T.Type,
        completion: @escaping (Result<T, ApiError>) -> Void
    )
}

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case JSONParsingFailed
}

class NetworkManager {
    
    var delegate: ViewControllerProtocol?
    
    func performApiCall() {
        let urlString = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css"
            
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        print(url)

        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([DataModel].self, from: data)
//                guard let delegate = self.delegate else {
//                    print("delegate not found 😱")
//                    return }
                self.delegate?.refreshUI(with: decodedData)
            } catch {
                print("Decoding error:", error)
            }
        }
        task.resume()
    }
 
}


class MockNetworkManager: ServiceManager {
    func performApiCall<T>(request: RequestType, modelName: T.Type, completion: @escaping (Result<T, ApiError>) -> Void) where T : Decodable {
        
        guard let urlRequest = request.createReq() else {
            completion(.failure(.invalidURL))
            return
        }
        print("URL:", urlRequest)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let _data = data else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            do {
                let searchResponse = try JSONDecoder().decode(modelName.self,from: _data)
                completion(.success(searchResponse))
            } catch {
                completion(.failure(ApiError.JSONParsingFailed))
                print("Decoding error:", error)
            }
        }.resume()
    }
}
