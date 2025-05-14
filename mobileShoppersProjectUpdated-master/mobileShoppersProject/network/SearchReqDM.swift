//
//  SearchReqDM.swift
//  mobileShoppersProject
//
//  Created by Hasan Zaidi on 5/7/25.
//

import Foundation



// https://www.abercrombie.com/

struct SearchRequest: RequestType {
    var path: String?
    var baseURL: String = "https://www.abercrombie.com"
    var httpMethod: HTTPMethod = .get
    var params: [String : String]?
    var header: [String : String]? = nil

    static func createRequest(path: String?)-> SearchRequest {
        let fullPath = "/shop/us/\(path ?? "/shop/us/")"
        let request = SearchRequest(path: fullPath)
        return request
    }
    
    static func createRequest(path: String?, text: String)-> SearchRequest {
        let fullPath = "/shop/us/\(path ?? "/shop/us/")"
        let param = ["q":text, "format":"json", "pretty":"1"]
        let request = SearchRequest(path: fullPath, params: param)
        return request
    }

}
