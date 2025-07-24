//
//  MoyaAPIService.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/1/25.
//


import Moya
import Foundation

enum FootwearAPI {
    case getMaleFootwear
}

extension FootwearAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://ecommerce-api3.p.rapidapi.com")!
    }
    
    var path: String {
        switch self {
        case .getMaleFootwear:
            return "/malefootwear"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return [
            "x-rapidapi-key": "97693c5c7fmsh75b8af4b9022e60p1872a6jsnc113335c4d34",
            "x-rapidapi-host": "ecommerce-api3.p.rapidapi.com"
        ]
    }
    
    var sampleData: Data {
        return Data() // for unit testing or preview
    }
}
