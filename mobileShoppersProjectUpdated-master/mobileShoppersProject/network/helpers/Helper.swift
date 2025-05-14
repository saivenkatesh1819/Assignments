//
//  Helper.swift
//  mobileShoppersProject
//
//  Created by Hasan Zaidi on 5/7/25.
//

import Foundation



// Put getter and setters in here
protocol RequestType {
    var baseURL: String { get set}
    var path: String? { get set}
    var httpMethod: HTTPMethod { get set}
    var params: [String: String]? { get set}
    var header: [String: String]? { get set}
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension RequestType {
    func createReq() -> URLRequest? {
        var urlComponents =  URLComponents(string: baseURL + (path ?? "/shop/us/"))
        if httpMethod == .get {
            urlComponents?.queryItems = params?.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        guard let _url = urlComponents?.url else {
            return nil
        }
        var request = URLRequest(url: _url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = header
        
        return request
    }
}
